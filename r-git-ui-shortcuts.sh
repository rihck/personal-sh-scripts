#!/bin/bash
#
# Terminal Decorator.
# by Henry
# 6/6/2020
#

usageAndBail() {
    cat <<EOF
Usage:
    stgit [service alias] [flags]
    Ex 1: rgit awsc                     -> Opens service repo
    Ex 2: rgit awsc -b master           -> Opens service repo in master branch
    Ex 3: rgit awsc -c myBranch         -> Opens service repo comparing your branch with the repo default/main branch
    Ex 4: rgit awsc -c master myBranch  -> Opens service repo comparing 2 branches
    PS -> Not providing service name, opens Git Root URL

Flags
    -h | --help       Display help message
    -c | --compare    Open comparing your branch, you can open comparing your branch to the default repo branch OR compare 2 branches just need to pass both as parameters
    -b | --branch     Open in a specific branch, just need to pass both a parameter

Supported repos and its aliases:
    Billing Core:              [awsc | aws-cert]
    Coding Challenges          [lc   | cl | coding-challenges]
    Study Concepts             [sc   | study-concepts]
    Personal Notes             [pcp  | psn  | personal-notes]
    Java 11 Cert Notes         [jc11  | java11 | java-cert]
EOF

   exit 1;
}

rootGitUrl='https://github.com/rihck/'
urlToOpen=$rootGitUrl
compareBranchs=0
openSelectedBranch=0

unsetValue='UNSET'
branchCompBase="${unsetValue}"
branchSelectedCompare="${unsetValue}"
branchSelectedToOpen="${unsetValue}"

# Process command line arguments
while [ -n "$1" ]; do
case "$1" in
        awsc | aws-cert)                         urlToOpen+="aws-cloud-practitioner-exam-study" ; shift ;;
        lc   | cl | coding-challenges)           urlToOpen+="coding-challenges" ; shift ;;
        sc   | study-concepts)                   urlToOpen+="study-concepts" ; shift ;;
        psn  | personal-notes)                   urlToOpen+="psn" ; shift ;;
        jc11  | java11 | java-cert)              urlToOpen+="java-11-certification" ; shift ;;

        #Flags
        -c  | --compare)
                      if [ -z "$2" ]; then
                        echo "WARNING: Flag [-c] used in a wrong way, right use:\n\nstgit -c branchToCompare -> (to compare with the default/main repo branch) \nstgit -c baseBranch branchToCompare (to compare with two branchs)\n\nPS: Use -h for help"; exit 1;
                      fi

                      ##Checking if user provided two branches for comparison or only informed one to compare with the repository default one
                      if [ -z "$3" ]; then
                        branchSelectedCompare="$2"; compareBranchs=2; shift 2;
                      else
                        branchCompBase="$2"; branchSelectedCompare="$3"; compareBranchs=1;
                      fi
                      shift 3;;

        -b  | --branch)
                      if [ -z "$2" ]; then
                        echo "WARNING: Flag [-b] used in a wrong way, right use:\n\nstgit -b branchToOpen\n\nPS: Use -h for help"; exit 1;
                      fi
                      branchSelectedToOpen="$2"; openSelectedBranch=1; shift 2;;
        -h|--help)   usageAndBail; exit 1; shift;;
        -*)  echo "ERROR: Invalid option: $1" >& 2; usageAndBail; exit 1;;
        #*)   echo "ERROR: Unknown option: $1" >& 2; usageAndBail; shift;;
    esac
done

if [ "$compareBranchs" = "1" ]; then
    urlToOpen+="/compare/${branchCompBase}...${branchSelectedCompare}"
fi

if [ "$compareBranchs" = "2" ]; then
    urlToOpen+="/compare/${branchSelectedCompare}"
fi

if [ "$openSelectedBranch" = "1" ] && [ "$compareBranchs" = "0" ]; then
    urlToOpen+="/tree/${branchSelectedToOpen}"
fi

#TODO: Support multiple services as parameters (use a list or something)
open $urlToOpen