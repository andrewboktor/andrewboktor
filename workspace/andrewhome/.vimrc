set t_Co=256
set number
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hls
set cindent
set listchars=eol:$,tab:>-,trail:\.
set list
"set mouse=a
"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible()?"\<C-y>":"\<C-g>u\<C-R>"
"colorscheme wombat256
colorscheme wombat256
syntax on

"Adding syntax highlighting for .ispc files
au BufNewFile,BufRead *.ispc setlocal ft=c
