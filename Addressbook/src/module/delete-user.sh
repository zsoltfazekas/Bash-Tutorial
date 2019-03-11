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
	echo "You can't delete multiple user at same time or User not found. Try to add different or more complex search criteria"
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

	if [ $name ] && [ $email ] && [ $phone ]; then
		delete=`search_user -u $name -e $email -p $phone`
		found=`search_user -u $name -e $email -p $phone | wc -l` # count
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $email ] && [ $phone ]; then
		found=`search_user -e $email -p $phone | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $name ] && [ $phone ]; then
		found=`search_user -u $name -p $phone | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $name ] && [ $email ]; then
		found=`search_user -u $name -e $email | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $name ]; then
		found=`search_user -u $name | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $email ]; then
		found=`search_user -e $email | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi

	elif [ $phone ]; then
		found=`search_user -p $phone | wc -l`
		if [ $found -eq 1 ]; then
			confirm
		else
			usage_delete_user
		fi
	fi
}