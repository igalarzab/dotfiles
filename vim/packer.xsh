packerPath = p'~/.local/share/nvim/site/pack/packer/start/packer.nvim'

if not packerPath.exists():
    git clone --depth 1 https://github.com/wbthomason/packer.nvim @(packerPath)

