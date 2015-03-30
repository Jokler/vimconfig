set nocompatible              " be iMproved, required
filetype off                  " required for Vundle

" Vundle"{{{
" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'

call vundle#begin(path) " alternatively, pass a path where Vundle should install plugins
Plugin 'https://github.com/gmarik/Vundle.vim.git' " let Vundle manage Vundle, required

Plugin 'tpope/vim-fugitive'					" plugin on GitHub repo
Plugin 'L9'
"Plugin 'vim-scripts/L9', {'name': 'newL9'}
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}	" Avoid a name conflict with L9
"-----------------------------------------------
"-----------------My plugins--------------------
"-----------------------------------------------
"Plugin 'Shougo/unite.vim'
"Plugin 'Shougo/neomru.vim'
"Plugin 'Shougo/vimproc'

Plugin 'bling/vim-airline'					" Airline
Plugin 'Lokaltog/vim-easymotion'			" Easymotion
Plugin 'terryma/vim-multiple-cursors'		" Multiple Cursors for Visual etc
Plugin 'scrooloose/nerdtree'				" NERDTree
Plugin 'tpope/vim-surround'					" For easier editing of delimiters
Plugin 'scrooloose/nerdcommenter'			" Quick commenting
Plugin 'kien/ctrlp.vim'						" Ctrl-P to browse dirs
Plugin 'dahu/MarkMyWords'					" Tags
Plugin 'vim-scripts/ZoomWin'				" Zooming in windows

if has("unix")
	Plugin 'Valloric/YouCompleteMe'				" YouCompleteMe Linux only
else
	Plugin 'othree/vim-autocomplpop'			" Pop Autocomplete
end
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" Put your non-Plugin stuff after this line"}}}

"Keymaps"{{{
let mapleader=","
"map <Leader> <Plug>(easymotion-prefix)

map <F10> :NERDTreeToggle<CR>	" Toggle nerdtree with F10
map <F9> :NERDTreeFind<CR>		" Current file in nerdtree

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

inoremap jk <ESC>
inoremap kj <ESC>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
cmap w!! w !sudo tee > /dev/null %


set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

" Quicker window movement"{{{
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Easy navigation between splits. Instead of ctrl-w + j. Just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>"}}}"}}}

"Visual settings"{{{
if has('gui_running')
	set guiheadroom=0
	colorscheme space2
	set number
	set lines=60 columns=108 linespace=0
	if has('gui_win32')
		set guifont=Droid_Sans_Mono:h10:cANSI
	else
		set guifont=Droid\ Sans\ Mono\ 10
	endif
	set go-=m	"Menu bar
	set go-=T	"Toolbar
	set go-=r	"right scrollbar
	set go-=L	"left scrollbar
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif"}}}

"set diffexpr=MyDiff()"{{{
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
  if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
	 let l:shxq_sav = ''
	 set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
endfunction

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif"}}}

"Airline"{{{
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

"Activate fancy fonts
let g:airline_powerline_fonts = 0

"Buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'"}}}

"CtrlP"{{{

"buffer settings
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}"}}}

set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set history=50			" keep 50 lines of command line history
set incsearch			" do incremental searching
set scrolloff=2			" let's you see the next lines
set ignorecase			" case insensitive searching
set smartcase			" except when using capitals

if has('mouse')
  set mouse=a  " In many terminal emulators the mouse works just fine, thus enable it.
endif

if version >= 600
  set foldenable
  set foldmethod=marker
endif

if has("win32")
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>     "Fullscreen
	"Move backups to vimtmp
	set backupdir=~/vimtmp,.
	set directory=~/vimtmp//,.
	let $MYVIMRC="~/vimfiles/vimrc"
else
	set backupdir=~/.vimtmp,.
	set directory=~/.vimtmp//,.
	let $MYVIMRC="~/.vim/vimrc"
end

" Example Vimrc"{{{
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent  " always set autoindenting on
endif " has("autocmd")"}}}

