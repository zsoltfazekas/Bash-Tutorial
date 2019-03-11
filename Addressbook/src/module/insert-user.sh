#!/bin/ash

. module/search-user.sh

db="../database/addressbook.db"

usage_insert() 
{
	echo "---------------------------------------"
	echo "Insert User" 
	echo "Usage: [-u <user> ] [-e <email>] [-p <phone>]"
	echo "---------------------------------------"
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
		exist=`search_user -e $email | wc -l`
		if [ $exist -eq 0 ]; then
			echo "${name}:${email}:${phone}" >> $db 2>&1
			echo "---------------------------------------"
			echo "User ${name} inserted!"
			echo "---------------------------------------"
		else
			echo "---------------------------------------"
			echo "User with email ${email} already exist!"
			echo "---------------------------------------"
		fi
	fi
}