. $HOME/.z.sh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git git-flow golang ruby rails rbenv bower brew bundler last-working-dir npm node osx web-search z)
source $ZSH/oh-my-zsh.sh
export EDITOR="vim"
export TERM "xterm"
export PYTHONPATH="$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# aliases {{{
alias v="vim"
alias zshconfig="vim ~/.zshrc"
alias c="clear"
alias s="sudo"
alias home="cd $HOME"
alias root="cd /"
alias grep="grep -nI --color"
alias gam="git commit -am"
alias zx="compress"
alias ex="extract"
alias lx="list_compressed"
# }}} aliases

# functions {{{
function cssmin() { # compress css file
  curl -X POST -s --data-urlencode "input@$1.css" http://cssminifier.com/raw > $1.min.css
}

function compress() { # compress a file or folder
    case "$1" in
       tar.xz)           tar xJvf  "${2%%/}.tar.xz"  "${2%%/}/"  ;;
       tar.bz2|.tar.bz2) tar cvjf "${2%%/}.tar.bz2" "${2%%/}/"  ;;
       tbz2|.tbz2)       tar cvjf "${2%%/}.tbz2" "${2%%/}/"     ;;
       tbz|.tbz)         tar cvjf "${2%%/}.tbz" "${2%%/}/"      ;;
       tar.gz|.tar.gz)   tar cvzf "${2%%/}.tar.gz" "${2%%/}/"   ;;
       tgz|.tgz)         tar cvjf "${2%%/}.tgz" "${2%%/}/"      ;;
       tar|.tar)         tar cvf  "${2%%/}.tar" "${2%%/}/"      ;;
       rar|.rar)         rar a "${2}.rar" "$2"                  ;;
       zip|.zip)         zip -9 "${2}.zip" "$2"                 ;;
       7z|.7z)           7z a "${2}.7z" "$2"                    ;;
       lzo|.lzo)         lzop -v "$2"                           ;;
       gz|.gz)           gzip -v "$2"                           ;;
       bz2|.bz2)         bzip2 -v "$2"                          ;;
       xz|.xz)           xz -v "$2"                             ;;
       lzma|.lzma)       lzma -v "$2"                           ;;
       *)           echo "ac(): compress a file or directory."
            echo "Usage:   compress <archive type> <filename>"
            echo "Example: compress tar.bz2 PKGBUILD"
            echo "Please specify archive type and source."
            echo "Valid archive types are:"
            echo "tar.xz, tar.bz2, tar.gz, tar, bz2, gz, tbz2, tbz,"
            echo "tgz, lzo, rar, zip, 7z, xz and lzma." ;;
    esac
}

function extract() { # decompress archive (to directory $2 if wished for and possible)
   if [ -f "$1" ] ; then
       case "$1" in
       *.tar.zx)          mkdir -v "$2" 2>/dev/null ; tar Jxf "$1" -C "$2"  ;;
       *.tar.bz2|*.tgz|*.tbz2|*.tbz) mkdir -v "$2" 2>/dev/null ; tar xvjf "$1" -C "$2" ;;
       *.tar.gz)          mkdir -v "$2" 2>/dev/null ; tar xvzf "$1" -C "$2" ;;
       *.tar)             mkdir -v "$2" 2>/dev/null ; tar xvf "$1"  -C "$2" ;;
       *.rar)             mkdir -v "$2" 2>/dev/null ; rar x   "$1"  "$2"    ;;
       *.zip)             mkdir -v "$2" 2>/dev/null ; unzip   "$1"  -d "$2" ;;
       *.7z)              mkdir -v "$2" 2>/dev/null ; 7z x    "$1"  -o"$2"  ;;
       *.lzo)             mkdir -v "$2" 2>/dev/null ; lzop -d "$1"  -p"$2"  ;;
       *.gz)              gunzip "$1"                                       ;;
       *.bz2)             bunzip2 "$1"                                      ;;
       *.Z)               uncompress "$1"                                   ;;
       *.xz|*.txz|*.lzma|*.tlz)     xz -d "$1"                              ;;
       *)
       esac
   else
            echo "Sorry, '$2' could not be decompressed."
            echo "Usage: extract <archive> <destination>"
            echo "Example: extract PKGBUILD.tar.bz2 ."
            echo "Valid archive types are:"
            echo "tar.xz, tar.bz2, tar.gz, tar, bz2,"
            echo "gz, tbz2, tbz, tgz, lzo,"
            echo "rar, zip, 7z, xz and lzma"
   fi
}

function list_compressed() { # list content of archive but don't unpack
    if [ -f "$1" ]; then
         case "$1" in
       *.tar.xz)          tar -Jtf "$1"       ;;
       *.tar.bz2|*.tbz2|*.tbz) tar -jtf "$1"  ;;
       *.tar.gz)          tar -ztf "$1"       ;;
       *.tar|*.tgz)       tar -tf "$1"        ;;
       *.gz)              gzip -l "$1"        ;;
       *.rar)             rar vb "$1"         ;;
       *.zip)             unzip -l "$1"       ;;
       *.7z)              7z l "$1"           ;;
       *.lzo)             lzop -l "$1"        ;;
       *.xz|*.txz|*.lzma|*.tlz)      xz -l "$1"     ;;
         esac
    else
         echo "Sorry, '$1' is not a valid archive."
     echo "Valid archive types are:"
     echo "tar.xz, tar.bz2, tar.gz, tar, gz,"
     echo "tbz2, tbz, tgz, lzo, rar"
     echo "zip, 7z, xz and lzma"
    fi
}
# }}} functions

# autostart {{{
case $- in *i*)
  if [ -z "$TMUX" ]; then exec tmux; fi;;
esac
# }}}
