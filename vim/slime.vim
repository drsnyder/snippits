
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Originally from
"" http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/

function Send_to_Screen(text)
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    call Screen_Vars()
  end

  echo system("screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X stuff '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
endfunction

function Screen_Session_Names(A,L,P)
  return system("screen -ls | awk '/Attached/ {print $1}'")
endfunction

function Screen_Vars()
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    let g:screen_sessionname = ""
    let g:screen_windowname = "0"
  end

  let g:screen_sessionname = input("session name: ", "", "custom,Screen_Session_Names")
  let g:screen_windowname = input("window name: ", g:screen_windowname)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <leader>cc "ry :call Send_to_Screen(@r)<CR>
nmap <leader>cc vip<leader>cc

nmap <leader>c v :call Screen_Vars()<CR>

