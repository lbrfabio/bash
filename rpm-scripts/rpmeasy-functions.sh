# TODO: change into a full script;
# TODO: check for rpmwand installed
# TODO: implement a more generic download
# TODO: add help function

#function checkExec () {
#    if [ -z `which $1` ]; then
#        echo "$1 not present"
#        exit
#    fi
#}

#checkExec "rpmwand"

function prepare_env() {

    SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

    PKG_NAME=$1
    SKEL=$2     #source of skeleton and script
    DEST=$3     #destination of rpm and tar.gz
    TEMP=/tmp/$PKG_NAME-rpm

    mkdir -p $DEST && mkdir -p $TEMP && cd $TEMP
}

function download() {
    echo "TODO"
}

function skeleton() {
    echo "TODO"
}

function prepare_build() {
    if [ ! -f "$TEMP/pkg.in" ]; then
            exit 1;
    fi

    # initialize and edit *spec.in
    rpmwand initspec $PKG_NAME

    if [[ $1 == "python" ]]; then
        build_python_bytecompile_off
    fi

    # update spec.in
    while read LINE; do
        VAR=`echo $LINE | cut -d ':' -f 1`

        case "$VAR" in
            Summary|Vendor|Packager|License)
                sed -i "s/$VAR: TODO. PLEASE EDIT ME\!/$(echo $LINE)/g" "$PKG_NAME".spec.in
                ;;
            Group)
                sed -i "s,Group: TODO. PLEASE EDIT ME\!,$(echo $LINE),g" "$PKG_NAME".spec.in
                ;;
            URL)
                sed -i "s,URL: http://TODO.example.com/,$(echo $LINE),g" "$PKG_NAME".spec.in
                ;;
            Description)
                sed -i "s/^TODO. PLEASE EDIT ME\!/$(echo $LINE | cut -d ':' -f 2)/g" "$PKG_NAME".spec.in
                ;;
            Requires)
                sed -i "s/#Requires:/$(echo $LINE)/g" "$PKG_NAME".spec.in
                ;;
            *)
                echo -e "$VAR ignored"
        esac
    done < $TEMP/pkg.in

    # editing *files.txt and fix symbolics links and other conflicts
    rpmwand files $PKG_NAME
}

function build_python_bytecompile_off() {
    # Turn off the brp-python-bytecompile script
    # %global __os_install_post %(echo '%{__os_install_post}' | sed -e 's!/usr/lib[^[:space:]]*/brp-python-bytecompile[[:space:]].*$!!g')
    PYTHON_COMPILE_OFF="$SOURCE_DIR/turn-off-python-bytecompile"
    sed -i "1i$(cat $PYTHON_COMPILE_OFF)\n" *spec.in
}

function build_rpm() {
    #TODO: if VERSION or RELEASE not present, add some default values

    VERSION=$1
    RELEASE=$2
    ARCH=$3

    if [ -z $ARCH ]; then
        ARCH=`uname -m`
    fi

    HOME=$TEMP #this force to build inside $TEMP and not $HOME
    rpmwand build $PKG_NAME $VERSION $RELEASE $ARCH
}

function install_rpm() {
    RPM="$TEMP/RPMS/$ARCH/$PKG_NAME-$VERSION-$RELEASE.$ARCH.rpm"

    # erase the old package (to avoid unwanted files around the system...)
    sudo dnf -y erase $PKG_NAME

    # install
    sudo dnf -y install $RPM

    # save the rpm
    cp $RPM $DEST/

    #TODO: add option to save also source tar.{gz,bz2}
    #cp $FILE $DEST/

    # cleanup
    rm -rf $TEMP
}
