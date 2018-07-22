## Introduction
dirstack-plus is an enhanced version of the [dirstack](ftp://ftp.gnu.org/old-gnu/Manuals/bash-2.02/html_node/bashref_63.html#SEC71) utiliy in unix/linux systems which maintains a list of recently-visited directories and provides commands(pushd, popd, dirs) to view and switch between these directories. dirstack-plus enhances these simple commands to provide a tree view of the dirstack and much more convenient commands to navigate through it. 

## Installation 

1) Create ~/.dirstack folder
2) Copy all the files to ~/.dirstack
3) Move  ~/.dirstack/dt and ~/.dirstack/getprjnum to where you put your executable script (/usr/local/bin, /usr/bin/ etc.).
4) Add the following line to your ~/.bashrc file
    ```bash
    source $HOME/.dirstack/dsfunc.sh
    ```

5) Restart your terminal.
