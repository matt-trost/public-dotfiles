" --------------------------------- Misc. ------------------------------------
" Modelines have had major security issues, so disable them.
set nomodeline

" Use this if you don't want vim to try to be compatible with vi. This should
" unlock some vim-specific functionality.
"set nocompatible

" Turn off error bells.
"set noerrorbells

" ------------------------------ Shortcuts -----------------------------------
" Map jj to escape in insert mode.
inoremap jj <Esc>

" Map ff to save file in normal mode.
nnoremap ff :w<Enter>

" Map Ctrl-hjkl to switch windows.
" Note that on mac, Option (even when Terminal is configured to use Option as
" 'Meta') seems to only send an <Esc> before the character. As a result,
" mapping Option-hjkl (which would have been my first choice) is more
" troublesome than it should be. See the below links for more info.
" https://www.mail-archive.com/vim_mac@googlegroups.com/msg05489.html
" https://www.mail-archive.com/vim_mac@googlegroups.com/msg05487.html
noremap <c-h> :wincmd h<Enter>
noremap <c-j> :wincmd j<Enter>
noremap <c-k> :wincmd k<Enter>
noremap <c-l> :wincmd l<Enter>

" Faster scrolling with Up/Down arrow keys. Use jk for fine scrolling.
nnoremap <Up> 5k
nnoremap <Down> 5j

" Use Ctrl-w ] to open tag in a new vertical split, instead of the default
" horizontal split behavior.. Note that if the tag doesn't exist or if the
" tags file isn't set, this leaves you with a useless vsplit. Ideally it
" wouldn't split in that case, so keep an eye out for a better method.
nnoremap <C-w>] :vsplit <Enter> <C-]>

" Note: default <leader> key is the backslash; this vimrc does not change it.

" Open vimrc in a separate split.
nnoremap <leader>v :vsplit $MYVIMRC <Enter>

" Source from vimrc.
nnoremap <leader>s :source $MYVIMRC <Enter>

" Read tags file, moving upwards towards root directory until one is found.
nnoremap <leader>t :set tags=tags;/ <Enter>

" Copy selected text to system clipboard.
vnoremap <leader>c "+y

" Mass comment // starting from the first column.
vnoremap <leader>/ 0:norm i// <Enter>
nnoremap <leader>/ 0:norm i// <Enter>

" Mass uncomment // starting from the first column
vnoremap <leader>? 0:norm xxx<Enter>
nnoremap <leader>? 0:norm xxx<Enter>

" -------------------------------- Colors ------------------------------------
" Preferred colorscheme
color ron

" Use this if on the Basic OSX terminal profile.
"color default

" Use filetype-based syntax highlighting.
syntax on


" ------------------------------ Navigation ----------------------------------
" Enable mouse support.
" Note that enabling mouse support comes at the cost of not being able to
" mouse-highlight text in vim and right-click copy it (to be pasted somewhere
" else). This means that if you need to copy text out of vim into something
" non-vim you'll have to either temporarily disable mouse support with
" 'set mouse=' (nothing after the '='), or just cat the file to the terminal or
" something. This doesn't come up often since most of the time any
" file I'd copy to would also be openable in vim, so a split-screen or
" additional buffer and a vim copy will do the trick.
set mouse=a

" let backspace move back past the start of edit, auto-indenting, start of line.
set backspace=start,indent,eol

"make it so there are at minimum 2 lines of context before the top or bottom
"of the screen as you scroll.
set scrolloff=2


" ------------------------- Displaying Information----------------------------
" Show 'hybrid' line numbers at the left. To return to pure absolute line
" numbers, enter ':set norelativenumber'.
" Note that in order to take advantage of the relativenumbers, you should
" navigate via <relative_number>j/k to jump up and down. This is faster than
" holding down j/k to scroll the cursor.
"
" Using autocmds to only show relative line numbers in the focused window.
" Note that the autocmds are in an augroup for easy deletion; see:
" https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup
augroup LineNumbers
  au!
  au WinEnter * set number relativenumber
  au BufWinEnter * set number relativenumber
  au FocusGained * set number relativenumber
  au FocusLost * set number norelativenumber
  au WinLeave * set number norelativenumber
augroup END

" Highlight the 80th column.
set colorcolumn=80

" always show statusline at bottom.
set laststatus=2

" emulate the default statusline, but with full path.
set ruler
set statusline=%F\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" display the current buffer number at the end of the statusline.
set statusline+=%3.3n

" Enable command line tab completion. Change the behavior of it with different
" settings for wildmode.
set wildmenu
set wildmode=longest:list,full

" A note about matches:
" vim supports up to three active matches at a time, with 1match (aka match),
" 2match, and 3match. If you don't use a different match id, e.g. if you match
" one thing after another in your vimrc, then only the last match will be
" used. Also note that 3match, is reserved for the built-in default
" parentheses/bracket highlighting behavior, and should therefore not be used.
" matchadd() is a way to define unlimited matches, but although it seems to be
" able to add matches (i.e. ':echo getmatches()' returns matches created with
" matchadd(), it doesn't seem to highlight them?? As a result, you are using
" regular match, and the single match pattern matches multiple things (trailing
" whitespace and excess newlines).
"
" Note that the WinEnter is used when creating a split that does not open a
" new/different buffer, but it does not activate when initially starting vim,
" so both WinEnter and BufWinEnter are needed.

" Highlight trailing whitespace and excess newlines.
highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=#FFD9D9
augroup HighlightExtraWhitespace
  au!
  au WinEnter * match ExtraWhitespace /\s\+$\|^$\n\{2,}/
  au BufWinEnter * match ExtraWhitespace /\s\+$\|^$\n\{2,}/
  au BufWinLeave * call clearmatches()
augroup END

" Show commands as they're typed. Will appear on right side of command line.
" The command will disappear once it times out (default 1000ms) if it is not
" completed.
set showcmd

" Open vertical splits to the right, not to the default left.
set splitright

" ------------------------------- Searching ---------------------------------
" Highlight search results. Can disable with 'set nohlsearch'.
set hlsearch

" Highlight and jump as the search is entered.
"set incsearch

" Case-insensitive search. Can disable with 'set noignorecase'.
set ignorecase

" Press Space to turn off highlight and clear any message already displayed.
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>


" ------------------------- Indentation Management ---------------------------
" Sad attempts at indentation management below...
" Though they seem to work well enough so far...
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" To auto indent an entire file use gg=G. To indent a range, highlight the
" range visually then press =
" see: https://stackoverflow.com/questions/506075/how-do-i-fix-the-indentation-of-an-entire-file-in-vi
"
" In a similar vein, to apply 80chars (or whatever the textwidth is) to a
" range, highlight the range and then type gq


" ------------------------------- Plugins ------------------------------------
" First, install fzf and Ag.
" https://github.com/junegunn/fzf
" https://github.com/ggreer/the_silver_searcher
"
" Then, use Vim 8.0+ built-in package manager. Create directory
" ~/.vim/pack/any_name/start
" and git clone fzf.vim into there:
" https://github.com/junegunn/fzf.vim
"
" You may or may not need to add this line to vimrc:
"set rtp+=~/.fzf

" Per https://github.com/junegunn/fzf/blob/master/README-VIM.md:
set rtp+=/usr/local/opt/fzf

" ------------------ Reference: Normal Mode Navigation -----------------------
"
" READ: Top answer ("your problem with vim is that you don't grok vi") to:
" https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim
"
" When you use vim, you are speaking a language. You are communicating to vim
" what you want it to do at a higher level of abstraction than arrow key or
" mouse clicks. If you grok this you will unlock the efficiency that vim can
" offer. The goal is to edit text at the speed of thought -- as fast as you
" can think, there it is.
"
" Jump up and down in the file based on relative line numbers.
"<relative_number>j/k

" Go to a specific absolute line number. This is particularly useful when
" going to problematic lines identified by build errors/warnings.
"<absolute_number>gg

" Go to the top/bottom of the file.
"gg (top)
"G (bottom)

" Move the cursor to the ___ of the screen
"H (for top)
"M (for middle)
"L (for bottom)

" Center the screen at the current line:
"zz

" Scroll screen without moving cursor
"CTRL-e (for up)
"CTRL-y (for down)

" From anywhere within a given code block, jump to the opening/closing
" bracket/parenthesis of the block
"[{ (opening bracket)
"]} (closing bracket)
"[( (opening paren)
"]) (close paren)


" --------------------------------- Tags -------------------------------------
" Generating tags for directory and all subdirectories with ctags. Note that
" macOS default ctags won't work, you need to install exuberant? ctags.
"ctags -R .

" Loading tags.
"set tags=/path/to/tags/file

" Automatically look for tags file in current directory, then upward until
" found.
"set tags=tags;/

" Navigating to a tag.
":tag <tag_name>


" ------------------------------- Reference ----------------------------------
" Using leaders may be useful later.
"let mapleader=","
"map <leader>h :wincmd h<CR>
"map <leader>j :wincmd j<CR>
"map <leader>k :wincmd k<CR>
"map <leader>l :wincmd l<CR>

" Use ]p to paste with auto indent alignment to the destination block!

" USING TABS
" https://vim.fandom.com/wiki/Using_tab_pages
"tabe
"gt
"gT


" Use buffers https://vim.fandom.com/wiki/Vim_buffer_FAQ
":bp
":bn
":bf
":bn
":b[number]
":e [filename]


" Use integrated terminal
":term
":vert :term
"Ctrl-w :q! (Close terminal)
"Ctrl-w N (go to normal mode)
"i (get out of normal mode)

" Open help
":help (or :vert :help)

" Use split screens
":sp
":vs
"Ctrl-w to navigate
"Ctrl-w | to max width of current split
"Ctrl-w = to normalize all split sizes
"Ctrl-w _ to max height of current split
"Ctrl-w R to swap left-right or top-bottom splits
"Ctrl-w T to break out current window into a new tabview

" multi-line edit
" see @rampion's answer on https://stackoverflow.com/questions/355907/how-do-i-repeat-an-edit-on-multiple-lines-in-vim

" MACROS
" https://vim.fandom.com/wiki/Macros

" Copying to system clipboard:
" https://unix.stackexchange.com/questions/12535/how-to-copy-text-from-vim-to-an-external-program
" visual highlight, then "+y
" note that pasting from system clipboard is easy:
" insert mode, then command-V like normal.

" Keep cursor in middle of screen by setting 'scrolloff'
" https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
"set so=999
"set so=0 to restore default behavior
"
"
"https://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim


" -------------------- Blogs, Tips, and Tutorials ----------------------------
" https://susamn.medium.com/its-time-to-edit-effectively-in-vim-a-visual-article-76f9d0b45938

" Vim plugins and tips from Stanford CS110 instructor:
" https://reberhardt.com/cs110/summer-2018/handouts/tools-tips/#vim-plugins-tips

" Learn vim navigation while playing a game: https://vim-adventures.com/

" A student-led class at MIT that covers shell, vim, git, and more:
" https://missing.csail.mit.edu/

" https://stevelosh.com/blog/2010/09/coming-home-to-vim/

" https://thoughtbot.com/upcase/onramp-to-vim

" Fantastic presentation with shortcuts:
" https://www.slideshare.net/ZendCon/vim-for-php-programmers-presentation
