#!/bin/ash

source module/insert-user.sh
source module/search-user.sh
source module/delete-user.sh
source module/edit-user.sh

usage() 
{ 
    echo "Usage: COMMANDS: 
                - insert : insert user
                - delete : delete user
                - search : search for user"
    exit 1
}

delete()
{
    delete_user "$@"
}

search()
{
    search_user "$@"
}

insert()
{
    insert_user "$@"
}

edit()
{
    edit_user "$@"
}

main()
{

    if [ $1 = '-h' ]; then
        usage

    elif [ $1 = delete ]; then
        shift
        delete "$@"

    elif [ $1 = search ]; then
        shift
        search "$@"

    elif [ $1 = insert ]; then
        shift
        insert "$@"

     elif [ $1 = edit ]; then
        shift
        edit "$@"
    fi

}

main "$@"