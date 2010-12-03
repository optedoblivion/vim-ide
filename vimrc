""
"" .vimrc
""
"" -- optedoblivion
""

"" Use Vim settings, rather then Vi settings (much better!).
"" This must be first, because it changes other options as a side effect.
set nocompatible 

"" Tabs (PEP 8) 
set softtabstop=4
set shiftwidth=4
set tabstop=8
set expandtab
set sta

"" Indenting
set ai
set si

"" Scrollbars
set sidescrolloff=2

"" Line numbers
set numberwidth=4
set nu

"" Windows
set equalalways
set splitbelow splitright

"" Cursor

"" Searching
"set ignorecase                     " Ignore case when searching.
set hlsearch                        " Highlight Search.
set incsearch                       " Incremental Search (Search as you type).
set smartcase                       " Ignore case when searching lowercase.

"" Colors
set t_Co=256                        " 256 Colors.
set background=dark                 " Set dark background.
syntax on                           " Turn syntax highlighting on.
colorscheme zenburn                 " Set colorscheme to zenburn.

"" Highlights
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.*/
set cursorline                      " Highlights cursor row.
"" set cursorcolumn                    " Highlights cursor column.

"" Status Line
"set ch=2                           " Make command line two lines high.
set showcmd                         " 
set ruler                           " Display ruler.
set history=50                      " Keep 50 lines of comand line history.

"" Mouse
set mouse=a                         " Enable mouse
behave xterm
set selectmode=mouse

" Line Wrapping
set nowrap
set linebreak

"" Directories
set backupdir=~/.vimbackup          " Set backup location.
set backup                          " Enable backups.
set directory=~/.vimbackup/swap     " Set swap directory.

"" Misc.
set sw=4
set backspace=indent,eol,start      " Allow backspacing over everything in insert mode.
let g:clipbrdDefaultReg = "+"

"" Autocommand
if has("autocmd")

    augroup vimrcEx                 " Put in an autocmd group
        au!                         
    
        "" Auto Completion
        autocmd FileType python :set omnifunc=pythoncomplete#Complete
        autocmd FileType html :set omnifunc=htmlcomplete@CompleteTags
        autocmd FileType html :set filetype=xhtml
        autocmd FileType javascript :set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType css :set omnifunc=csscomplete#CompleteCSS
        autocmd FileType c :set omnifunc=ccomplete#Complete

        "" Python Syntax
        autocmd BufWrite *.{py} :call CheckSyntax()

        "" When editing a file, always jump to the last known cursor porition.
        "" Don't do it when the position is invalid or when inside an event
        "" handler.
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \       exe "normal! g`\"" |
            \ endif
    augroup END

else
    set autoindent
endif

"" View diff of current buffer vs original file.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"" Functions
function PylintReport()
    setlocal makeprg=(echo\ '[%]';\ pylint\ %)
    setlocal efm=%+P[%f],%t:\ %#%l:%m
    silent make
    cwindow
    exe "!clear"
    exe ":redraw!"
endfunction

function CheckSyntax()
    setlocal makeprg=(echo\ '[%]';\ pylint\ --reports=n\ %)
    setlocal efm=%+P[%f],%t:\ %#%l:%m
    silent make
    cwindow
    exe "!clear"
    exe ":redraw!"
endfunction  

"" Mappings
map <silent> <C-z> <Esc>:undo<CR>
map <silent> <C-y> <Esc>:redo<CR>
map <silent> <C-t> <Esc>:tabnew<CR>
map <silent> tt <Esc>:tabnext<CR>
map <silent> tr <Esc>:tabprev<CR>
map <silent> <F2> <Esc>:NERDTreeToggle<CR>
map <silent> <F3> <Esc>:TlistToggle<CR>
map <silent> <F4> :w<CR>:!/usr/bin/env python % <CR>
"" map <silent> <F5>
"" map <silent> <F6>
map <silent> <F7> <Esc>:TaskList<CR>
map <S-Enter> O<ESC>
map <Enter> o<ESC>
imap jj <Esc>
map Q gq

"" Nerd Tree
let NERDTreeIgnore=['\.pyc$','\.svn$','\.git$']

"" Tag List
let g:Tlist_Use_Right_Window=1

"" Supertab

"====[EOF]====
