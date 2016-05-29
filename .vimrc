fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun

call SetupVAM()


call vam#ActivateAddons(['github:tpope/vim-fugitive'])
autocmd bufwritepost *.js silent !standard-format -w %
set autoread
"  call vam#ActivateAddons(['github:Shougo/neocomplete.vim'])
" let g:neocomplete#enable_at_startup = 1

" ###################  RUST  #########################
set hidden
filetype on
au BufNewFile,BufRead *.rs set filetype=rust
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo | set makeprg=cargo | set errorformat=%f:%l:%m
call vam#ActivateAddons(['github:Valloric/YouCompleteMe'])
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>h :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>c :YcmCompleter GoToDefinition<CR>
set ttimeoutlen=50 " for faster InsertLeave triggering
" let g:ycm_min_num_of_chars_for_completion =t submodule update --init --recursive 1
let g:ycm_rust_src_path = '/home/dirvine/Devel/rust/src'
let g:ycm_extra_spacing = 0  " Controls spaces around function parameters
let g:ycm_complete_in_comments = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_confirm_extra_conf = 0


call vam#ActivateAddons(['github:kiteco/plugins/'])

let RUST_SRC_PATH=$RUST_SRC_PATH
call vam#ActivateAddons(['github:rust-lang/rust.vim'])
nnoremap <silent> <Leader>b :make build <CR> <bar> :copen <CR>
nnoremap <silent> <Leader>l :!rustup run nightly <CR> <bar> :make test --no-run --features clippy <CR> <bar> :copen <CR>
nnoremap <silent> <leader><Leader>l :make test --no-run --features clippy <CR> <bar> :copen <CR>
nnoremap <silent> <Leader>t :make test -- --nocapture <CR>
let g:rustfmt_autosave = 0
let g:rust_bang_comment_leader = 1
let g:rust_playpen_url = 'https://play.rust-lang.org/'
let g:rustmft_options = 'overwrite'
let g:ftplugin_rust_source_path = $HOME.'/Devel/rust'
let g:rust_conceal_mod_path = 1
let g:rust_shortener_url = 'https://is.gd/'
let g:rust_conceal = 1
let g:rustc_makeprg_no_percent = 1

" ################ Python ################
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
" setlocal tags=rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
" autocmd BufWrite *.rs :silent !rusty-tags vi
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" remove all whitespace on every write
autocmd BufWritePre * :%s/\s\+$//e
call vam#ActivateAddons(['github:vim-airline/vim-airline-themes'])
call vam#ActivateAddons(['github:bling/vim-airline'])
let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_detect_paste=1
let g:airline#extensions#hunks#enabled = 1
let g:airline_powerline_fonts = 0
" After you've marked all your locations with Ctrl-n, you can change the visual selection with normal Vim motion commands in Visual mode. You could go to Normal mode
" by pressing v and wield your motion commands there. Single key command to switch to Insert mode such as c or s from Visual mode or i, a, I, A in Normal mode should
" work without any issues.
"
" At any time, you can press <Esc> to exit back to regular Vim.
"
" Two additional keys are also mapped:
"
" Ctrl-p in Visual mode will remove the current virtual cursor and go back to the previous virtual cursor location. This is useful if you are trigger happy with Ctrl-n
" and accidentally went too far.
" Ctrl-x in Visual mode will remove the current virtual cursor and skip to the next virtual cursor location. This is useful if you don't want the current selection to
" be a candidate to operate on later.
" call vam#ActivateAddons(['github:terryma/vim-multiple-cursors'])
" ###################### nim ############################
call vam#ActivateAddons(['github:zah/nimrod.vim'])
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
call GotoDefinition_{&filetype}()
  else
  exe "norm! \<C-]>"
  endif
  endf
" ########################################################
  " Jump to tag
  nn <M-g> :call JumpToDef()<cr>
  ino <M-g> <esc>:call JumpToDef()<cr>i

call vam#ActivateAddons(['vimproc'])
let g:ctags_statusline=1

call vam#ActivateAddons(['github:jtratner/vim-flavored-markdown'])
set spelllang=en_gb
autocmd Filetype markdown setlocal wrap spell

" call vam#ActivateAddons(['TaskList'])
call vam#ActivateAddons(['vim-signify'])
let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_disable_by_default = 0


call vam#ActivateAddons(['github:kana/vim-operator-user'])

call vam#ActivateAddons(['github:mattn/webapi-vim']) " for gist

call vam#ActivateAddons(['github:mattn/gist-vim'])

call vam#ActivateAddons(['github:int3/vim-extradite'])

call vam#ActivateAddons(['github:kien/ctrlp.vim'])
let g:ctrlp_use_caching = 1
let g:ctrlp_max_files = 100000
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_switch_buffer = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build*/
nnoremap <silent> <Leader>p :CtrlP <CR>
nmap ; :CtrlPBuffer<CR>
nmap <leader>a :CtrlPTag<CR>
nnoremap <silent> <Leader>n :set nonumber!<CR>

call vam#ActivateAddons(['github:proyvind/Cpp11-Syntax-Support'])

call vam#ActivateAddons(['github:scrooloose/syntastic'])
let g:syntastic_cpp_check_header = 0
" let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1 " Put errors on left side
let g:syntastic_auto_loc_list = 0 " Only show errors when I ask
" let g:syntastic_disabled_filetypes = ['html', 'js']
let g:syntastic_javascript_checkers = ['standard']
hi SpellBad ctermfg=007 ctermbg=000
hi SpellCap ctermfg=007 ctermbg=000
if has('unix')
  let g:syntastic_error_symbol='★'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='⚠'
  let g:syntastic_style_warning_symbol='>'
else
  let g:syntastic_error_symbol='!'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='.'
  let g:syntastic_style_warning_symbol='>'
endif

call vam#ActivateAddons(['delimitMate'])
" au FileType c,cpp,perl let b:delimitMate_eol_marker = ";"
au FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}"


call vam#ActivateAddons(['github:christoomey/vim-tmux-navigator'])
let g:tmux_navigator_save_on_switch = 1
call vam#ActivateAddons(['github:vim-scripts/ZoomWin'])
call vam#ActivateAddons(['github:SirVer/ultisnips'])
call vam#ActivateAddons(['github:ternjs/tern_for_vim'])
call vam#ActivateAddons(['github:helino/vim-json'])
call vam#ActivateAddons(['github:pangloss/vim-javascript'])
call vam#ActivateAddons(['github:rking/ag.vim'])
call vam#ActivateAddons(['github:moll/vim-node'])
call vam#ActivateAddons(['github:sidorares/node-vim-debugger'])
" call vam#ActivateAddons(['github:honza/vim-snippets'])

let g:UltiSnipsExpandTrigger = "<c-j>"
" let g:UltiSnipsListSnippets="<c-s-tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



call vam#ActivateAddons(['github:xolox/vim-session'])
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

 call vam#ActivateAddons(['github:tomtom/tcomment_vim'])

call vam#ActivateAddons(['github:scrooloose/nerdtree'])
" Prevent :bd inside NERDTree buffer
au FileType nerdtree cnoreabbrev <buffer> bd <nop>
au FileType nerdtree cnoreabbrev <buffer> BD <nop>
au BufRead,BufNewFile *.md set filetype=markdown
" NERDTree settings
let NERDTreeChDirMode=0
let NERDTreeIgnore=['\env','>vim$', '\~$', '>pyc$', '>swp$', '>egg-info$', '>DS_Store$', '^dist$', '^build$']
let NERDTreeSortOrder=['^__>py$', '\/$', '*', '>swp$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeHightlight=1

call vam#ActivateAddons(['github:oblitum/rainbow'])
let g:rainbow_active = 1
let g:rainbow_operators = 2
let  g:rainbow_ctermfgs = [
            \ 'brown',
            \ 'Darkblue',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'darkmagenta',
            \ 'darkmagenta',
            \ 'Darkblue',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'red',
            \ ]

"###################### display settings ##########################
set textwidth=0
set wrapmargin=1
set wrap              " don't wrap lines
set linebreak
set nolist
set fo+=l
set scrolloff=2         " 2 lines above/below cursor when scrolling
set relativenumber
set number              " show line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2        " use 2 lines for the status bar
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html
set showtabline=0       " do not want to see how many files are open
set switchbuf=usetab       " switch to another window, possibly in another tab, if the buffer is currently displayed in another window

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set expandtab           " turn a tabs into spaces
set foldmethod=syntax
set foldnestmax=10
set foldlevel=1
set nofoldenable
set fileformat=unix     " file mode is unix
set cc=100              " set colourcolum at 100
"set fileformats=unix,dos    # only detect unix file format, displays that ^M with dos files
set noautochdir
" system settings
set lazyredraw          " no redraws in macros
set confirm             " get a dialog when :q, :w, or :wq fails
set nobackup            " no backup~ files.
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file'
set hidden              " remember undo after quitting
set history=100          " keep 100 lines of command history
set mouse=a             " use mouse in visual, normal,insert,command,help mode (shift key disables)
set ttymouse=xterm2
set undodir=~/.vim/undodir
set undofile
set undolevels=10000 "maximum number of changes that can be undone
set undoreload=100000 "maximum number lines to save for undo on a buffer reload
set incsearch
syntax on          " enable colors
set hlsearch       " highlight search (very useful!)
set incsearch       "search incremently (search while typing)
set splitright
set splitbelow

"######################### Function Key Mappings ####################
nmap <F2> :cnext <cr>
nmap <F3> :cprev <cr>
map <F4> :TagbarToggle <cr>
nmap <F5> :NERDTreeToggle  <CR>
nmap <F6> zi <cr>
nmap <F7> :setlocal spell! spelllang=en_gb<CR>
nnoremap j gj
nnoremap k gk
noremap gr :diffget //3<cr>
noremap gl :diffget //2<cr>
" open quickfix after a grep
autocmd QuickFixCmdPost *grep* cwindow
" " Add and delete spaces in increments of `shiftwidth' for tabs
" " Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//
" " Convert all tab characters to two spaces
command! Untab :%s/\t/  /g
"
" set switchbuf=useopen,usetab,newtab
"  map <C-t><up> :tabr<cr>
"  map <C-t><down> :tabl<cr>
"  map <C-t><left> :tabp<cr>
"  map <C-t><right> :tabn<cr>
"################### Miscellaneous ##########################################
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;yellow\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  " silent !echo -ne "\033]12;red\007"
   " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufWinLeave *.* mkview!
au BufWinEnter *.* silent loadview

au BufWritePost *.* mksession! ~/session.vim
noremap <C-s> :source ~/session.vim

"#### EASY NAVIGATION IN INSERT MODE  ################################
noremap <A-j> <Left>
noremap <A-k> <Down>
noremap <A-l> <Up>
noremap <A-m> <Right>
inoremap <A-j> <Left>
inoremap <A-k> <Down>
inoremap <A-l> <Up>
inoremap <A-m> <Right>

"################### save on lost focus ###########################
au FocusLost * :wa
" save on lost focus/make etc.
set autoread autowrite
"######################### Easy window navigation #################
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"forgot to sudo before editing a file that requires root privileges
cmap w!! w !sudo tee % >/dev/null

call vam#ActivateAddons(['github:altercation/vim-colors-solarized'])
let g:solarized_termcolors = 16
syntax enable
set t_Co=16
colorscheme solarized
set background=dark
