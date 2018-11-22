" turn syntax config
syntax on

" Visual config
set background=dark
set number
set ruler
set autochdir

set tabstop=2
set shiftwidth=2

let python_highlight_all=1
let g:airline_theme='deus'


" Load all plugins
packloadall

" Load all of the helptags, messages and errors will be ignored
silent! helptags ALL


" Keybinding mappings
map <C-o> :NERDTreeToggle<CR>
imap <C-Return> <CR><CR><C-o>k<S-s> with <S-s>

" Open NERDTree automatically when vim starts up on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


let g:ale_virtualenv_dir_names = ['./env']
