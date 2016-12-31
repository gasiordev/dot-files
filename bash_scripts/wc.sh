#!/usr/local/bin/bash

src=$1
name=$2

usage() {
    echo "wc.sh x|l repository_name"
}

if [[ $src != "x" && $src != "l" ]]; then
    usage
    exit 1
fi

if [[ ! $name =~ ^[a-zA-Z0-9]+$ ]]; then
    usage
    exit 1
fi

dir="$HOME/wc/gh/$src"
mkdir -p "$dir"
cd "$dir"

if [[ $src == "x" ]]; then
    github_user="xnicholas"
elif [[ $src == "l" ]]; then
    github_user="laatugroup"
fi

github_repo="$name"

git clone "https://github.com/$github_user/$github_repo"
