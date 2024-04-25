#
# My Custom Prompt
#

# Get the name of the git repository
local git_repo_name() {
    gittopdir=$(git rev-parse --git-dir 2> /dev/null)
    if [[ "foo$gittopdir" == "foo.git" ]]; then
        echo `basename $(pwd)`
    elif [[ "foo$gittopdir" != "foo" ]]; then
        echo `dirname $gittopdir | xargs basename`
    fi
}

# Get the name of the branch
local git_branch_name() {
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}

# Build a concatenated folder path like fish prompt_pwd function
local prompt_pwd () {
  local p=${${PWD:/~/\~}/#~\//\~/}
  echo "${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}

# Check if the git repo is dirty
local git_is_dirty() {
  git diff --quiet 2> /dev/null || echo ' - X'
}

# Where the assembly magic happens
local set_prompt () {
  PROMPT="%F{green}$(prompt_pwd) %F{cyan}$(git_repo_name)%F{yellow}(%F{magenta}$(git_branch_name)%F{red}$(git_is_dirty)%F{yellow}) %F{white}==> "
}

# Add the function to the precmd_functions array
# so the prompt changes on any directory change
precmd_functions+=set_prompt
set_prompt
