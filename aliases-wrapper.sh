#!/bin/bash
# Wrapper to import all listed sh scripts in your: .bashrc, .bash_profile or .zshrc
#
# Example: source personal-sh-scripts/aliases-wrapper.sh
#
#

actual_dir="$(dirname "$0")"

alias rgit='sh ${actual_dir}/r-git-ui-shortcuts.sh'