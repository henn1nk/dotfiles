" Options {{{
set t_Co=256
set undodir=~/.vim/undo
set clipboard=unnamed "osx
set autoindent
set autowrite
set backspace=2
if exists('+breakindent')
  set breakindent showbreak=\ +
end
set cmdheight=1
setglobal commentstring=#\ %s
set complete-=i
set dictionary+=/usr/share/dict/words
set display=lastline
set expandtab
set fileformats=unix,mac,dos
set foldmethod=syntax
set foldopen+=jump
set foldlevelstart=20
if v:version + has('patch541') >= 704
  set formatoptions+=j
end
set history=200
set incsearch
set laststatus=2
set lazyredraw
set linebreak
if exists('+macmeta')
  set macmeta
end
set mouse=nvi
set mousemodel=popup
set number
set nocompatible
set noswapfile
set paste
set showcmd " Show (partial) command in status line
set showmatch " Show matching brackets
set smarttab " sw at the start of the line, sts everywhere else
if exists('+spelllang')
  set spelllang=en_us " Spelling check for 'en_us'
end
set timeoutlen=1200 " Time for macros
set ttimeoutlen=50 " Make Esc work faster
if exists('+undofile')
  set undofile " Save undos
end
set visualbell " Show visual bell
set virtualedit=block " Visual mode displayed as block
set viminfo='100,n$HOME/.vim/files/info/viminfo
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.pyc
" }}}
" Plugins {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'vim-scripts/Gundo'
Plugin 'junegunn/vim-easy-align'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
Plugin 'Rykka/colorv.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'mephux/vim-jsfmt'
Plugin 'tomasr/molokai'

call vundle#end()
filetype plugin indent on
syntax on
" }}}
" Plugin settings {{{
let javaScript_fold=1
let perl_fold=1
let php_folding=1
let r_syntax_folding=1
let ruby_fold=1
let sh_fold_enabled=1
let vimsyn_folding='m'
let xml_syntax_folding=1
let g:js_fmt_autosave=1
let g:ctrlp_map=',p'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:gundo_right=1
if has('macunix')
  " Dash.app integration
  let g:dash_map = {
        \ 'ruby'       : 'rails',
        \ 'coffee'     : 'coffeescript',
        \ 'haml'       : 'haml',
        \ 'python'     : 'python3',
        \ 'vim'        : 'vim',
        \ 'javascript' : 'javascript',
        \ }
endif
" }}}
" Colors {{{
set background=dark
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
colorscheme molokai
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
" }}}
" Mappings {{{
let mapleader=','
inoremap jk <ESC>
nmap <silent> <Leader>n :NERDTreeToggle<CR>
nmap <silent> <Leader>g :GundoToggle<CR>
nmap <silent> <Leader>t :TagbarToggle<CR>
nmap <silent> <leader>d <Plug>DashSearch
nmap <silent> <Leader>1 :CtrlP<CR>
nmap <silent> <Leader>2 :NERDTreeToggle<CR>
nmap <silent> <Leader>3 :GundoToggle<CR>
nmap <silent> <Leader>4 :TagbarToggle<CR>
nmap <silent> <leader>5 <Plug>DashSearch
map <Leader> <Plug>(easymotion-prefix)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
nnoremap ; :
map <silent> <leader>h :wincmd h<CR>
map <silent> <leader>j :wincmd j<CR>
map <silent> <leader>k :wincmd k<CR>
map <silent> <leader>l :wincmd l<CR>
noremap <C-h> <C-w>h
noremap <c-j> <c-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
map <leader>g :g
" }}}
" Autocommands {{{
if has('autocmd')
  augroup Misc " {{{
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufEnter * silent! lcd %:p:h
    autocmd GUIEnter * set vb t_vb=
    autocmd VimEnter * set vb t_vb=
    autocmd FileType markdown set sw=4
    autocmd FileType markdown set sts=4
    autocmd BufEnter * lcd %:p:h
    autocmd! bufwritepost $MYVIMRC source $MYVIMRC
  augroup END " }}}
  augroup FileTypeCheck " {{{
    autocmd!
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == "" | set ft=text | endif
    autocmd BufNewFile,BufRead *.ejs set filetype=html
  augroup END " }}}
  augroup FileTypeOptions " {{{
    autocmd!
    autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
    autocmd FileType gitcommit setlocal spell
    autocmd FileType javascript setlocal commentstring=//\ %s
    autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType markdown,text,txt setlocal tw=78 linebreak nolist
    autocmd FileType ruby setlocal tw=79
  augroup END " }}}
  augroup DashMap
    if has('macunix')
      autocmd!
      for key in keys(g:dash_map)
        exe 'au FileType ' . key . ' nnoremap <buffer> K :Dash<cr>'
      endfor
    endif
  augroup END
endif
" }}}
" Commands {{{
cmap w!! w !sudo tee % >/dev/null
command! SortCss :g#\({\n\)\@<=#.,/}/sort " Sort css alphabetically
command! -range=% TR mark ` | execute <line1> . ',' . <line2> . 's/\s\+$//' | normal! `` " Trim trailing spaces
" }}}
" Sessions {{{
" Necessary: mkdir ~/.vim/.sessions
" Quick save current session and quit
nnoremap <leader>sq :mksession! ~/.vim/sessions/last.vim<cr>:qall<cr>
" Quick save current session
nnoremap <leader>ss :mksession! ~/.vim/sessions/last.vim<cr>
" Quick load last session
nnoremap <leader>ll :tabonly<cr>:source ~/.vim/sessions/last.vim<cr>

" Saves sessions 1-9
nnoremap <leader>s1 :mksession! ~/.vim/sessions/s1.vim<cr>
nnoremap <leader>s2 :mksession! ~/.vim/sessions/s2.vim<cr>
nnoremap <leader>s3 :mksession! ~/.vim/sessions/s3.vim<cr>
nnoremap <leader>s4 :mksession! ~/.vim/sessions/s4.vim<cr>
nnoremap <leader>s5 :mksession! ~/.vim/sessions/s5.vim<cr>
nnoremap <leader>s6 :mksession! ~/.vim/sessions/s6.vim<cr>
nnoremap <leader>s7 :mksession! ~/.vim/sessions/s7.vim<cr>
nnoremap <leader>s8 :mksession! ~/.vim/sessions/s8.vim<cr>
nnoremap <leader>s9 :mksession! ~/.vim/sessions/s9.vim<cr>

" Loads sessions 1-9
nnoremap <leader>l1 :tabonly<cr>:source ~/.vim/sessions/s1.vim<cr>
nnoremap <leader>l2 :tabonly<cr>:source ~/.vim/sessions/s2.vim<cr>
nnoremap <leader>l3 :tabonly<cr>:source ~/.vim/sessions/s3.vim<cr>
nnoremap <leader>l4 :tabonly<cr>:source ~/.vim/sessions/s4.vim<cr>
nnoremap <leader>l5 :tabonly<cr>:source ~/.vim/sessions/s5.vim<cr>
nnoremap <leader>l6 :tabonly<cr>:source ~/.vim/sessions/s6.vim<cr>
nnoremap <leader>l7 :tabonly<cr>:source ~/.vim/sessions/s7.vim<cr>
nnoremap <leader>l8 :tabonly<cr>:source ~/.vim/sessions/s8.vim<cr>
nnoremap <leader>l9 :tabonly<cr>:source ~/.vim/sessions/s9.vim<cr>
" }}}
