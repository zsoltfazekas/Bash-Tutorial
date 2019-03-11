#!/bin/ash

. module/search-user.sh

db="../database/addressbook.db"

usage_delete() 
{ 
	echo "---------------------------------------"
	echo "Delete User"
	echo "	Usage: [-u <username> ] [-e <email>] [-p <phone>]"
	echo "---------------------------------------" 
}

usage_delete_user()
{
	echo "---------------------------------------"
	echo "You can't delete|update multiple user at same time or User not found. Try to add different or more complex search criteria"
	usage_delete
	echo "---------------------------------------"
}

confirm()
{
	while true; 
	do
	    read -p "Do you want to delete this user?" yn
	    case $yn in
	        [Yy]* ) 
				coo="sed -i -e \"/${delete}/d\" $db"
				eval $coo
				echo "---------------------------------------"
				echo "User deleted"
				echo "---------------------------------------"
				break
				;;
	        [Nn]* )
				break
				;;
	        * ) echo "Please answer yes or no."
				;;
	    esac
	done
}

delete_user()
{

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
	      usage_delete
	      ;;
	  esac
	done

	comm=""
	if [ $name ]; then
		comm="${comm} -u ${name}"
	fi
	if [ $email ]; then
		comm="${comm} -e ${email}"
	fi
	if [ $phone ]; then
		comm="${comm} -p ${phone}"
	fi

	delete=`search_user $comm`
	found=`search_user $comm|wc -l` # count
	if [ $found -eq 1 ]; then
		confirm
	else
		usage_delete_user
	fi
}