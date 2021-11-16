# SSHKeyForward
Share private keys from KeePassXC to Windows OpenSSH agent and from there to WSL2.

## Enable Windows OpenSSH agent service
```
#Set the sshd service to be started automatically
Get-Service -Name sshd | Set-Service -StartupType Automatic

# Now start the sshd service
Start-Service sshd
```

## KeePassXC Setup
Tools -> Settings -> SSH Agent
* Enable SSH Agent integration
* Use OpenSSH for Windows instead of Pageant
![KeePassXC SSH Agent](/imgs/keepassxc.png)

KeePassXC supports private keys in OpenSSH format. Key files can be addded to entry in advanced section -> attachments.

After adding SSH key to entry new menu button "SSH Agent" will be displayed. There you can check information about the key. 

## WSL2 Setup
Install socat package
`apt install socat`

Create .ssh folder in $home
`mkdir $HOME/.ssh`

Download latest npiperelay, unzip it and put npiperelay.exe in $HOME/.ssh
https://github.com/jstarks/npiperelay/releases/latest

```
wget https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_amd64.zip
unzip npiperelay_windows_amd64.zip
mv npiperelay.exe $HOME/.ssh
```

Add to end of .bashrc in $HOME

```
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0 ]; then
    rm -f $SSH_AUTH_SOCK
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/.ssh/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi
```

Relaunch WSL2 shell after editing .bashrc.

## Test
* Add identity from KeePassXC to SSH Agent (Right click on Entry -> Add key to SSH Agent)
* Check SSH agent on Windows `ssh-add -L`
* Check SSH agent on WSL2 `ssh-add -L`