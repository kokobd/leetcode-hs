cmake_minimum_required(VERSION 3.13)
project(leetcode-hs LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

add_library(leetcode_hs STATIC
        src/p12.c
        src/p13.c
        src/p14.c
        src/p15.c
        src/p16.c
        src/p17.c
        src/p19.cpp
        src/p20.c
        src/p21.cpp
        src/uthash.h
        )
set_property(TARGET leetcode_hs PROPERTY POSITION_INDEPENDENT_CODE ON)
