#!/bin/bash
set -x

which grubby

# if grubby is not there, assume everything is fine and the setup was done on the host
if [ $? -ne 0 ]; then
    echo 0
fi

declare -a kargs=( "$@" )
eval `chroot /host/ grubby --info=DEFAULT | grep args`
ret=0

for t in "${kargs[@]}";do
    if [[ $args != *${t}* ]];then
        chroot /host/ grubby --update-kernel=DEFAULT --args=${t}
        let ret++
    fi
done
echo $ret
