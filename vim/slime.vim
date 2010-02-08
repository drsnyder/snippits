
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function Send_to_Tmux(text)
  if !exists("g:tmux_sessionname") || !exists("g:tmux_windowname")
    call Tmux_Vars()
  end

  echo system("tmux send-keys -t" . g:tmux_sessionname . ":" . g:tmux_windowname . " '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
endfunction

function Tmux_Session_Names(A,L,P)
  return system("tmux list-clients | awk -F' ' '{ print $2 }'")
endfunction

function Tmux_Vars()
  if !exists("g:tmux_sessionname") || !exists("g:tmux_windowname")
    let g:tmux_sessionname = ""
    let g:tmux_windowname = "0"
  end

  let g:tmux_sessionname = input("session name: ", "", "custom,Tmux_Session_Names")
  let g:tmux_windowname = input("window name: ", g:tmux_windowname)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <leader>tt "ry :call Send_to_Tmux(@r)<CR>
nmap <leader>tt vip<leader>tt

nmap <leader>t v :call Tmux_Vars()<CR>
