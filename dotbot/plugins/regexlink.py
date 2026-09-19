import os
import re
import shutil
from typing import Any

from dotbot.plugin import Plugin  # pyright: ignore[reportMissingImports]


class RegexLink(Plugin):
    """
    Symlink every repo path whose base-relative name matches a regex.

    - regexlink:
        '.*/(.*)\\.configsymlink': '~/.config/\\1'
        '.*/(.*)\\.symlink':
          path: '~/.\\1'
          force: true

    Options (per rule, or under `defaults: regexlink:`):
      create  create parent directories of the link   (default: true)
      relink  replace an existing symlink             (default: false)
      force   replace an existing file or directory   (default: false)
    """

    supports_dry_run = True
    _directive = "regexlink"

    def can_handle(self, directive: str) -> bool:
        return directive == self._directive

    def handle(self, directive: str, data: Any) -> bool:
        if directive != self._directive:
            msg = f"RegexLink cannot handle directive {directive}"
            raise ValueError(msg)

        defaults = self._context.defaults().get(self._directive, {})
        base = self._context.base_directory()
        candidates = self._walk(base)

        success = True

        for pattern, value in data.items():
            options = dict(defaults)
            if isinstance(value, dict):
                options.update(value)
                template = options.pop("path")
            else:
                template = value

            matches = self._match(pattern, template, candidates)
            if not matches:
                self._log.warning(f"No paths matched {pattern}")
                success = False
                continue

            for source, dest in matches:
                success &= self._link(base, source, dest, options)

        if success:
            self._log.info("All regex links have been set up")
        else:
            self._log.error("Some regex links were not successfully set up")

        return success

    def _walk(self, base: str) -> list[str]:
        """
        Base-relative paths of every non-hidden file and directory.

        Hidden directories are pruned rather than skipped, so the walk never
        descends into .git.
        """
        found: list[str] = []

        for dirpath, dirnames, filenames in os.walk(base):
            dirnames[:] = sorted(d for d in dirnames if not d.startswith("."))
            visible = dirnames + sorted(f for f in filenames if not f.startswith("."))
            found.extend(
                os.path.relpath(os.path.join(dirpath, name), base) for name in visible
            )

        return found

    def _match(
        self, pattern: str, template: str, candidates: list[str]
    ) -> list[tuple[str, str]]:
        regex = re.compile(pattern)
        matches: list[tuple[str, str]] = []

        for relpath in candidates:
            found = regex.fullmatch(relpath)
            if found is None:
                continue
            dest = os.path.expandvars(os.path.expanduser(found.expand(template)))
            matches.append((relpath, os.path.abspath(dest)))

        return matches

    def _link(self, base: str, source: str, dest: str, options: dict[str, Any]) -> bool:
        create = options.get("create", True)
        relink = options.get("relink", False)
        force = options.get("force", False)
        dry_run = self._context.dry_run()
        absolute_source = os.path.join(base, source)

        if os.path.islink(dest):
            if os.path.realpath(dest) == os.path.realpath(absolute_source):
                self._log.info(f"Link exists {dest} -> {source}")
                return True
            if not (relink or force):
                self._log.warning(f"{dest} points elsewhere, set relink to replace it")
                return False
            if dry_run:
                self._log.action(f"Would remove stale link {dest}")
            else:
                os.unlink(dest)
        elif os.path.exists(dest):
            if not force:
                self._log.warning(
                    f"{dest} exists and is not a link, set force to replace it"
                )
                return False
            if dry_run:
                self._log.action(f"Would remove {dest}")
            elif os.path.isdir(dest):
                shutil.rmtree(dest)
            else:
                os.remove(dest)

        parent = os.path.dirname(dest)

        if not os.path.exists(parent):
            if not create:
                self._log.warning(f"Parent directory does not exist for {dest}")
                return False
            if dry_run:
                self._log.action(f"Would create directory {parent}")
            else:
                os.makedirs(parent)

        if dry_run:
            self._log.action(f"Would link {dest} -> {source}")
            return True

        try:
            os.symlink(absolute_source, dest)
        except OSError as e:
            self._log.warning(f"Linking failed {dest} -> {source} ({e})")
            return False

        self._log.action(f"Linked {dest} -> {source}")
        return True
