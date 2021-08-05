function gffs() {
    if [[ $# -gt 0 ]]
    then
        branch_name=${1}
    else
        branch_name=$(openssl rand -base64 12)
        branch_name=${branch_name//[\/+]/""}
    fi

    git flow feature start $branch_name
}

function gfff() {
    tag=$(get_actual_tag)
    git flow feature finish $tag
}

function gfrs() {
    tag=$(get_new_tag)
    git flow release start $tag
}

function gfrf() {
    tag=$(get_actual_tag)
    git flow release finish $tag
}

function gfhs() {
    tag=$(get_new_tag)
    git flow hotfix start $tag
}

function gfhf() {
    tag=$(get_actual_tag)
    git flow hotfix finish $tag
}

function get_actual_tag() {
    echo $(gab | cut -d '/' -f 2)
}

function get_new_tag() {
    today=$(date '+%Y%m%d')
    version=0

    result=true
    while $result
    do
        ((version=version + 1))
        tag="${today}.${version}"
        result=$(git_tag_exists $tag)
    done

    echo $tag
}

function git_tag_exists() {
    if [[ $(git tag | grep $1 | wc -l) -eq 0 ]]
    then
        echo false
    else
        echo true
    fi
}

function git_reset_soft() {
    git reset --soft ${1}
}


function git_reset_hard() {
    git reset --hard ${1}
}