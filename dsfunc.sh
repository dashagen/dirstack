# This script uses dt, a script to show direcotry stack
# in a tree layout

###################################
##  Initialization      ###########
###################################

# Get current tty number
tty_num=$(tty|sed -e 's/[^0-9]//g')

export DIRSFILE="$HOME/.dirstack/dirstack$tty_num"


# Load dirstack and Initialize dir# variables
dirlist=( `sort -k1nr $HOME/.dirstack/dirstack$tty_num|cut -c5-` )

for i in `seq 0 $((${#dirlist[@]}-1))`;do

    export dir$i=${dirlist[$i]}

    pushd ${dirlist[$i]} >/dev/null
done

popd -0 >/dev/null

echo
echo "Previously..."
dirs -v -l
echo



###################################
##  Define Functions  #############
###################################
function updatedirs()
{
    dirlist=( `cat $DIRSFILE|cut -c5-` )

    for i in `seq 0 $((${#dirlist[@]}-1))`;do
        export dir$i=${dirlist[$i]}
    done
}


# Set the title of an xterm to $PWD
function xtitle()
{
    echo -ne "\e]0;[$tty_num],$(basename "$(pwd)")\a"
}


# Clear current dirstack file
function cstack()
{
    DY_NS=`wc -l $DIRSFILE|awk '{print $1}'`

    for i in `seq 2 $DY_NS`
    do
        popd >/dev/null
    done

    cd $HOME

    sd
}


# Load dirs from a dirstack file
function lstack()
{
    DY_NS=`wc -l $DIRSFILE|awk '{print $1}'`

    for i in `seq 2 $DY_NS`
    do
        popd >/dev/null
    done

    for i in `sort -k1nr $1 | cut -c5- `;do
        pushd $i >/dev/null
    done

    sd
}



# List directories in the current stack
function sd()
{
    dirs -v -l >| $DIRSFILE
    dt
    updatedirs
    xtitle
}


# Re-engineered CD that will modify the dirstack each time
function cd()
{
    builtin cd "$@"
    dirs -v -l >| $DIRSFILE
    xtitle
}



# Rotate the dirstack
function r()
{
    if [ $1 ]; then

        for i in `seq 2 $1`; do
            pushd >/dev/null
            pushd +1 >/dev/null
        done

        pushd >/dev/null
    else
        pushd >/dev/null
    fi

    ls --color -ltr
    echo
    sd
}


# Go to dirstack by keyword
function g()
{
    if [ $1 ]; then
        PICKNUM=`grep -i $1 $DIRSFILE|head -1|awk '{print $1}'`
        r $PICKNUM
    else
        echo "missing searchword"
    fi
}


# Push into dirstack
function pu ()
{
    if [ $1 ]; then
        p_dir=${1/%\//}

        dirlist=( `cat $DIRSFILE|cut -c5-` )

        match_idx=-1

        for i in `seq 0 $((${#dirlist[@]}-1))`;do
            if [ "${dirlist[$i]}" = "$p_dir" ]; then
                match_idx=$i
            fi
        done

        if [ "$match_idx" = "-1" ]; then
            pushd "$1" >/dev/null
            sd
        else
            r $match_idx
        fi
    else
        pushd +1 >/dev/null
        sd
    fi
}



# Pop out of dirstack
function po()
{
    if [ $1 ]
    then
        popd "+$1" >/dev/null
    else
        popd +0 >/dev/null
    fi

    sd
}


# Show dirs in dirstack in order
sdd ()
{
    echo;
    echo "/-------------------------------------------------------------------";

    sort -k2 $DIRSFILE |
        awk '{
            if (NR%2==1)
            { print "\033[0;33m"$0"\033[0m"}

            else
            { print "\033[0;32m"$0"\033[0m"}

        }';
    echo "\-------------------------------------------------------------------"
}


