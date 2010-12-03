"
"
"  OblivionSVN Plugin
"
"   -- optedoblivion
"

set switchbuf=useopen

function! SVNsetup()
    if bufnr("[OblivionSVN]") > 0
        exe "sb [OblivionSVN]"
    else
        exe "split [OblivionSVN]"
    endif
    setlocal noswapfile
    set buftype=nofile
    setlocal modifiable
    normal ggdG
endfunction

function! SVNunsetup()

    setlocal nomodified
    setlocal nomodifiable
    set filetype=man
    normal 1G

endfunction

function! SVNError(error)
    execute "silent read ! echo OblivionSVN: '" . a:error . "' && echo && echo"
endfunction

function! SVNNoFileError()
    call SVNError("No file loaded, flagging -a option.")
endfunction

function! GetCurrentFile()
    let currentFile = bufname(bufnr('%'))
    if currentFile != ""
        return currentFile
    else
        return -1
    endif
endfunction

function! SVNLog(option)
    let currentFile = GetCurrentFile()
    call SVNsetup()
    if a:option == '-a'
        execute "silent read ! svn log" 
    elseif a:option == '-soc'
        execute "silent read ! svn log --stop-on-copy"
    else
        if currentFile == -1
            call SVNNoFileError()
            execute "silent read ! svn log"
        else
            execute "silent read ! svn log " . currentFile
        endif
    endif
    call SVNunsetup()
endfunction

function! SVNAdd()
    let currentFile = GetCurrentFile()
    execute ":w " . currentFile
    call SVNsetup()
    execute "silent read ! svn add " . currentFile
    call SVNunsetup()
endfunction

function! SVNUp()
    execute ":w"
    execute "silent! svn up"
endfunction

function! SVNStatus(option)
    let currentFile = GetCurrentFile()
    call SVNsetup()
    if a:option == '-a'
        execute "silent read ! svn status"
    else
        if currentFile == -1
            call SVNNoFileError()
            execute "silent read ! svn status"
        else
            execute ":w " . currentFile
            execute "silent read ! svn status " . currentFile
        endif
    endif
    call SVNunsetup()
endfunction

function! SVNCommit(option)
    let currentFile = GetCurrentFile()
    if a:option == '-a'
        execute "! svn commit"
        execute "silent ! svn up"
    else
        if currentFile == -1
            call SVNNoFileError()
        else
            execute ":w " . currentFile
            execute "! svn commit " . currentFile
            execute "silent ! svn up " . currentFile
        endif
    endif
endfunction

function! SVNInfo(option)
    let currentFile = GetCurrentFile()
    if a:option == "-a"
        execute "silent read ! svn info"
    else
        if currentFile == -1
            call SVNNoFileError()
            execute "silent read ! svn info"
        else
            execute "silent read ! svn info " . currentFile
        endif
    endif
endfunction

function! SVNDiff()
    let currentFile = GetCurrentFile()
    if currentFile == -1
        call SVNNoFileError()
    else
        if bufnr("[OblivionSVN]") > 0
            exe "sb [OblivionSVN]"
        else
            exe "sp [OblivionSVN]"
        endif
        setlocal noswapfile
        set buftype=nofile
        setlocal modifiable
        normal ggdG
        execute "silent read ! svn diff " . currentFile
        call SVNunsetup()
    endif
endfunction

function! SVNDelete()
    let currentFile = GetCurrentFile()
    if currentFile == -1
        call SVNError('No file loaded.')
    else
        execute "! svn delete " . currentFile
    endif
endfunction

function! SVNRevert()
    let currentFile = GetCurrentFile()
    if currentFile == -1
        call SVNError("No file loaded.")
    else
        execute "! svn revert " . currentFile
    endif
endfunction

function! SVNHelp()
    call SVNsetup()
    execute "silent read ! echo 'OblivionSVN Commands'"
    execute "silent read ! echo '   SVNAdd - Add file to SVN repository.'"
    execute "silent read ! echo '   SVNCommit - Commit file/CWD to repository.'"
    execute "silent read ! echo '   SVNDelete - Deletes file from repository.'"
    execute "silent read ! echo '   SVNLog - Shows log of file/CWD.'"
    execute "silent read ! echo '   SVNStatus - Shows status of file/CWD.'"
    execute "silent read ! echo '   SVNUp - Updates local from repository.'"
    call SVNunsetup()
endfunction

command SVNUp :call SVNUp()
command SVNDelete :call SVNDelete()
command SVNHelp :call SVNHelp()
command SVNDiff :call SVNDiff()
command SVNRevert :call SVNRevert()
command -nargs=* SVNLog :call SVNLog('<args>')
command -nargs=* SVNAdd :call SVNAdd('<args>')
command -nargs=* SVNStatus :call SVNStatus('<args>')
command -nargs=* SVNCommit :call SVNCommit('<args>')
