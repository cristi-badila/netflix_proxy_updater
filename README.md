To install:
- clone the repository/download the files
- ensure you have a ssh key (to generate a new one use: `ssh-keygen -t dsa`)
- copy your public ssh key to the server (eg: `scp id_dsa.pub root@192.168.1.3:./id_dsa.pub`)
- add the key to authorized_keys2 files
```
	[dave@julia dave]$ cd .ssh
	[dave@julia .ssh]$ touch authorized_keys2
	[dave@julia .ssh]$ chmod 600 authorized_keys2
	[dave@julia .ssh]$ cat ../id_dsa.pub >> authorized_keys2
	[dave@julia .ssh]$ rm ../id_dsa.pub
```
- run setup.vbs