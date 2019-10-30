
set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
colorscheme ayu
set background=light

set clipboard=unnamedplus


" Set Icons font
set guifont=FiraCode\ Nerd\ Font\ Mono\ 11
set conceallevel=3


" NERDTrees File highlighting only the glyph/icon
" test highlight just the glyph (icons) in nerdtree:
autocmd filetype nerdtree highlight haskell_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=Red guifg=#ffa500
autocmd filetype nerdtree highlight go_icon ctermbg=none ctermfg=Red guifg=#ffa500

autocmd filetype nerdtree syn match haskell_icon ## containedin=NERDTreeFile
" if you are using another syn highlight for a given line (e.g.
" NERDTreeHighlightFile) need to give that name in the 'containedin' for this
" other highlight to work with it
autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFile,html

" Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" JS Doc
let g:jsdoc_enable_es6=1
map <Win-D> :JsDoc <CR>

set showtabline=2  " Show tabline
set guioptions-=e  

" turn syntax config
syntax on

" Visual config
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
map <F3> :NERDTreeToggle<CR>
imap <C-Return> <CR><CR><C-o>k<S-s> with <S-S>

" Buffer handling next/previous/explore
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>
nnoremap <silent> <C-F12> :bd<CR>
nnoremap <silent> <M-F12> :BufExplorer<CR>

" Open NERDTree automatically when vim starts up on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" set filetypes asOA typescript.tsx
" autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

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
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1

let g:ale_virtualenv_dir_names = ['./env']

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

set ts=2 sw=2 et
let g:indent_guides_enable_on_vim_startup = 1

set encoding=UTF-8


" fzf stuff
set rtp+=~/.fzf

" Mappings
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>
nnoremap <silent> <leader>l :Buffers<CR>
nnoremap <silent> <leader>b :BLines<CR>
nnoremap <silent> <leader>` :Marks<CR>
nnoremap <silent> <leader>p :Commands<CR>
nnoremap <silent> <leader>t :Filetypes<CR>
nnoremap <silent> <F1> :Helptags<CR>
inoremap <silent> <F1> <ESC>:fHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:History:\<CR>" : "\<ESC>:History/\<CR>"
cnoremap <silent> <C-_> <C-u>:Commands<CR>

" fzf.Tags uses existing 'tags' file or generates it otherwise
nnoremap <silent> <leader>] :Tags<CR>
xnoremap <silent> <leader>] "zy:Tags <C-r>z<CR>

" fzf.BTags generate tags on-fly for current file
nnoremap <silent> <leader>} :BTags<CR>
xnoremap <silent> <leader>} "zy:BTags <C-r>z<CR>

" Show list of change in fzf
" Some code is borrowed from ctrlp.vim and tweaked to work with fzf
command Changes call s:fzf_changes()
nnoremap <silent> <leader>; :Changes<CR>

function! s:fzf_changelist()
  redir => result
  silent! changes
  redir END

  return map(split(result, "\n")[1:], 'tr(v:val, "	", " ")')
endf

function! s:fzf_changeaccept(line)
  let info = matchlist(a:line, '\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\).\+$')
  call cursor(get(info, 2), get(info, 3))
  silent! norm! zvzz
endfunction

function! s:fzf_changes()
  return fzf#run(fzf#wrap({
        \ 'source':  reverse(s:fzf_changelist()),
        \ 'sink': function('s:fzf_changeaccept'),
        \ 'options': '+m +s --nth=3..'
        \ }))
endfunction

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}


"-----------------------------------tagbar------------------------------------
let g:tagbar_width=35
let g:tagbar_autofocus=1
let g:tagbar_left = 1
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
nmap <F2> :TagbarToggle<CR>
"-----------------------------------------------------------------------------


" IndentLine {{
let g:indentLine_char = '|'
let g:indentLine_first_char = '|'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}


"---------------------------------UtilSnips-----------------------------------

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<S-Right>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"-----------------------------------------------------------------------------
