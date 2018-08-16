" begin vim-plug install list and specify home for plugins
call plug#begin('~/.local/share/nvim/plugged')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }


" JS tooling
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'

"Elxir
Plug 'slashmili/alchemist.vim'

call plug#end()

set clipboard=unnamed " use system clipboard

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set number	" show line numbers
set showmatch	" show matching parens
set ignorecase	" ignore case when searching
set smartcase	" ignore case _if_ search pattern is all lowercase, sensitive otherwise
set hlsearch	" highlight search terms
hi Search ctermbg=Yellow ctermfg=Black
set incsearch	" show search matches as you type
set mouse=a	" allow mouse control (scrolling, etc)
set splitbelow	"Open horizontal split below
set splitright	"Open vertical split right

let mapleader = " "
nmap <Leader>x :nohlsearch<CR>
" By dflt, to move around split ctrl w ctrl $direction
" moves in that direction.
" Remaps the movement to ctrl $direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"
" Plugin Configuration
"

let g:airline_powerline_fonts = 1 
let g:airline_theme = 'tomorrow'
"Enable the list of buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemode = ':t'

let g:javascript_plugin_jsdoc = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" NERDTree Customizations
nmap <Leader>] :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

" CTRLp Customizations
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" syntax highlight heroku logs
au BufNewFile,BufRead,BufReadPost *.log set filetype=messages
