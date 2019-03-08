#!/bin/ash

usage_insert() 
{ 
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
	      echo $name

	      ;;
	    e)
	      email="${OPTARG}"
	      echo $email
	      ;;
	    p)
	      phone="${OPTARG}"
	      echo $phone
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
		echo $name $email $phone >> ../database/addressbook.db
	fi
}