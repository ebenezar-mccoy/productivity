" load plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" require vim
set nocompatible

" enconding
set encoding=utf-8

" colors
syntax on
colorscheme codeschool
" cursor highlight
:hi CursorLine ctermbg=238
" :hi CursorColumn cterm=NONE ctermbg=black ctermfg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
set cursorline
" improve autocomplete menu color
highlight Pmenu ctermbg=25

" settings
filetype plugin indent on
set backspace=indent,eol,start " make backspace a more flexible
let loaded_matchparen=1 " match paranthesis
set mouse=a " use mouse for everything
set splitright splitbelow " new splits right from current and other below
set autoread " supress warnings
set wildmenu " wildmenu when autocomplting option
set wildmode=full " complete the full match, this is default behaviour
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " there files will be ignored when completing in wild menu
set history=1000
set tags=.tags;/ " save tags generated for files in current working directory
set ttyfast " i got a fast terminal!
set ttimeoutlen=50  " Make Esc work faster
set ignorecase " ignore case when searching
set hlsearch   " highlight search matches
set incsearch " search as you type
set gdefault  " global matching is default
set smartcase " use smartcase, when search query starts with Uppercase, turn off case insensitive search
set list " show trailing characters
set listchars=tab:▸\ ,trail:¬,extends:❯,precedes:❮,nbsp:~ " it show ¬ character when as you type, fill free to comment out set list
"set number " set line numbering
set novisualbell " do not blink
set lazyredraw " get faster, redraw only when it's needed
set nostartofline
set linespace=0
set showcmd " show the command being typed
set ruler " always show current position
set scrolloff=5 " Keep 5 lines (top/bottom) for scop
set sidescrolloff=10 " Keep 10 lines at the size
set showmode " show the current mode (Insert, Visual..)
set expandtab " no real tabs!
set wrap " wrap lines, we dont want long lines
set showbreak=↪ " character show when wrapping line
set foldenable " folding text into clusters (+) according to  {{{ }}} or comments for example.
set foldmethod=manual " default options, we create fold manually.
set showmatch " when use insert bracket, briefly jump to matching one (i like it, but i might be annoying)
set infercase " case inferred by default
set shiftround " round the indent to shiftwidth (when at 3 spaces, and I hit > go to 4, not 5)
set shiftwidth=2 " auto-indent amount when using >> <<
set softtabstop=2 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=2 " real tabs should be 4, and they will show with set list on
set autoindent
set completeopt=longest,menu,preview
set clipboard=unnamed
set pastetoggle=<F6>
set selection=exclusive " smart selection copy

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" Filter and trim whitespaces
autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

" Remember info about open buffers on close
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
set viminfo^=%

" map leader
let mapleader = ',' " used for lot of stuff, feel free to change it.
" open all folds
nnoremap <space> :%foldopen<CR>
" emacs-like keybindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-a> <Esc>^i
inoremap <C-e> <Esc>A
" this key combination gets rid of the search highlights.
nmap <leader><space> :noh<cr>
" tabs - moving around, (CTRL+n to new tab)
map <C-t> :tabnew<CR>
map <C-w> :tabclose<CR>
map <C-M-n> :tabedit %<CR>
map <M-Right> :tabnext<cr>
" map <C-Tab> :tabprevious<cr>
" buffers - moving around
map <A-x-Left> :bprevious<CR>
map <A-x-Right> :bNext<CR>
" write and quit current buffer
nnoremap <C-M-w> :wq<CR>
" run ctags silently
map <leader>t :silent! !ctags -R . &<CR>
" reformat whole file
nnoremap <leader>= ggVG=
" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q
" upper/lower first char of word
nmap <leader>wu mQgewvU`Q
nmap <leader>wl mQgewvu`Q
" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
" create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
" swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'
" map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk
" toggle hlsearch with <leader>hs
nmap <leader>sh :set hlsearch! hlsearch?<CR>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" ruby
augroup FTRuby
  au!
  autocmd FileType eruby,yaml,ruby        setlocal ai et sta sw=2 sts=2
  autocmd BufNewFile,BufRead *.html.erb   set filetype=eruby.html  " load html snippets along with erb
  autocmd FileType ruby,eruby             let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby             let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby,eruby             let g:rubycomplete_buffer_loading = 1
  " autocmd FileType eruby set filetype=eruby.chef
  autocmd FileType ruby set filetype=ruby.chef
  let g:rails_statusline = 1
augroup END

" nerdtree
map <F2> :CtrlP<CR>
map <F3> :NERDTreeToggle<CR>
map <F4> :NERDTreeFind<CR>
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" neomake
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop', 'foodcritic']
let g:vimrubocop_extra_args = '-r cookstyle -D'
autocmd! BufWritePost,BufEnter * Neomake

" neocomplete
imap <expr><TAB> pumvisible() ? neocomplete#close_popup() : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 4
" let g:neocomplete#enable_auto_select = 1
" let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'"

" airline
set laststatus=2
" let g:airline#extensions#branch#enabled=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_theme='bubblegum'
let g:airline_section_warning=''
let g:airline_skip_empty_sections = 1
let g:airline#extensions#disable_rtp_load = 0

 let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
