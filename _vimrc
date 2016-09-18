" General
if has('win32')
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

syntax enable
syntax on

set nocp
set noundofile
set bs=2
set ruler
set nonu
set ts=4 sw=4
filetype plugin indent on
set ai nosi ci
set et sts=4
set sta
set ignorecase

"set helplang=cn
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8

" If internal messy code issue, may uncomment next
if has('win32')
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
endif

set nobackup
set history=50
set hls
set autowrite
set vb t_vb=
au GuiEnter * set t_vb=
set guioptions-=m
set guioptions-=T
set gcr=a:blinkon0

" Remove space at end
" highlight WhitespaceEOL ctermbg=red guibg=#00FFFF
" match WhitespaceEOL /\s\+$/
nmap <F7> :%s/\s*$//g<CR> :nohl<CR>

" Enable vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
filetype off
if has('win32')
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif

Plugin 'gmarik/vundle'
Plugin 'The-NERD-tree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Visual-Mark'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlp.vim'
Plugin 'The-NERD-Commenter'
Plugin 'brookhong/DBGPavim'
Plugin 'OmniCppComplete'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'easymotion/vim-easymotion'
Plugin 'atline/molokai'
Plugin 'FooSoft/vim-argwrap'
Plugin 'javacomplete'
Plugin 'Python-mode-klen'
Plugin 'davidhalter/jedi-vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'Shougo/neocomplete.vim'
filetype on

" Define scheme
if !has('win32')
    colorscheme desert | set gfn=Courier_New:h9
else
    colorscheme molokai | let g:molokai_original=1 | set gfn=Courier_New:h9
    autocmd FileType text colorscheme default | set gfn= | set guioptions+=m | set guioptions+=T
    nmap <F12> :colorscheme molokai<CR>
              \:let g:molokai_original=1<CR>
              \:set gfn=Courier_New:h9<CR>
              \:set guioptions-=m<CR>
              \:set guioptions-=T<CR>
endif

" Define leader key
let mapleader=';'

" NerdTree
map <Leader>n :NERDTreeMirror<CR>
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=30
let g:NERDTreeShowLineNumbers=1

" NerdCommenter
let NERDSpaceDelims=1
let NERDCompactSexyComs=1

" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <Leader>t :TagbarToggle<CR>

" MiniBufExplorer
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim=1 " different buffers change
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplTabWrap=1 "make tabs show complete
let g:miniBufExplModSelTarget=1

" ArgWrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Cscope & ctags
if has('cscope')
    "set csprg=/usr/bin/cscope
    set csto=1
    set cst

    " Add any database in current directory
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb

    set cscopequickfix=c-,d-,e-,f-,g-,i-,s-,t-
    nmap ,s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap ,g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap ,c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap ,t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap ,e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap ,f :cs find f <C-R>=expand("<cword>")<CR><CR>
    nmap ,i :cs find i <C-R>=expand("<cword>")<CR><CR>
    nmap ,d :cs find d <C-R>=expand("<cword>")<CR><CR>

    if has('win32')
        nmap <F8> :silent !dir /s/b *.c,*.cpp,*.h,*.java > cscope.files<CR>
                 \:silent !cscope -Rbk<CR>
                 \:silent !ctags -R --c++-kinds=+px --fields=+iaS --extra=+q<CR>
                 \:cs reset<CR><CR>
        nmap <F9> :silent !dir /s/b *.c,*.cpp,*.h,*.java > cscope.files<CR>
                 \:silent !cscope -Rbk<CR>
                 \:cs reset<CR><CR>
    else
        nmap <F8> :!find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.java'>cscope.files<CR>
                 \:!cscope -Rbkq<CR>
                 \:!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q<CR>
                 \:cs reset<CR><CR>
        nmap <F9> :!find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.java'>cscope.files<CR>
                 \:!cscope -Rbkq<CR>
                 \:cs reset<CR><CR>
    endif
endif

" Omni
set nocp
filetype plugin indent on
set completeopt=longest,menu

"autocmd FileType python set omnifunc=pythoncomplete#Complete " use jedi
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" Omni cpp
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_NamespaceSearch=1
let OmniCpp_DisplayMode=1
let OmniCpp_ShowScopeInAbbr=0
let OmniCpp_ShowPrototypeInAbbr=1
let OmniCpp_ShowAccess=1
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_MayCompleteScope=1

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" CtrlP
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*.class
nmap <Leader>f :CtrlP<CR>

" Python-mode
let ropevim_enable_shortcuts=1
let g:pymode_rope_goto_def_newwin="vnew"
let g:pymode_rope_extended_complete=1
let g:pymode_folding=0
let g:pymode_options_colorcolumn=0
let g:pymode_rope=0
let g:pymode_lint=0
let g:pymode_lint_checker="pyflakes,pep8,pep257"
let g:pymode_lint_ignore="E265,E501,E302"
let g:pymode_syntax=1
let g:pymode_syntax_all=1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
autocmd FileType python setlocal nonumber " disable line number

" Jedi
let g:jedi#completions_enabled=1
let g:jedi#goto_command=",d"
let g:jedi#goto_assignments_command=",g"
let g:jedi#goto_definitions_command=""
let g:jedi#documentation_command="K"
let g:jedi#usages_command=",n"
let g:jedi#completions_command="<C-Space>"
let g:jedi#rename_command=",r"
let g:jedi#popup_on_dot=1

" Color
highlight Pmenu ctermbg=DarkMagenta guibg=Brown
highlight PmenuSel ctermbg=gray guibg=gray ctermfg=black guifg=black
" highlight PmenuSel ctermbg=gray guibg=gray

" Disable hard break and enable soft break
autocmd FileType * setlocal textwidth=0
autocmd FileType * setlocal wrap

" Vim-indent-guides
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size=1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd guibg=red ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4

" Vimgrep key mapping
nnoremap <F3> :vimgrep /<C-R><C-W>/ **/*.* \| cw<CR>

" Mapping for open vimrc quickly
if has('win32')
    nmap <F1> :vsplit $VIM/_vimrc<CR>
else
    nmap <F1> :vsplit ~/.vimrc<CR>
endif

" Folding, zR for open all folder, zM for close all folder
set foldlevel=99
autocmd FileType c,cpp,java,javascript,vim,xml,html,xhtml set fdm=syntax
autocmd FileType python,yaml set fdm=indent
nnoremap <S-Space> za
vnoremap <S-Space> za

" Vim-go
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1
let g:go_fmt_autosave=0 " disable auto fmt on save

" DBGPavim
let g:dbgPavimBreakAtEntry=1

" NeoComplete, conflict with fdm=syntax
let g:neocomplete#enable_at_startup=1

" Ycm
" let g:ycm_server_keep_logfiles=1
" let g:ycm_server_log_level='debug'
" let g:ycm_min_num_of_chars_for_completion=99
let enable_ycm=$YCM " set YCM=1 on windows or export YCM=1 on linux if you need to enable ycm
if enable_ycm != 1
    let g:loaded_youcompleteme=1 " this will disable ycm at startup
endif
if has('win32')
    let g:ycm_global_ycm_extra_conf=$VIM.'/vimfiles/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
else
    let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif
let g:ycm_key_list_select_completion=['', '']
let g:ycm_key_list_previous_completion=['']
let g:ycm_key_invoke_completion='<C-Space>'
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Quick resize window size
nmap <Leader>m :vertical resize +3<CR>
nmap <Leader>l :vertical resize -3<CR>
nmap <Leader>mm :resize +3<CR>
nmap <Leader>ll :resize -3<CR>

" Key mapping quick check
" ;n    => open the nerdtree
" ;a    => arg wrap
" ;cc   => comment
" ;cu   => uncomment
" ;t    => taglist
" wm    => window manager
" ,g    => cscope find definition, ,c etc
" F8    => generate cscope, ctags
" F9    => generate cscope only
" ;f    => open the ctrlp
" ,g    => python jedi go to definition
" ;ig   => vim indent guide
" mm    => mark
" F1    => show vimrc
" F2    => mark find
" F3    => vim grep
" F7    => remove white space at the end
" ;;w   => quick motion after current cursor
" ;;b   => quick motion before current cursor
" F12   => reset to molokai scheme
" zM    => close all folding
" zR    => open all folding
