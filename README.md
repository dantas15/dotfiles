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

Currently, I have some notes for the following:

- [Pop!_OS](./pop_os/)
  - the [post install](./pop_os/postinstall.sh) script is a really useful one, I got most of it from [diolinux](https://github.com/Diolinux/pop-os-postinstall)
- [Manjaro](./manjaro/)
