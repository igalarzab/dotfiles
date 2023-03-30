# The prompt seems fast enough, but keeping here just in case...
$ENABLE_ASYNC_PROMPT = False

# Dark theme
$XONSH_COLOR_STYLE = 'solarized-dark'

def prompt():
    "Trying to kind-of-mimic the 'pure' theme of zsh"

    python_env = '{YELLOW}{env_name}'
    directory = '{#5DC6FB}{short_cwd}'
    git_status = '{branch_color}{gitstatus}{RESET}'
    err_code = '{RED}{last_return_code_if_nonzero: [{}]}'
    prompt = '{BOLD_PURPLE}❯{RESET}'

    return f'{python_env} {directory} {git_status}\n{err_code} {prompt} '

$PROMPT = prompt()
