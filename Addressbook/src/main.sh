#!/bin/ash

. ./addressbook.sh

echo "Welcome!"
echo
echo "Commands:"
echo "	1) Insert User"
echo "	2) Delete User"
echo "	3) Search for User"
echo "  exit) Exit"

read_and_insert_user()
{
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone

	insert -u $name -e $email -p $phone
}

read_and_delete_user()
{
	echo "Delete user! If you want to skip the field for search type: skip"
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone
	
	comm=""
	if [ $name != skip ]; then
		comm="${comm} -u ${name}"
	fi
	if [ $email != skip ]; then
		comm="${comm} -e ${email}"
	fi
	if [ $phone != skip ]; then
		comm="${comm} -p ${phone}"
	fi

	delete $comm
}

read_and_search_user()
{
	echo "Search for user! If you want to skip the field for search type: skip"
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone
	
	comm=""
	if [ $name != skip ]; then
		comm="${comm} -u ${name}"
	fi
	if [ $email != skip ]; then
		comm="${comm} -e ${email}"
	fi
	if [ $phone != skip ]; then
		comm="${comm} -p ${phone}"
	fi

	search $comm
}

while true; do
	read -p "What you want to do? " x
	case "$x" in
		exit)
			echo "Good Bye!"
			break 
			;;
		1) 
		    echo "Insert"
		    read_and_insert_user
			;;
		2) 
			echo "Delete"
			read_and_delete_user	
			;;
		3)
			echo "Search"
			read_and_search_user
			;;
	esac
done