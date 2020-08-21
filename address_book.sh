#!/bin/bash
#Address Book

#Constants
Book=address_book.txt
if [ -f "$Book" ]
then
	echo "Address Book is present in current Directory"
else
	touch address_book.txt
fi

#Function to add new entry in Address Book
new() {
	echo "**********Add Person**********"
	while $True
	do
		read -p "Enter your First Name: " usr_first
		usr_first_pattern="^[a-zA-Z]{1}[a-zA-Z]{2,}*$"
		if [[ $usr_first =~ $usr_first_pattern ]]
		then
			#Using stream editor i.e. 'sed' to make all data in lower case
			usr_first=`echo $usr_first | sed 's/./\L&/g'`
			break
		else
			echo "First Name not Valid !!"
			echo "First Name should contain only Alphabets"
			echo ""
			read -p "Press Any Key to Continue or 'q' to Quit." usr_response
			if [[ $usr_response == 'q' ]]
			then
				break
			else
				continue
			fi
		fi
	done
		
	while $True
	do
		read -p "Enter your Last Name: " usr_last
		usr_last_pattern="^[a-zA-Z]{1}[a-zA-Z]{2,}*$"
		if [[ $usr_last =~ $usr_last_pattern ]]
		then
			#Using stream editor i.e. 'sed' to make all data in lower case
			usr_last=`echo $usr_last | sed 's/./\L&/g'`
			break
		else
			echo "Last Name not Valid !!"
			echo "Last Name should contain only Alphabets"
			echo ""
			read -p "Press Any Key to Continue or 'q' to Quit." usr_response
			if [[ $usr_response == 'q' ]]
			then
				break
			else
				continue
			fi
		fi
	done
		
	read -p "Enter your Address: " usr_add
	#Using stream editor i.e. 'sed' to make all data in lower case
	usr_add=`echo $usr_add | sed 's/./\L&/g'`
	
	while $True
	do
	
		read -p "Enter your Pin Code: " usr_pin_code
		usr_pin_code_pattern="^[0-9]{6}$"
		if [[ $usr_pin_code =~ $usr_pin_code_pattern ]]
		then
			#Using stream editor i.e. 'sed' to make all data in lower case
			usr_pin_code=`echo $usr_pin_code | sed 's/./\L&/g'`
			break
		else
			echo "Pin Code is not Valid !!"
			echo "Pin Code should contain only Numbers"
			echo "Pin Code should contain exact 6 Digits"
			echo ""
			read -p "Press Any Key to Continue or 'q' to Quit." usr_response
			if [[ $usr_response == 'q' ]]
			then
				break
			else
				continue
			fi
		fi
	done
	
	while $True
	do
	
		read -p "Enter your Mobile Number: " usr_mob_no
		usr_mob_no_pattern="^[0-9]{10}$"
		if [[ $usr_mob_no =~ $usr_mob_no_pattern ]]
		then
			#Using stream editor i.e. 'sed' to make all data in lower case
			usr_mob_no=`echo $usr_mob_no | sed 's/./\L&/g'`
			break
		else
			echo "Mobile Number is not Valid !!"
			echo "Mobile Number should contain only Numbers"
			echo "Mobile Number should contain exact 10 Digits"
			echo ""
			read -p "Press Any Key to Continue or 'q' to Quit." usr_response
			if [[ $usr_response == 'q' ]]
			then
				break
			else
				continue
			fi
		fi
	done
		
	#Exporting the user data to address_book.txt
	echo "$usr_first;$usr_last;$usr_add;$usr_pin_code;$usr_mob_no" >> $Book
	echo "New Record added successfully"
	#Check for empty lines in address_book.txt & delete them
	sed -i '/^$/d' $Book
}

echo "Enter your Choice"
echo "1) Add Person"
read usr_choice

case $usr_choice in 
	1)
		new
		;;
	*)
		echo "Please enter number 1"
		;;
esac
