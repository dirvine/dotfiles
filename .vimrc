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

call pathogen#infect()
filetype plugin indent on

" reset to vim-defaults
if &compatible          " only if not set before:
    set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" display settings
set background=dark     " enable for dark terminals
set spell               " set nowrap              " don't wrap lines
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
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden              " remember undo after quitting
set history=50          " keep 50 lines of command history
set mouse=a             " use mouse in visual, normal,insert,command,help mode (shift key disables)

set incsearch
" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
    syntax on          " enable colors
    set hlsearch       " highlight search (very useful!)
   set incsearch       "search incremently (search while typing)
endif

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
"c-support stuff
let g:C_CFlags  = '-std=c++11 -stdlib=libc++ -fPIC -ldl -g -o0'
let g:C_CplusCompiler = 'clang++'

highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
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
set t_Co=16
"let g:solarized_termcolor=16
"colorscheme solarized
" Complete options (disable preview scratch window)
"set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=15
 " SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = ""
" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto=1
" Show clang errors in the quickfix window
let g:clang_complete_copen=1
let g:clang_user_options = '-std=c++11 -stdlib=libc++ -Wall -ldl'
let g:clang_use_library=0
let g:clang_complete_copen=1
let g:clang_library_path="/usr/lib/"
let g:clang_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=1
let g:clang_trailing_placeholder=1
set conceallevel=2 concealcursor=inv
"let g:clang_auto_user_options="/home/dirvine/.clang_complete"
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                      \ exe "normal g'\"" | endif 

function OpenNERDTree()
    execute ":NERDTree"
endfunction
command -nargs=0 OpenNERDTree :call OpenNERDTree()
nmap <ESC>t :OpenNERDTree<CR>


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
set path=../src/*/include,../src/*/src/,../src/,../src/third_party_libs/boost/,../src/,/usr/include/c++/v1,/usr/include/
" Move the cursor to the window left of the current one
noremap <silent> ,h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> ,j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> ,k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> ,l :wincmd l<cr>

" Close the window below this one
noremap <silent> ,cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> ,ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> ,ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> ,cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> ,cc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> ,ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> ,mk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> ,mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> ,mj <C-W>J
nnoremap <silent> <Leader>s :CommandT ../src/<CR>
nmap <f9> :!clang++ -std=c++11 -stdlib=libc++ -ldl -c % <cr>

" cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h

nmap <F2> :cnext <cr> 
nmap <S-F2> :cprev <cr> 
" chdir to current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe
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
