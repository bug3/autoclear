
# Define autoclear script
source /usr/share/autoclear/autoclear.sh

# Run ls when cd
function cd {
    builtin cd "$@" && ls
}
