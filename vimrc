set nocompatible
filetype off

" set the runtime path to include Pathogen and initialize
if has("win32")
    set rtp+=~/vimfiles/bundle/vim-pathogen/
else
    set rtp+=~/.vim/bundle/vim-pathogen/
endif
execute pathogen#infect()

filetype plugin indent on

" Visual settings"{{{
if has('gui_running')
    set guiheadroom=0
    set lines=60 columns=108 linespace=0
    if has('gui_win32')
        set guifont=Droid_Sans_Mono:h11:cANSI
    else
        set guifont=Droid\ Sans\ Mono\ 11
    endif
    set go-=m|   " Menu bar
    set go-=T|   " Toolbar
    set go-=r|   " Right scrollbar
    set go-=L|   " Left scrollbar
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:onedark_terminal_italics=1
syntax on
colorscheme onedark

" Switch syntax highlighting on, if the terminal has colors
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif"}}}

" set diffexpr=MyDiff()"{{{
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

" Airline"{{{
set laststatus=2|   " Always show the statusline
set encoding=utf-8| " Necessary to show Unicode glyphs

let g:airline_powerline_fonts = 0|   " Activate fancy fonts with 1
let g:airline_left_sep=''|           " Disable seperators
let g:airline_right_sep=''
let g:airline_theme="powerlineish"|  " Change the visual style

" Buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'"}}}

" CtrlP"{{{

" buffer settings
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" ignore
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build)$',
    \ 'file': '\v\.(exe|so|rlib|dll|class|png|jpg|jpeg|ico)$',
\}
let g:OmniSharp_selector_ui = 'ctrlp'"}}}

" NERDTree"{{{
let NERDTreeChDirMode=2
map <F10> :NERDTreeToggle ~/<CR>|   " Toggle nerdtree with F10
map <F9> :NERDTreeFind<CR>|      " Current file in nerdtree"}}}

" UltiSnips"{{{
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>""}}}

set diffopt+=vertical

autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
set completeopt-=preview

" General Settings"{{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start| " allow backspacing over everything in insert mode

set hidden|                 " Doesn't complain about switching unsaved buffers
set wildmenu|               " Better command-line completion
set history=50|             " keep 50 lines of command line history
set incsearch|              " do incremental searching
set number relativenumber|  " Hybrid line numbers
set scrolloff=2|            " let's you see the next lines
set ignorecase|             " case insensitive searching
set smartcase|              " except when using capitals

if has('mouse')
    set mouse=a
endif

if version >= 600
    set foldenable
    set foldmethod=marker
endif

if has("win32")
    " Move backups to vimtmp
    set backupdir=~/vimtmp,.
    set directory=~/vimtmp//,.
    let $MYVIMRC="~/vimfiles/vimrc"
else
    set backupdir=~/.vimtmp,.
    set directory=~/.vimtmp//,.
    let $MYVIMRC="~/.vim/vimrc"
end"}}}

" General Keymaps"{{{
let mapleader=" "
"map <Leader> <Plug>(easymotion-prefix)

nnoremap <C-L> :nohl<CR><C-L>|   "Redraw and remove highlighting
map Y y$|                        "Make Y work like D and C

inoremap jk <ESC>
inoremap kj <ESC>
nmap <S-Enter> O<ESC>
nmap <CR> o<ESC>
if has("unix")
    cmap w!! w !sudo tee > /dev/null %
endif

" Remap s to insert a single char and allow repetition like 5s
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap S :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap s :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>Y "*y
noremap <leader>P "*p

nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>"}}}

" Autocmd"{{{
if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END
else
    set autoindent
endif"}}}
