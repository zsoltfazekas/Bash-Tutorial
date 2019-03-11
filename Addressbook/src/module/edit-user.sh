#!/bin/ash

source module/insert-user.sh
source module/delete-user.sh

usage_edit() 
{ 
	echo "---------------------------------------"
	echo "Edit User"
	echo "	Usage: [-u <oldusername>||<newuser> ] [-e <oldemail>|<newemail>] [-p <oldphone>|<newphone>]"
	echo "---------------------------------------" 
}

edit_user()
{
	# echo $OPTARG
	name=
	email=
	phone=

	while getopts "u:e:p:h" o; do
	  case "$o" in
	    u)
	      name="${OPTARG}"
	      oldname=`echo $name | cut -d'|' -f1`
	      newname=`echo $name | cut -d'|' -f2`
	      ;;
	    e)
	      email="${OPTARG}"
	      oldemail=`echo $email | cut -d'|' -f1`
	      newemail=`echo $email | cut -d'|' -f2`
	      ;;
	    p)
	      phone="${OPTARG}"
	      oldphone=`echo $phone | cut -d'|' -f1`
	      newphone=`echo $phone | cut -d'|' -f2`
	      ;;
	    h)
	      usage_edit
	      ;;
	    *) ;;
	  esac
	done

	comm=""
	if [ $oldname ]; then
		comm="$comm -u $oldname"
	fi
	if [ $oldemail ]; then
		comm="$comm -e $oldname"
	fi
	if [ $oldphone ]; then
		comm="$comm -p $oldname"
	fi
	delete_user $comm

	comm=""
	if [ $newname ]; then
		comm="$comm -u $newname"
	else
		comm="$comm -u $oldname"
	fi

	if [ $newemail ]; then
		comm="$comm -e $newemail"
	else
		comm="$comm -e $oldemail"
	fi

	if [ $newphone ]; then
		comm="$comm -p $newphone"
	else
		comm="$comm -p $oldphone"
	fi
	insert_user $comm

}