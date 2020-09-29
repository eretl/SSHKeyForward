# SSHKeyForward
Sdílení privátní klíčů z KeePassXC do peagantu a následně do OpenSSH na windows, nebo WSL2

## Nastavení KeePassXC
KeePassXC podporuje privátní klíče ve formátu OpenSSH, nikoliv ve formátu PPK, který generuje putty, proto je nutno tento formát převést.  
Následně lze přidat tento soubor jako vlastnost prvku v seznamu hesel.
V upravě záznamu se objeví nová možnost SSH agent, kde nastavíte jako přílohu privátní klíč a také zaškrtnete přidání a odebrání klíče při zamčení.  
V nástroje -> nastavení -> SSH agent je nutné zapnout integraci s SSH agentem (Pagent již musí běžet, jinak skončí s chybou).  

## Nastavení CMD
set SSH_AUTH_SOCK=\\.\pipe\ssh-pageant

## Nastavení  WSL-SSH-pageant
https://github.com/benpye/wsl-ssh-pageant

Script při staru windows 
`wsl-ssh-pageant-amd64.exe --systray --winssh ssh-pageant`

## Nastavení WSL2
https://github.com/jstarks/npiperelay
Na WSL nainstalujte balíček socat.
`apt install socat`

Na Windows stáhněte do složky C:\ssh soubor npiperelay z odkazu.

Do ~/.bash_rc
`socat EXEC:"/mnt/c/ssh/npiperelay.exe /\/\./\pipe/\ssh-pageant" UNIX-LISTEN:/tmp/wsl-ssh-pageant.socket,unlink-close,unlink-early,fork`


## Test
V pegant by si měli zobrazovat klíče podle toho jak je načte KeePassXC.
V CMD a Linuxu by měl příkaz `ssh-add -L` zobrazit seznam dostupných klíčů.
