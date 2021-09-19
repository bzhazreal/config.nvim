# Vim configuration

This repo contains my vim configuration and dependancies installer, build for fedora.

## How to test :

Requirements :

- Bash
- Make
- Docker

### Testing command

```shell
# Build testing container :
make build

# Test plugins installation :
make vim
:source %
:PlugInstall

# Test plugins in the container test env :
make shell
vim
:source %
:PlugInstall
# Happy testing.

# Delete testing container :
make clean
```

## How to install
```shell
# If you use make commands
make install
# Else
bash install.sh

# After that
vim ~/.vimrc
# A lot of warning will appear, press <Enter>
# When vim is open type :
PlugInstall
# After installation
:qa!
# Happy vim
```
