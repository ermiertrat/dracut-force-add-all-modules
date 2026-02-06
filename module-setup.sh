#!/bin/bash

installkernel() {
    # target kernel version dracut is building for
#     local kv="${kernel_version:-$(uname -r)}"
    local moddir="$srcmods"

    if [[ ! -d "$moddir" ]]; then
        echo "Warning: no kernel modules dir: $moddir"
        return 1
    fi


    # If omit_drivers is unset or empty, treat as no omit filter
    local omit_regex="${omit_drivers:-}"

    # Walk all .ko files under the modules directory
    while IFS= read -r file; do
        # get module name relative to modules dir, strip .ko suffix
        local mod="${file#$moddir/}"
        mod="${mod%.ko}"

        # skip if module name matches omit_drivers regex
        if [[ -n "$omit_regex" && "$mod" =~ $omit_regex ]]; then
            continue
        fi

        instmods "$mod"
    done < <(find "$moddir" -type f -name '*.ko')
    
}

install() {
    return 0
}
