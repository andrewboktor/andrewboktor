" Maintainer:	Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	January 22 2007

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine		guifg=NONE    guibg=#111111 gui=bold
  hi CursorColumn	guibg=#191919
  hi MatchParen		guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu			guifg=#f6f3e8 guibg=#444444
  hi PmenuSel		guifg=#000000 guibg=#cae682
endif

" General colors
hi Cursor		guibg=lightgrey gui=NONE
hi Normal 		guifg=#f6f3e8 guibg=#050505 gui=NONE
hi NonText 		guifg=#333333 gui=none
hi LineNr 		guifg=#857b6f guibg=#000000 gui=none
hi StatusLine 	guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold
hi Visual		guibg=#553300 gui=none
hi SpecialKey	guifg=#333333 gui=none

" Syntax highlighting
hi Comment 		guifg=#99968b gui=italic
hi Todo 		guifg=#8f8f8f gui=italic
hi Constant 	guifg=#e5786d gui=none
hi String 		guifg=#95e454 gui=italic
hi Identifier 	guifg=#cae682 gui=none
hi Function 	guifg=#8ac6f2 gui=none
hi Statement 	guifg=#8ac6f2 gui=none
hi Type 		guifg=#8ac6f2 gui=none
"hi Type 		guifg=#cae682 gui=none
hi Keyword		guifg=#8ac6f2 gui=none
hi PreProc 		guifg=#ff6655 gui=none
hi Number		guifg=#ff6655 gui=none
hi Special		guifg=#ff6655 gui=none

