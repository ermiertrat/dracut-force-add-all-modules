#!/bin/bash

installkernel() {
    # target kernel version dracut is building for
    local kv="${kernel_version:-$(uname -r)}"
    local moddir="/lib/modules/$kv"

    if [[ ! -d "$moddir" ]]; then
        echo "Warning: no kernel modules dir: $moddir"
        return 1
    fi

    # convert omit_drivers into an array
    local omit_list=()
    for d in $omit_drivers; do
        omit_list+=("$d")
    done

    # helper to check if a driver is in omit list
    omitempty() {
        local drv="$1"
        for o in "${omit_list[@]}"; do
            [[ "$drv" == "$o" ]] && return 0
        done
        return 1
    }

    # walk every .ko file and instmods it unless omitted
    while IFS= read -r file; do
        # strip prefix and suffix
        local mod="${file#$moddir/}"
        mod="${mod%.ko}"

        # if exact match or wildcard in omit list, skip
        # (use simple pattern matching for wildcards)
        local skip=0
        for pattern in "${omit_list[@]}"; do
            if [[ "$mod" == $pattern ]]; then
                skip=1
                break
            fi
        done

        (( skip )) && continue

        instmods "$mod"
    done < <(find "$moddir" -type f -name '*.ko')
}

install() {
    return 0
}
