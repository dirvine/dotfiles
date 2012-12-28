"Help 
"spell checker ]s -next workd s[ -previous zg -add word zug -undo add z= -suggestions
" Tabs nav - Alt-<num>
" vimdiff - do - get changes from other, dp - put changes to other, [c next
" change c[ rpevious change (diffoff to turn off) 
"\p< #include<...> \p" #include"..." 
"\cfr (framed comment) 
" \im (add main) 
"\rc (save compile and run)
"\rr (run exe)
" View any blob, tree, commit, or tag in the repository with :Gedit (and :Gsplit, :Gvsplit, :Gtabedit, ...). Edit a file in the index and write to it to stage the changes. Use :Gdiff to bring up the staged version of the file side by side with the working tree version and use Vim's diff handling capabilities to stage a subset of the file's changes.

"Bring up the output of git status with :Gstatus. Press - to add/reset a file's changes, or p to add/reset --patch that mofo. And guess what :Gcommit does!

":Gblame brings up an interactive vertical split with git blame output. Press enter on a line to reblame the file as it stood in that commit, or o to open that commit in a split. When you're done, use :Gedit in the historic buffer to go back to the work tree version.

":Gmove does a git mv on a file and simultaneously renames the buffer. :Gremove does a git rm on a file and simultaneously deletes the buffer.

"Use :Ggrep to search the work tree (or any arbitrary commit) with git grep, skipping over that which is not tracked in the repository. :Glog loads all previous revisions of a file into the quickfix list so you can iterate over them and watch the file evolve!

":Gread is a variant of git checkout -- filename that operates on the buffer rather than the filename. This means you can use u to undo it and you never get any warnings about the file changing outside Vim. :Gwrite writes to both the work tree and index versions of a file, making it like git add when called from a work tree file and like git checkout when called from the index or a blob in history.

"Use :Gbrowse to open the current file on GitHub, with optional line range (try it in visual mode!). If your current repository isn't on GitHub, git instaweb will be spun up instead.
filetype off
set runtimepath+=~/.vim/addons/vam
call vam#ActivateAddons(['hg:http://hg.dfrank.ru/vim/bundle/dfrank_util'])
call vam#ActivateAddons(['hg:http://hg.dfrank.ru/vim/bundle/vimprj'])
call vam#ActivateAddons(['github:kien/ctrlp.vim'])
call vam#ActivateAddons(['github:proyvind/Cpp11-Syntax-Support'])
call vam#ActivateAddons(['github:oblitum/clang_complete'])
call vam#ActivateAddons(['github:flazz/vim-colorschemes'])
call vam#ActivateAddons(['github:jiangmiao/auto-pairs'])
call vam#ActivateAddons(['github:tpope/vim-fugitive'])
call vam#ActivateAddons(['github:xuhdev/SingleCompile'])
call vam#ActivateAddons(['github:scrooloose/nerdtree'])
" NerdTree"
" Prevent :bd inside NERDTree buffer
au FileType nerdtree cnoreabbrev <buffer> bd <nop>
au FileType nerdtree cnoreabbrev <buffer> BD <nop>
" NERDTree settings
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\env','>vim$', '\~$', '>pyc$', '>swp$', '>egg-info$', '>DS_Store$', '^dist$', '^build$']
let NERDTreeSortOrder=['^__>py$', '\/$', '*', '>swp$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeHightlight=1
call vam#ActivateAddons(['github:Lokaltog/vim-easymotion'])
call vam#ActivateAddons(['github:ervandew/supertab'])
call vam#ActivateAddons(['github:altercation/vim-colors-solarized'])
""let g:solarized_termcolors=16
syntax enable
""set background=dark
""colorscheme solarized
call vam#ActivateAddons(['github:SirVer/ultisnips'])
call vam#ActivateAddons(['github:oblitum/rainbow'])
filetype plugin indent on
" reset to vim-defaults
if &compatible          " only if not set before:
    set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" display settings
set nospell               " set nowrap              " don't wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
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

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=2           " number of spaces a tab counts for
set shiftwidth=2        " spaces for autoindents
set expandtab           " turn a tabs into spaces

set fileformat=unix     " file mode is unix
"set fileformats=unix,dos    # only detect unix file format, displays that ^M with dos files

" system settings
set lazyredraw          " no redraws in macros
set confirm             " get a dialog when :q, :w, or :wq fails
set nobackup            " no backup~ files.
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file'
set hidden              " remember undo after quitting
set history=50          " keep 50 lines of command history
set mouse=a             " use mouse in visual, normal,insert,command,help mode (shift key disables)
set undodir=~/.vim/undodir
set undofile
set undolevels=10000 "maximum number of changes that can be undone
set undoreload=100000 "maximum number lines to save for undo on a buffer reload
set incsearch
" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
    syntax on          " enable colors
    set hlsearch       " highlight search (very useful!)
   set incsearch       "search incremently (search while typing)
endif
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags=./tags;/
map <C-> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <F7> mzgg=G`z<CR>
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
"c-support stuff
let g:C_CFlags  = '-std=c++11 -stdlib=libc++ -fPIC -ldl -g -o0'
let g:C_CplusCompiler = 'clang++'

highlight LongLine ctermbg=Blue guibg=DarkYellow
highlight WhitespaceEOL ctermbg=Grey guibg=DarkYellow
if v:version >= 702
  " Lines longer than 100 columns.
  au BufWinEnter * let w:m0=matchadd('LongLine', '\%>100v.\+', -1)

  " Whitespace at the end of a line. This little dance suppresses
  " whitespace that has just been typed.
  au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
  au InsertEnter * call matchdelete(w:m1)
  au InsertEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
  au InsertLeave * call matchdelete(w:m1)
  au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
else
  au BufRead,BufNewFile * syntax match LongLine /\%>100v.\+/
  au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
  au InsertLeave * syntax match WhitespaceEOL /\s\+$/
endif
set nocompatible
" FOLDING
augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
      au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
set nofoldenable
" Optional
" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp,cc  set cindent
  au BufNewFile,BufRead *.cpp,*.cc.*.h set syntax=cpp11
augroup END
" open quickfix after a grep
autocmd QuickFixCmdPost *grep* cwindow
" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab
" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                      \ exe "normal g'\"" | endif 
" Automatically open, but do not go to (if there are errors) the quickfix /
" " location list window, or close it when is has become empty.
" "
" " Note: Must allow nesting of autocmds to enable any customizations for
" quickfix
" " buffers.
" " Note: Normally, :cwindow jumps to the quickfix window if the command opens
" it
" " (but not if it's already open). However, as part of the autocmd, this
" doesn't
" " seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  endfunction
set switchbuf+=usetab,newtab
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
set errorformat^=%-GIn\ file\ included\ %.%# 
set path=../src/*/include,../src/*/src/,../src/,../src/third_party_libs/boost/,../src/,/usr/include/

"I keep pressing Q when I mean q
cmap Q q
nnoremap <silent> <Leader>s :CtrlP ../src/<CR>
nnoremap <silent> <Leader>q :NERDTree ../src/<CR>
let g:ctrlp_max_files = 100000
"nmap <f9> :!clang++ -std=c++11 -stdlib=libc++ -ldl -c % <cr>
noremap <F6> <C-O>za
nnoremap <F6> za
onoremap <F6> <C-C>za
vnoremap <F6> zf
" cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h

nmap <F2> :cnext <cr> 
nmap <S-F2> :cprev <cr> 
" chdir to current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" "no cursor keys
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" nnoremap j gj
" nnoremap k gk
"save on lost focus
au FocusLost * :wa
" save on lost fucus/make etc.
set autoread autowrite 
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"forgot to sudo before editing a file that requires root privileges 
cmap w!! w !sudo tee % >/dev/null
set statusline=
set statusline+=%{fugitive#statusline()}
set statusline+=[%n]                                  "buffernr
set statusline+=%<%F\                                "File+path
set statusline+=\ %y\                                  "FileType
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=\ col:%03c\                            "Colnr
set statusline+=\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
" Clang Complete Settings
  set completeopt=menu,menuone,longest
""  Limit popup menu height
  set pumheight=15
  " SuperTab option for context aware completion
  let g:SuperTabDefaultCompletionType = "context"
  " Disable auto popup, use <Tab> to autocomplete
  let g:clang_complete_auto=1
  " Show clang errors in the quickfix window
  let g:clang_complete_copen=1
  "let g:clang_user_options = '|| exit 0'
  let g:clang_user_options = '-std=c++11 -stdlib=libc++ -ldl'
  let g:clang_use_library=1
  let g:clang_complete_copen=1
  let g:clang_library_path="/usr/lib/"
  let g:clang_snippets=1
  let g:clang_snippets_engine='clang_complete'
  let g:clang_conceal_snippets=1
  let g:clang_trailing_placeholder=1
  set conceallevel=2 
  set concealcursor=inv
"let g:clang_auto_user_options="/home/dirvine/.clang_complete""
"  "
