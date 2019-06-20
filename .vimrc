" lightline configuration
let g:lightline = {
  \   'colorscheme': 'darcula',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  

" turn syntax config
syntax on

" Visual config
set background=dark
set number
set ruler
set autochdir
set autoindent

set foldmethod=syntax
set foldlevel=99

filetype plugin indent on

set expandtab " Spaces instead of tabs
set tabstop=2 " 1 tab = 2 columns
set shiftwidth=2 " 1 tab = 2 spaces
set softtabstop=2 " Columns of tabbing in insert mode
set smarttab
set ai " Auto indent
set si " Smart indent

set wrap
set bs=2

" tags generation status
set statusline+=%{gutentags#statusline()}

" remove mode status from vim default since lightline will provide it
set noshowmode

" show lightline, dont know why but it doesnt render otherwise
set laststatus=2

" turn highlighting for all python keywords
let python_highlight_all=1

" Load all plugins
packloadall

" Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"

" Load all of the helptags, messages and errors will be ignored
silent! helptags ALL

" Keybinding mappings
nmap <F2> :TagbarToggle<CR>
map <F3> :NERDTreeToggle<CR>
imap <C-Return> <CR><CR><C-o>k<S-s> with <S-s>

" Buffer handling next/previous/explore
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>
nnoremap <silent> <C-F12> :bd<CR>
nnoremap <silent> <M-F12> :BufExplorer<CR>

" Open NERDTree automatically when vim starts up on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" set filetypes asOA typescript.tsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" Close NERDTree when you open a file
let NERDTreeQuitOnOpen=1
" Show hidden files in NerdTree
let NERDTreeShowHidden=1

" Git icons remap
let g:NERDTreeIndicatorMapCustom = {  
  \ "Modified"  : "",
  \ "Staged"    : "",
  \ "Untracked" : "",
  \ "Renamed"   : "",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "",
  \ "Clean"     : "✔︎",
  \ "Ignored"   : "☒",
  \ "Unknown"   : "?"
    \ }


" Close Tab if the only remaining window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Prettier
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

let g:ale_virtualenv_dir_names = ['./env']



" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

set ts=2 sw=2 et
let g:indent_guides_enable_on_vim_startup = 1

set encoding=utf-8


" Enable fzf
set rtp+=~/.fzf
