#!/bin/ash

. module/insert-user.sh
. module/search-user.sh
. module/delete-user.sh

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
    fi

}

main "$@"