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

function install_dependancie_manager()
{
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

###
# Install a package
###
function install_package_from_repo()
{
    sudo dnf install -yq $1
}

function main()
{
    # Install vim end dependancies.
    print_info "Start dependancies installation"
    install_package_from_repo "vim curl git"
    install_dependancie_manager
    print_success "Dependancies has been installed with success"

    print_info "Start install vimrc"
    mv ./src/vimrc ~/.vimrc
    if [ -f ~/.vimrc ];then
        print_success "Vimrc has been installed with success"
    fi

}

main
