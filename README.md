# config files

In this repo I keep some useful scripts to help and improve my setup, specially after a fresh install.

## Git 
- Since I use multiple configuration files, I always put the following to the main `.gitconfig` file:
```
[includeIf "gitdir:~/www/workdir/"]
    path = ~/www/workdir/.gitconfig
```
- And in the following workdir file I specified above:
```
[user]
    email = gus@workmail.com
```

