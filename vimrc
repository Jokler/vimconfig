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
"set number relativenumber|  " Hybrid line numbers
set number|                 " Line numbers
set scrolloff=2|            " let's you see the next lines
set ignorecase|             " case insensitive searching
set smartcase|              " except when using capitals
set autoread|               " reload changed files automatically
set updatetime=100|         " Milliseconds until swap file is written (makes gitgutter faster)
set signcolumn=yes|         " Always show the column for errors/gitgutter
"set signcolumn=number|       " Merge the column for errors/gitgutter with line numbers

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
nmap <leader>i :bnext<CR>
nmap <leader>k :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

" Makes word motions follow CamelCase/snake_case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" same for word object motions
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" and insert mode motions
imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w
"}}}

nnoremap <F5> :UndotreeToggle<CR>
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

lua require'colorizer'.setup()

" Autocmd"{{{
if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

    " Language based indentation settings
    autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType bash setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType PKGBUILD setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType go setlocal noexpandtab

    "augroup numbertoggle
      "autocmd!
      "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    "augroup END
else
    set autoindent
endif"}}}

" Airline"{{{
set laststatus=2|   " Always show the statusline
set encoding=utf-8| " Necessary to show Unicode glyphs

let g:airline_powerline_fonts = 1|   " Activate fancy fonts with 1
let g:airline_left_sep=''|           " Disable seperators
let g:airline_right_sep=''
let g:airline_theme="onedark"|  " Change the visual style

" Buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1|"}}}

" CtrlP"{{{

" buffer settings
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" ignore
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build|target|node_modules)$',
    \ 'file': '\v(main(\.)@!|(\.(exe|so|rlib|dll|class|png|jpg|jpeg|ico|zip))$)',
\}

" UltiSnips"{{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

set diffopt+=vertical

set completeopt-=preview
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = "latex"
"}}}

let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guibg=#004400 gui=bold
highlight ConflictMarkerOurs guibg=#004400
highlight ConflictMarkerTheirs guibg=#440000
highlight ConflictMarkerEnd guibg=#440000 gui=bold

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)


"let g:go_fmt_command = "golines"

" nvim config

" Give more space for displaying messages.
"set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ CheckBackspace() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! CheckBackspace() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
