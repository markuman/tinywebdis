#!/bin/bash

# take one c compiler of you choice!
if (("$#" == 0)); then
  CC=gcc
else
  CC=$1
fi

# build luadyad
$CC -Iluadyad/dyad/src/ luadyad/dyad/src/dyad.c -llua luadyad/luadyad.c -o tinywebdis

# build lsocket
$CC -fPIC -Ilsocket-1.3-1 -shared -llua lsocket-1.3-1/lsocket.c -o lsocket.so

# link resp.lua to ./
ln -s resp/resp.lua ./