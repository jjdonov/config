if !exists('g:vscode')
  " begin vim-plug install list and specify home for plugins
  call plug#begin('~/.local/share/nvim/plugged')

  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction

  " colorscheme
  Plug 'morhetz/gruvbox'

  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-abolish'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'mileszs/ack.vim'

  " Autocomplete
  " Plug 'liuchengxu/vista.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Linting / Fixing
  Plug 'w0rp/ale'

  "Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  " JS tooling
  Plug 'pangloss/vim-javascript'

  " Pug (thanks Daniel)
  Plug 'digitaltoad/vim-pug'

  "Elxir
  Plug 'slashmili/alchemist.vim'

  "Writing Mode
  Plug 'junegunn/goyo.vim'

  "Plant UML
  Plug 'aklt/plantuml-syntax'
  Plug 'weirongxu/plantuml-previewer.vim' "requires java and graphviz
  Plug 'tyru/open-browser.vim' "not Plant UML specific, but required by plantuml-previewer.vim

  "Markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

  "Rego (Open Policy Agent)
  Plug 'tsandall/vim-rego'

  call plug#end()
endif

set clipboard=unnamed " use system clipboard

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
"colo slate
"set background=light
colorscheme gruvbox
set termguicolors

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
set cursorline
set cursorcolumn
let mapleader = " "
nmap <Leader>x :nohlsearch<CR>
" By dflt, to move around split ctrl w ctrl $direction
" moves in that direction.
" Remaps the movement to ctrl $direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easy refresh. Useful after switching branches on git, etc.
nnoremap <F5> :checktime<CR>

"
" Plugin Configuration
"

let g:airline_powerline_fonts = 1 
let g:airline_theme = 'gruvbox'
"Enable the list of buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemode = ':t'

" ale (async linting engine) configuration
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fixers['typescript'] = ['eslint']
let g:ale_fixers['typescriptreact'] = ['eslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_linters= {
\ 'javascript': ['eslint'],
\ 'typescript': ['tsserver', 'eslint']
\}
"No semi is a hack till we get a .prettier config file on gh
"@ask-tia/prettier-config, for example
let g:ale_javascript_prettier_options = '--single-quote --no-semi --tab-width 4 --print-width 120' 

let g:javascript_plugin_jsdoc = 1

" NERDTree Customizations
nmap <Leader>] :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

" CTRLp Customizations
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=100
" Don't search gitignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" syntax highlight heroku logs
au BufNewFile,BufRead,BufReadPost *.log set filetype=messages

"-- FOLDING --
set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=1 "defines 1 col at window left, to indicate folding
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=99 "start file with all folds opened

nmap <Leader>b :buffers<CR>

nmap <Leader>l :ALENext<CR>
nmap <Leader>L :ALEPrevious<CR>
nmap <Leader>F :ALEFix<CR>

"--COC Config---

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
"300

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" autoimport / completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for applying codeAction to the current line.
xmap <leader>ga <Plug>(coc-codeaction-selected)
nmap <leader>ga <Plug>(coc-codeaction-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" TODO: get coc integrated with airline so we can show the current function

" use ag with ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
cnoreabbrev ag Ack!
cnoreabbrev aG Ack!
cnoreabbrev Ag Ack!
cnoreabbrev AG Ack!
noremap <Leader>a :Ack! <cword><cr>
noremap <Leader>A :Ack! <cword> --ignore-dir test<cr>

" Set a custom stylesheet for markdown to make it friendlier to pasting into
" GMail
" let g:mkdp_markdown_css = '~/.config/nvim/markdown-avenir-white.css'
let g:mkdp_theme = 'light' " 'dark'
