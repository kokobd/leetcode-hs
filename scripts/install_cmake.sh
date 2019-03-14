#!/usr/bin/env bash

set -e
version=3.13
build=4

currentCMakeVersion=$(cmake --version)
expectedCMakeVersion="cmake version 3.13.4"

if [ "${currentCMakeVersion}" != "${expectedCMakeVersion}" ]; then
  rm -rf ~/opt/cmake
  cmakeInstallFileName=cmake-${version}.${build}-Linux-x86_64.tar.gz
  mkdir -p ~/opt
  cd ~/opt
  wget https://cmake.org/files/v${version}/${cmakeInstallFileName}
  tar xf ${cmakeInstallFileName}
  rm ${cmakeInstallFileName}
  mv cmake-${version}.${build}-Linux-x86_64 cmake
fi
