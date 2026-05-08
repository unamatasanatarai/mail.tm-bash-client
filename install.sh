#!/usr/bin/env bash

# Pure Bash installer
# Only installs files starting with 'bail'

_t="${HOME}/.local/bin"
_s="${BASH_SOURCE[0]%/*}"
[[ "$_s" == "${BASH_SOURCE[0]}" ]] && _s="."

if [[ ! -d "$_t" ]]; then
    mkdir -p "$_t"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to create %s\n" "$_t" >&2
        exit 1
    fi
fi

shopt -s nullglob
for _f in "${_s}"/bail*; do
    [[ -d "$_f" ]] && continue

    _n="${_f##*/}"

    cp "$_f" "$_t/"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to copy %s\n" "$_n" >&2
        exit 1
    fi

    chmod +x "$_t/$_n"
    if [[ $? -ne 0 ]]; then
        printf "Error: Failed to set permissions on %s\n" "$_n" >&2
        exit 1
    fi

    printf "Installed: %s\n" "$_n"
done
shopt -u nullglob

if [[ ":$PATH:" != *":$_t:"* ]]; then
    printf "\nWARNING: %s is not in PATH\n" "$_t" >&2
    printf "Add to your shell config:\n" >&2
    printf "export PATH=\"\$HOME/.local/bin:\$PATH\"\n" >&2
    exit 2
fi

printf "\nInstallation complete\n"
