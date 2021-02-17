#!/usr/bin/env bash

sudo apt-get install hub
repos=("cqf-tooling|https://github.com/cqframework/cqf-tooling.git|master")

cwd=$(pwd)
for i in "${repos[@]}"
do
    : 
    IFS='|' read -r -a parts <<< "$i"
    echo "${parts[0]} ${parts[1]} ${parts[2]}"
    rm -rf ${parts[0]}
    git clone --depth 1 "${parts[1]}" -b "${parts[2]}"
    cd ${parts[0]}
    if [ -f ./scripts/maintenance.sh ]
    then
        git checkout -b cql-maintenance-bot
        bash ./scripts/maintenance.sh
        if [ $(git status --porcelain | wc -l) -eq "0" ]; then
            echo "No changes detected for ${parts[0]}"
        else
            # git commit -m "Maintenance Script Execution"
            # git push origin --force cql-maintenance-bot
        fi
    else
        echo "No maintenance script found for ${parts[0]}"
    fi

    cd $cwd
done

