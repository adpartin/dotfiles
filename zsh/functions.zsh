# Shell functions — sourced by zshrc

# Create a directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract common archive formats
extract() {
    if [[ ! -f "$1" ]]; then
        echo "extract: '$1' is not a file"
        return 1
    fi
    case "$1" in
        *.tar.bz2) tar xjf "$1"   ;;
        *.tar.gz)  tar xzf "$1"   ;;
        *.tar.xz)  tar xJf "$1"   ;;
        *.bz2)     bunzip2 "$1"   ;;
        *.gz)      gunzip "$1"    ;;
        *.tar)     tar xf "$1"    ;;
        *.tgz)     tar xzf "$1"   ;;
        *.zip)     unzip "$1"     ;;
        *.Z)       uncompress "$1";;
        *.7z)      7z x "$1"      ;;
        *)         echo "extract: unknown format '$1'" ;;
    esac
}
