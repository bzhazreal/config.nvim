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

function main()
{
    # Install vim end dependancies.
    print_info "Start dependancies installation"
    sudo dnf install -yq vim curl git
    print_success "Dependancies has been installed with success"

    print_info "Start install vimrc"
    if [ -f ~/.vimrc ];then
      print_info "A vimrc file already exist, let's backup it before installing a new one"
      mv ~/.vimrc ~/.vimrc.bkp.$(date +”%s”)
      cp ./src/vimrc ~/.vimrc
    else
      cp ./src/vimrc ~/.vimrc
    fi

    if [ -f ~/.vimrc ];then
        print_success "Vimrc has been installed with success"
    fi

}

main
