#!/usr/bin/env bash

# Fail if any command fails or if there are unbound variables and check syntax
set -euxo pipefail
bash -n "$0"

git config user.email $GITHUB_EMAIL
git config user.name $GITHUB_USER

cwd=$(pwd)
repos=("cqf-tooling|github.com/cqframework/cqf-tooling.git|master")
for i in "${repos[@]}"
do
    : 
    IFS='|' read -r -a parts <<< "$i"
    echo "${parts[0]} ${parts[1]} ${parts[2]}"
    rm -rf ${parts[0]}
    git clone --depth 1 "git://${parts[1]}" -b "${parts[2]}"
    cd ${parts[0]}
    if [ -f ./scripts/maintenance.sh ]
    then
        git checkout -b cql-maintenance-bot
        bash ./scripts/maintenance.sh
        if [ $(git status --porcelain | wc -l) -eq "0" ]; then
            echo "No changes detected for ${parts[0]}"
        else
            echo "Changed detected for ${parts[0]}"
            git add -u
            git commit -m "Maintenance script execution"
            git push "https://${GITHUB_TOKEN}@${parts[1]}" --force cql-maintenance-bot
            if [[ -z $(hub pr list -h cql-maintenance-bot) ]]; then
                hub pull-request -m "Autogenerated maintenance PR" -m "This PR was created automatically based on the maintenance script in this project."
                echo "PR created for ${parts[0]}"
            else
                echo "PR already exists for ${parts[0]}"
            fi
        fi
    else
        echo "No maintenance script found for ${parts[0]}"
    fi

    cd $cwd
done

