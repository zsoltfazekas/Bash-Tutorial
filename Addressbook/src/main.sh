#!/bin/ash

source addressbook.sh

echo "Welcome!"
echo

usage_menu(){
	echo "Commands:"
	echo "	1) Insert User"
	echo "	2) Delete User"
	echo "	3) Search User"
	echo "	4) Edit User"
	echo "	exit) Exit"
}


read_and_insert_user()
{
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone

	insert -u $name -e $email -p $phone
}

read_and_delete_user()
{
	echo "Delete user! If you want to skip the field for search type: enter"
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone
	
	comm=""
	if [ "$name" != "" ]; then
		comm="${comm} -u ${name}"
	fi
	if [ "$email" != "" ]; then
		comm="${comm} -e ${email}"
	fi
	if [ "$phone" != "" ]; then
		comm="${comm} -p ${phone}"
	fi

	delete $comm
}

read_and_search_user()
{
	echo "Search for user! If you want to skip the field for search type: enter"
	read -p "User:" name
	read -p "Email:" email
	read -p "Phone:" phone
	
	comm=""
	if [ "$name" != "" ]; then
		comm="${comm} -u ${name}"
	fi
	if [ "$email" != "" ]; then
		comm="${comm} -e ${email}"
	fi
	if [ "$phone" != "" ]; then
		comm="${comm} -p ${phone}"
	fi
	echo "------------Result------------"
	search $comm
	echo "------------------------------"
}

read_and_edit_user()
{
	echo "Search for user! If you want to skip the field for search type: enter"
	read -p "Old User Name:" oldname
	read -p "Old Email:" oldemail
	read -p "Old Phone:" oldphone

	read -p "New User Name:" newname
	read -p "New Email:" newemail
	read -p "New Phone:" newphone

	comm=""
	if [ "$oldname" != "" ]; then
		comm="${comm} -u ${oldname}|${newname}"
	fi
	if [ "$oldemail" != "" ]; then
		comm="${comm} -u ${oldemail}|${newemail}"
	fi
	if [ "$oldphone" != "" ]; then
		comm="${comm} -u ${oldphone}|${newphone}"
	fi

	edit $comm
}

while true; do
	usage_menu
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
		4)
			echo "Edit"
			read_and_edit_user
	esac
done