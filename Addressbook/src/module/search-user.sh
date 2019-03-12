#!/bin/ash

db="../database/addressbook.db"

usage_search() 
{
	echo "---------------------------------------"
	echo "Search for User"
	echo "Usage: [-u <user> ] [-e <email>] [-p <phone>]" 
	echo "---------------------------------------"
	exit 1 
}

search_user()
{

	match="cat $db"

	while getopts "u:e:p:h" o; do
	  case "$o" in
	    u)
		  name="${OPTARG}"
	      c=" | awk -F':' -v NAME="$name" '{if (\$1 == NAME) print \$0}'"
	      match="$match $c"
	      ;;
	    e)
		  email="${OPTARG}"
	      c=" | awk -F':' -v EMAIL="$email" '{if (\$2 == EMAIL) print \$0}'"
	      match="$match $c"
	      ;;
	    p)
          phone="${OPTARG}"
	      c=" | awk -F':' -v PHONE="$phone" '{if (\$3 == PHONE) print \$0}'"
	      match="$match $c"
	      ;;
	    h)
	      usage_search
	      ;;
	  esac
	done
	eval $match

}