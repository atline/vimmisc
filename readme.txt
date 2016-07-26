(I) Software
1.  sudo add-apt-repository ppa:nmi/vim-snapshots
    sudo apt-get install vim
2.  sudo apt-get install exuberant-ctags
3.  sudo apt-get install cscope

(II) Configure
For windows, copy _vimrc to /path/to/vim, for linux, rename _vimrc to .vimrc & copy it to ~/.vimrc

(III) Plugin
1. NERDTree:
Issue(on linux):
Messy code
Fix:
Just need to do next in linux, The-NERD-tree\plugin\NERD_tree.vim
call s:initVariable("g:NERDTreeDirArrows", !nerdtree#runningWindows())
->
call s:initVariable("g:NERDTreeDirArrows", nerdtree#runningWindows())

2. visualmask:
Issue(on linux):
E197: Cannot set language to "en_US"
Fix:
Just need to do next in linux, Visual-Mark\plugin\visualmark.vim
exec ":lan mes en_US" -> exec ":lan mes en_US.utf8"

3. vim-go:
3.1 For gocode etc support, need do :GoInstallBinaries, need to set GOPATH, and could move download binaries to GOROOT/bin

4. YouCompleteMe:
(https://github.com/Valloric/YouCompleteMe)
It's so big, if time limit or bad network, could disable it.
4.1 Vim 7.3.598 with python2 or python3 support, if cannot find, can build it by yourself
    (https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
4.1 sudo apt-get install build-essential
    (must support c++11)
4.2 sudo apt-get install python-dev
    (had better use system python, not self compile python, otherwise ycm server may die without any log)
4.3 sudo add-apt-repository ppa:kalakris/cmake
    sudo apt-get install cmake 
    (cmake must be greater than 2.8.11)
4.4 sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt-get install libstdc++6
    strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep GLIBCXX, confirm we have GLIBCXX_3.4.18 or something like, if not, :YcmDebugInfo may tell you.
4.5 cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    (If fail to fetch ycm code, git clone for yourself, then git submodule update --init --recursive)
4.6 let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    (otherwise, it will report "ValueError: Still no compile flags, no completions yet.")

5. Neocomplete:
(https://github.com/Shougo/neocomplete.vim)
5.1 May conflict with folding for fdm=syntax
5.2 VIm 7.3.885+
5.3 vim --version, must support lua, had better thant
    For linux, do sudo apt-get install vim-nox vim-gtk vim-gnome vim-athena, could fix lua
5.4 It will make Ctrl+n no effect for some language
