#!/bin/bash
as -ad --64 -o echo.o echo.S && \
    ld -Ttext 400000 -nostdlib --oformat binary -o echo echo.o
if ! [ -x "echo" ];then
    chmod u+x echo
fi

# check if elf header is OK
[ $( which readelf ) ] && readelf -h ./echo
