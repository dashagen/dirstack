## Introduction
**dirstack-plus** is an enhanced version of the [dirstack](https://www.gnu.org/software/bash/manual/html_node/Directory-Stack-Builtins.html) utiliy in unix/linux systems which maintains a list of recently-visited directories and provides commands(pushd, popd, dirs) to view and switch between these directories. **dirstack-plus** enhances these simple commands to provide a tree view of the dirstack and much more convenient commands to navigate through it. 


## Installation 

1. Create ~/.dirstack folder
2. Copy `dsfunc.sh` to ~/.dirstack
3. Copy  `dt` and `getprjnum` to where you put your executable scripts (/usr/local/bin, /usr/bin/, /$HOME/bin/ etc.). Just make sure the path is added to $PATH
4. Add the following line to your ~/.bashrc file
   ```bash
   source $HOME/.dirstack/dsfunc.sh
   ```
5. Restart your terminal.


## Usage

### Launching the terminal
Whenever your terminal is opened, previous directory stack associated with the current tty number will be loaded. 
```
Previously...
 0  /Users/dashagen/Documents/Fun
 1  /Users/dashagen/Music/iTunes
 2  /Users/dashagen/Pictures
 3  /Users/dashagen

```
And you will be at directory 0 (in this case "/Users/dashagen/Documents/Fun"). You can then navigate the directories as usual. Following are the commands:

### List directory tree
type `dt` to list the directory tree. In actual terminal the directory 0 will be in blue background and directory 1, the one last visited, will be highligted in red.
```
$> dt
|__ Users
    |__ dashagen............................................(3)
        |__ Documents
        |   |__ Fun.........................................(0)
        |   
        |__ Music
        |   |__ iTunes......................................(1)
        |   
        |__ Pictures........................................(2)

```
Now you can either navigate to a directory by its number ([`r`](#rotate-to-a-directory)) or enter into a new directory. In the latter case you can either replace the current directory ( `cd` new_directory )  or keep the current directory and push a new one to the stack ( [`pu`] (#push-a-new-directory) ).

### Rotate to a directory


