#!/bin/bash

cd pandaPIparser
make -j

cd ../pandaPIgrounder
git submodule init
git submodule update
cd cpddl
make boruvka opts bliss lpsolve
make
cd ../src
make -j

cd ../../pandaPIengine
mkdir build
cd build
cmake ../src
make -j
