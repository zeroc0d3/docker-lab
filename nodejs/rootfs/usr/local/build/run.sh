#!/usr/bin/env sh

function usage {
    echo -e "Usage: $(basename "$0") [-u <URL>] [-r <COMMIT>] [-p <DIR>] [-s <FILE>] [-t <DURATION>]"
    echo -e ""
    echo -e "Build a project."
    echo -e ""
    echo -e "Options:"
    echo -e "  -u, --git-url <URL>\t\tthe git repository URL of the project"
    echo -e "  -r, --git-ref <COMMIT>\tthe git reference to build"
    echo -e "  -p, --project <DIR>\t\tthe project directory"
    echo -e "  -s, --script <FILE>\t\tthe build script file to run"
    echo -e "  -t, --timeout <DURATION>\tthe build execution timeout"
    echo -e ""
    echo -e "  -h, --help\t\t\tdisplay this help and exit"
}

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -u|--git-url)
        if [ -z "$2" ]; then
            usage
            exit 1
        fi

        BUILD_GITURL=$2
        shift 2
        ;;

        -r|--git-ref)
        if [ -z "$2" ]; then
            usage
            exit 1
        fi

        BUILD_GITREF=$2
        shift 2
        ;;

        -p|--project)
        if [ -z "$2" ]; then
            usage
            exit 1
        fi

        BUILD_PROJECT=$2
        shift 2
        ;;

        -s|--script)
        if [ -z "$2" ]; then
            usage
            exit 1
        fi

        BUILD_SCRIPT=$2
        shift 2
        ;;

        -t|--timeout)
        if [ -z "$2" ]; then
            usage
            exit 1
        fi

        BUILD_TIMEOUT=$2
        shift 2
        ;;

        -h|-help)
        usage
        exit 0
        ;;

        *)
        usage
        exit 1
        ;;
    esac
done

if [ -z "${BUILD_GITURL}" ]; then
    echo "BUILD_GITURL is not set, aborting" >&2
    exit 1
fi

if [ -z "${BUILD_GITREF}" ]; then
    echo "BUILD_GITREF is not set, aborting" >&2
    exit 1
fi

if [ -z "${BUILD_SCRIPT}" ]; then
    BUILD_SCRIPT="/usr/local/build/build.sh"
fi

if [ -z "${BUILD_TIMEOUT}" ]; then
    BUILD_TIMEOUT=3600
fi

trap 'exit 2' INT TERM

cd "${0%/*}" || exit 2

if [ ! -d project ]; then
    status=0
    retry=0

    while true; do
        git clone "${BUILD_GITURL}" project && status=1 || retry=$((retry+1))

        if [ $status -eq 1 ]; then
            break
        fi

        if [ $retry -ge 3 ]; then
            echo "Failed to clone repository, aborting" >&2
            exit 3
        fi
    done

    cd project || exit 2

    git checkout "${BUILD_GITREF}" || exit 2
else
    cd project || exit 2

    git reset --hard || exit 2
    git clean -fdx || exit 2

    git remote set-url origin "${BUILD_GITURL}" || exit 2

    status=0
    retry=0

    while true; do
        git fetch origin && status=1 || retry=$((retry+1))

        if [ $status -eq 1 ]; then
            break
        fi

        if [ $retry -ge 3 ]; then
            echo "Failed to fetch repository, aborting" >&2
            exit 3
        fi
    done

    git checkout "${BUILD_GITREF}" || exit 2
fi

if [ ! -z "${BUILD_PROJECT}" ]; then
    cd ${BUILD_PROJECT} || exit 2
fi

timeout -t ${BUILD_TIMEOUT} /bin/bash "${BUILD_SCRIPT}" || exit 4
