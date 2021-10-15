#!/usr/bin/env bash

###
# Fonts
###
red="\e[0;91m"
blue="\e[0;94m"
green="\e[0;92m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

###
# Vars
###
INIT_VIM_FILENAME=init.vim
INIT_VIM_DIR_PATH=~/.config/nvim/
INIT_VIM_FULLPATH=${INIT_VIM_DIR_PATH}${INIT_VIM_FILENAME}

function print_error()
{
    printf "[${red}${bold}%s${reset}] - %s \n" "error" "$1"
}

function print_success()
{
    printf "[${green}${bold}%s${reset}] - %s \n" "success" "$1"
}

function print_info()
{
    printf "[${blue}${bold}%s${reset}] - %s \n" "status" "$1"
}

function install_package()
{
    local packages = "neovim curl git fd-find"
    if command -v dnf &> /dev/null;then
        sudo dnf install -yq ${packages}
    elif command -v apt &> /dev/null;then
        sudo apt install -yq ${packages}
    fi
}

function main()
{
    # Install vim end dependancies.
    print_info "Start dependancies installation"
    install_package
    print_success "Dependancies has been installed with success"

    print_info "Start install init.vim"
    if [ -f ${INIT_VIM_FULLPATH}  ];then
        print_info "A init.vim file already exist, let's backup it before installing a new one"
        mv ${INIT_VIM_FULLPATH}   ${INIT_VIM_FULLPATH}.$(date +%s)
        cp ./src/init.vim  ${INIT_VIM_FULLPATH}
    else
        mkdir -p ${INIT_VIM_DIR_PATH}
        cp ./src/init.vim  ${INIT_VIM_FULLPATH}
    fi

    if [ -f ${INIT_VIM_FULLPATH} ];then
        print_success "Init.vim has been installed with success"
    fi

}

main
