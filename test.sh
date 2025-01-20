#!/bin/bash
export SRC_DIR="$PWD/src"

function traverse() {
    local current_dir="$1"
    local prefix="$2"
    local is_last="$3"
    local is_root="$4"

    local branch_char="├── "
    local next_prefix="$prefix│   "
    
    if [[ "$is_last" == "true" ]]; then
        branch_char="└── "
        next_prefix="$prefix    "
    fi

    if [[ "$is_root" != "true" ]]; then
        if [[ -f "$current_dir/run.sh" ]]; then
            pushd "$current_dir" >/dev/null 2>&1
            result=$(bash "./run.sh")
            echo "${prefix}${branch_char}${current_dir##*/}: $result"
            popd >/dev/null 2>&1
        else
            echo "${prefix}${branch_char}${current_dir##*/}/"
        fi
    fi

    local subdirs=()
    while IFS= read -r -d '' dir; do
        [[ -d "$dir" ]] && subdirs+=("$dir")
    done < <(find "$current_dir" -mindepth 1 -maxdepth 1 -type d -print0)

    local subdir_count=${#subdirs[@]}
    local current_count=0

    for subdir in "${subdirs[@]}"; do
        ((current_count++))
        [[ $current_count -eq $subdir_count ]] && is_last="true" || is_last="false"
        traverse "${subdir}" "$next_prefix" "$is_last" "false"
    done
}

root_dir="${1:-.}/test"

traverse "$root_dir" "" "true" "true"
