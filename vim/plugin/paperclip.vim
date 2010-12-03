"
"
"  Paperclip Plugin
"
"

set switchbuf=useopen

function! Setup()
    if bufnr("GayPaperclip") > 0
        exe "sb GayPaperclip"
    else
        exe "split GayPaperclip"
    endif
    setlocal noswapfile
    set buftype=nofile
    setlocal modifiable
    normal ggdG
endfunction

function! Unsetup()

    setlocal nomodified
    setlocal nomodifiable
    set filetype=man
    normal 1G

endfunction

function! Paperclip()
    call Setup()
    execute "silent read ! cat ~/.vim/plugin/paperclips/paperclipprint.txt"
    call Unsetup()
endfunction

"imap <silent> print <Esc>:call Paperclip()<CR>
command Paperclip :call Paperclip()
