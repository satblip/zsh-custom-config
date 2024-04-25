#
# My docker aliases and functions
#

alias dcp="docker compose"
alias dockercleanup="docker system prune --volumes -f -a"

# Rebuild docker image
dcpRebuild() {
  docker compose stop $argv
  docker compose rm -v -f $argv
  docker compose build $argv;
}
