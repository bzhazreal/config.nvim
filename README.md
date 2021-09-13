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
