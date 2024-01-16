#!/bin/bash
#
# Terminal Decorator.
# by Henry
# 6/6/2020
#

usageAndBail() {
    cat <<EOF
Usage:
    mambo [flags]
    Ex: mambo -rc   -> Open Release Control
Flags
    -h  | --help      Display help message
    -k  | --kanban    Open mambo kaban
    -rt | --retro     Open retro doc
    -rc | --release   Open release control sheet
    -hi | --history   Open sprint history sheet
    -d  | --daily     Open mambo daily room
    -me | --henry     Open Henry Daily room (Personal ID: https://squaretrade.zoom.us/my/henry.st)
EOF

   exit 1;
}

unsetValue='UNSET'
pQueryParam='pwd='
mamboKanbanUrl="${rootJiraUrl}secure/RapidBoard.jspa?rapidView=523&useStoredSettings=true"
urlToOpen=$unsetValue

# Process command line arguments
while [ -n "$1" ]; do
case "$1" in
        -h  | --help)          usageAndBail; exit 1; shift;;
        -k  | --kanban)        urlToOpen="https://jira.squaretrade.com/secure/RapidBoard.jspa?rapidView=523&useStoredSettings=true"; shift;;
        -rt | --retro)         urlToOpen="https://docs.google.com/spreadsheets/d/1zviVNilsueSvCXS8xtAwuUkayw16ifJ-KDOYep8Vhxw"; shift;;
        -rc | --release)       urlToOpen="https://docs.google.com/spreadsheets/d/1mFq_8AlPOEz4-5NQ-1CngEAzLHyiXfv12ceJ14Q9Gw8/"; shift;;
        -sh | --history)       urlToOpen="https://docs.google.com/spreadsheets/d/1ZisuFxTvZ2gUATIRzWMv8LQf8Ym8RrMCvYis3FqfQ78/edit#gid=0"; shift;;
        -d  | --daily)         urlToOpen="zoommtg://zoom.us/join?confno=9410449663&${pQueryParam}N043Ry93Nk9naHYybFhTbXBSNm5KQT09"; shift;;
        -me | --henry)         urlToOpen="zoommtg://zoom.us/join?confno=6283766295&${pQueryParam}YklEMWhZQWFEWGxQSDU5amNSNU4yQT09"; shift;;
        -*)                    echo "ERROR: Invalid option: $1" >& 2; usageAndBail; exit 1;;
         *)                    echo "ERROR: Invalid option: $1" >& 2; usageAndBail; exit 1;;
    esac
done

open $urlToOpen
