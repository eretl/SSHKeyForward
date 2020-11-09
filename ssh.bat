powershell -WindowStyle Hidden -Command Start-Process -NoNewWindow 'C:\Program Files\PuTTY\pageant.exe'
powershell -WindowStyle Hidden -Command Start-Process -NoNewWindow 'C:\ssh\wsl-ssh-pageant-amd64.exe' '--winssh ssh-pageant --systray -force --'
powershell -WindowStyle Hidden -Command Start-Process -NoNewWindow 'C:\Program Files\VcXsrv\xlaunch.exe' '-run .\config.xlaunch'
setx SSH_AUTH_SOCK \\.\pipe\ssh-pageant
