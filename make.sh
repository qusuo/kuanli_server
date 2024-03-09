#!/bin/sh

dir=$(
    cd $(dirname $0) || exit
    pwd
)
echo $dir
echo $1

if [ ! $1 ]; then
    cmd='help'
    
else
    cmd=$1
fi

if [ $cmd = "all" ]; then
    git submodule update --init --recursive

    echo -e "\n make pbc"
    cd $dir/pbc && pwd
    make all
    echo -e "\n make pbc binding"
    cd $dir/pbc/binding/lua53 && pwd
    make all

    echo -e "\n make skynet"
    cd $dir/skynet && pwd
    make linux

elif [ $cmd = "clean" ]; then
    echo -e "\n clean skynet"
    cd $dir/skynet && pwd
    make clean

    echo -e "\n clean pbc"
    cd $dir/pbc && pwd
    make clean

    echo -e "\n clean pbc binding"
    cd $dir/pbc/binding/lua53 && pwd
    make clean
elif [ $cmd = "init" ]; then
    if
        ! command -v autoconf &
        >/dev/null
    then
        echo "Installing autoconf..."
        sudo apt-get update
        sudo apt-get install -y autoconf
        sudo apt-get install build-essential
    else
        echo "autoconf is already installed."
    fi
else
    echo "make help"
    echo "make.sh all"
    echo "make.sh clean"
fi
