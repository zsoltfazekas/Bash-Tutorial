#!/bin/ash

db="../database/addressbook.db"

usage_insert() 
{
	echo "Insert User" 
	echo "Usage: [-u <string> ] [-e <string>] [-p <string>]" 
	exit 1 
}

insert_user()
{
	# echo $OPTARG
	name=
	email=
	phone=

	while getopts "u:e:p:h" o; do
	  case "$o" in
	    u)
	      name="${OPTARG}"
	      ;;
	    e)
	      email="${OPTARG}"
	      ;;
	    p)
	      phone="${OPTARG}"
	      ;;
	    h)
	      usage_insert
	      ;;
	    *) ;;
	  esac
	done

	if [ ! $name ] || [ ! $email ] || [ ! $phone ]; then
	    usage_insert
	else
		echo "${name}:${email}:${phone}" >> $db 2>&1
		echo "User inserted"
	fi
}