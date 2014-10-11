#!/bin/bash
git_prompt() {
    git_status_output=$(git status 2> /dev/null) || return
    branch_status=$(git status --porcelain --branch)

    branch_name() {
        sed -n 's/^.*On branch //p' <<< "$git_status_output"
    }

    number_of_commits() {
        [[ "$branch_status" =~ ("$1")[[:space:]]([0-9]+) ]] \
            && echo ${BASH_REMATCH[2]}
    }

    match_against_status() {
        [[ "$git_status_output" =~ ${1} ]]
    }

    working_dir_clean() {
        match_against_status '(working directory clean)'
    }

    local_changes() {
        local staged='^.*Changes to be committed'
        local not_staged='^.*Changes not staged for commit'
        match_against_status "($staged|$not_staged)"
    }

    untracked_files() {
        match_against_status '^.*Untracked files'
    }

    repeat_char() {
        eval printf "%.0s$1" {1..$2}
    }

    local bold="\033[1m"
    local no_colour="\033[0m"

    ahead_arrow() {
        if commits_ahead=$(number_of_commits "ahead")
        then
            echo -e "$bold$(repeat_char - $commits_ahead)$no_colour>" \
                "$commits_ahead ahead"
        fi
    }

    behind_arrow() {
        if commits_behind=$(number_of_commits "behind")
        then
            echo "$commits_behind behind" \
                "<$bold$(repeat_char - $commits_behind)$no_colour"
        fi
    }

    branch_part() {
        local red="\033[31m"
        local green="\033[32m"
        local yellow="\033[33m"
        local branch_colour=$green

        if untracked_files
        then
            branch_colour=$red
        elif local_changes
        then
            branch_colour=$yellow
        fi
        echo "$branch_colour$(branch_name)$no_colour"
    }

    stash_part() {
        size=$(git stash list|wc -l)
        [ $size -gt 0 ] && echo "[$(repeat_char "≈" $size)]"
    }

    local behind_part=$(behind_arrow)
    local ahead_part=$(ahead_arrow)

    if [[ "$behind_part" || "$ahead_part" ]]
    then
        prompt="$behind_part|$ahead_part\n$(branch_part)"
    else
        prompt="$(branch_part)"
    fi

    echo -e "$prompt $(stash_part)"
}
