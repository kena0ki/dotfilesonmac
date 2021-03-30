#!/bin/zsh -eu

# https://gist.github.com/misraX/7ff0483ecaf84d476c194730740d6abe

echo -n "Input work directory (default to home) >> "
read WORKDIR
echo
test -z "$WORKDIR" && WORKDIR=~
test ! -e "$WORKDIR" && mkdir "$WORKDIR"
LOGFILE="$PWD"/"$WORKDIR"/vim/viminstall.log

cd "$WORKDIR"
test ! -e vim && git clone https://github.com/vim/vim.git
cd vim
git pull
make distclean # if you build Vim before
#PYTHON3CONF=/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/config-3.6m-darwin # for python3 installed by offcial website
PYTHON3CONF=/usr/local/Cellar/python/3.7.7/Frameworks/Python.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin # for python3 installed using homebrew
./configure \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --with-ruby-command=`which ruby` \
    --enable-python3interp \
    --with-python3-config-dir="$PYTHON3CONF" \
    --enable-cscope \
    --enable-gui=auto \
    --with-features=huge \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --enable-fail-if-missing \
    --prefix=/usr/local | tee "$LOGFILE"
    # --with-x \ # X11 is no longer included with Mac. https://support.apple.com/en-gb/HT201341
echo
echo -n "OK to make? Hit Enter to continue."; read A
make >> "$LOGFILE"
cd src
./vim --version
echo -n "OK to make install? Hit Enter to continue."; read A
VIMPATH=`which vim`
if [ -n $VIMPATH ]; then
 BKUPPATH="$VIMPATH"`date +%s`
 sudo cp -p "$VIMPATH" "$VIMPATH"`date +%s` # back up current vim
 echo "Old vim was backed up to $BKUPPATH."
fi
sudo make install >> "$LOGFILE"
echo
echo "Done!! Log file: $LOGFILE"

exit
