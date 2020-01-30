function la
  ls -A $argv
end
funcsave la

function ll
  ls -lF $argv
end
funcsave ll

function ls
  /sbin/ls --color=auto $argv
end
funcsave ls

function open
  xdg-open $argv
end
funcsave open

function st
  git status $argv
end
funcsave st

function trm
  trash-put $argv
end
funcsave trm
