#!/bin/ash

. module/insert-user.sh

usage() 
{ 
    echo "Usage: COMMANDS: 
                - insert : insert user
                - delete : delete user
                - search : search for user"
    exit 1
}

main()
{
    echo $1

    if [ $1 = '-h' ]; then
        usage

    elif [ $1 = delete ]; then
        shift
        echo "DELETE COMMAND"

    elif [ $1 = search ]; then
        shift
        echo "SEARCH COMMAND"

    elif [ $1 = insert ]; then
        shift
        insert_user "$@"
    fi

}

main "$@"