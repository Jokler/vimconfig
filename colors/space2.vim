" Original Creator:   Josh Parnell

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "space2"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine     guibg=#151515 gui=bold ctermbg=234
  hi CursorColumn   guibg=#151515 gui=bold ctermbg=234
  hi MatchParen     guifg=#d0ffc0 guibg=#151515 gui=bold ctermfg=157 ctermbg=237 cterm=bold
  hi Pmenu          guifg=#ffffff guibg=#151515 gui=bold ctermfg=255 ctermbg=238
  hi PmenuSel       guifg=#000000 guibg=#b1d631 gui=bold ctermfg=0   ctermbg=148
endif

" General colors
hi Cursor           gui=bold guifg=#151515 guibg=#ff5030 ctermbg=241
hi Normal           gui=bold guifg=#e2e2e5 guibg=#151515 ctermfg=253 ctermbg=234
hi NonText          gui=bold guifg=#808080 guibg=#151515 ctermfg=244 ctermbg=235
hi LineNr           gui=bold guifg=#383838 guibg=#151515 ctermfg=244 ctermbg=232
hi StatusLine       gui=bold guifg=#d3d3d5 guibg=#303030 ctermfg=253 ctermbg=238
hi StatusLineNC     gui=bold guifg=#939395 guibg=#303030 ctermfg=246 ctermbg=238
hi VertSplit        gui=bold guifg=#444444 guibg=#303030 ctermfg=238 ctermbg=238
hi Folded           gui=bold guibg=#384048 guifg=#a0a8b0 ctermbg=4   ctermfg=248
hi Title            gui=bold guifg=#f6f3e8 guibg=NONE    ctermfg=254 cterm=bold
hi Visual           gui=bold guifg=#faf4c6 guibg=#3c414c ctermfg=254 ctermbg=4
hi SpecialKey       gui=bold guifg=#808080 guibg=#343434 ctermfg=244 ctermbg=236
hi Search           gui=bold guifg=#151515 guibg=#2090d0
hi WildMenu         gui=bold guifg=#151515 guibg=#2090d0
hi ErrorMsg         gui=bold guifg=#ff9d00 guibg=#800101
hi DiffAdd          gui=bold guibg=#1e2319
hi DiffChange       gui=bold guibg=#192223
hi DiffDelete       gui=bold guifg=#a08700 guibg=#2f221d
hi DiffText         gui=bold guifg=#ddbb99 guibg=#2f221d

let c1 = '#2090d0'
let c2 = '#606060'
let c3 = '#ff5030'
let c4 = c1
let c5 = '#90c010'

" Syntax highlighting
exe "hi Boolean          gui=bold ctermfg=148 guifg=" . c1
exe "hi Identifier       gui=bold ctermfg=148 guifg=" . c1
exe "hi Special          gui=bold ctermfg=208 guifg=" . c1

exe "hi String           gui=bold ctermfg=148 guifg=" . c2
exe "hi Constant         gui=bold ctermfg=208 guifg=" . c2
exe "hi Number           gui=bold ctermfg=208 guifg=" . c2

exe "hi Statement        gui=bold ctermfg=103 guifg=" . c3
exe "hi PreProc          gui=bold ctermfg=230 guifg=" . c3

exe "hi Type             gui=bold ctermfg=103 guifg=" . c4

exe "hi Function         gui=bold ctermfg=255 guifg=" . c5
exe "hi Keyword          gui=bold ctermfg=208 guifg=" . c5

exe "hi Todo             gui=bold,underline guibg=#151515 guifg=#ff0000"
exe "hi Comment          gui=bold ctermfg=244 guifg=#505050"
