#!/usr/bin/env bash

set -e

version=3.13
build=4
cmakeInstallFileName=cmake-${version}.${build}-Linux-x86_64.tar.gz
mkdir -p ~/opt
cd ~/opt
wget https://cmake.org/files/v$version/${cmakeInstallFileName}
tar xf ${cmakeInstallFileName}
rm ${cmakeInstallFileName}
mv cmake-${version}.${build}-Linux-x86_64 cmake
ln -s ~/opt/cmake/bin/cmake ~/.local/bin/cmake
