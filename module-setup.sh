#!/bin/bash

installkernel() {
    hostonly='' instmods '=drivers' '=net' '=fs' '=arch' '=crypto' '=lib'

}

install() {
    return 0
}
