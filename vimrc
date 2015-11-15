set nocompatible
filetype off

" set the runtime path to include Pathogen and initialize
if has("win32")
    set rtp+=~/vimfiles/bundle/vim-pathogen/
else
    set rtp+=~/.vim/bundle/vim-pathogen/
endif
execute pathogen#infect()
"Plugin 'Valloric/YouCompleteMe'            " YouCompleteMe Linux only
"Plugin 'othree/vim-autocomplpop'           " Pop Autocomplete
filetype plugin indent on

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
    set go-=m   "Menu bar
    set go-=T   "Toolbar
    set go-=r   "right scrollbar
    set go-=L   "left scrollbar
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

let g:airline_powerline_fonts = 0   "Activate fancy fonts with 1
let g:airline_theme="powerlineish"  "Change the visual style

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
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|ico)$',
\}"}}}

" NERDTree"{{{
let NERDTreeChDirMode=2
map <F10> :NERDTreeToggle<CR>   " Toggle nerdtree with F10
map <F9> :NERDTreeFind<CR>      " Current file in nerdtree"}}}

" General Settings"{{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set hidden              " Doesn't complain about switching unsaved buffers
set wildmenu            " Better command-line completion
set history=50          " keep 50 lines of command line history
set incsearch           " do incremental searching
set scrolloff=2         " let's you see the next lines
set ignorecase          " case insensitive searching
set smartcase           " except when using capitals"}}}

" General Keymaps"{{{
let mapleader=","
"map <Leader> <Plug>(easymotion-prefix)

nnoremap <C-L> :nohl<CR><C-L>   " Redraw and remove highlighting
map Y y$                        " Make Y work like D and C

inoremap jk <ESC>
inoremap kj <ESC>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
if has("unix")
    cmap w!! w !sudo tee > /dev/null %
endif

nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>"}}}

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

"Autocmd"{{{
if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \  exe "normal! g`\"" |
    \ endif
    augroup END
else
    set autoindent
endif"}}}
