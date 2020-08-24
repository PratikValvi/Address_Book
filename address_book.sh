#!/bin/bash
#Address Book

#Constants
Book=address_book.txt
#Check if Address Book is Present if not create it.
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
		while $True
		do
			read -p "Enter First Name: " usr_first
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
				continue
			fi
		done
			
		while $True
		do
			read -p "Enter Last Name: " usr_last
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
				continue
			fi
		done
			
		read -p "Enter Address: " usr_add
		#Using stream editor i.e. 'sed' to make all data in lower case
		usr_add=`echo $usr_add | sed 's/./\L&/g'`
		
		while $True
		do
		
			read -p "Enter Pin Code: " usr_pin_code
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
				continue
			fi
		done
		
		while $True
		do
		
			read -p "Enter Mobile Number: " usr_mob_no
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
				continue
			fi
		done
			
		#Exporting the user data to address_book.txt
		echo "$usr_first;$usr_last;$usr_add;$usr_pin_code;$usr_mob_no" >> $Book
		echo "New Record added successfully"
		#Check for empty lines in address_book.txt & delete them
		sed -i '/^$/d' $Book
		
		read -p "Press Any Key to Add more or 'q' to Quit." usr_response
		echo ""
		if [[ $usr_response == 'q' ]]
		then
			break
		else
			continue
		fi
	done
}

#Function to search any entry in Address Book
search() {
	echo "**********Search Person**********"
	while $True
	do
		echo "Enter Any thing to Search"
		echo "First Name or Last Name or Pin Code or Mobile Number"
		read find
		find=`echo $find | sed 's/./\L&/g'`
		result=`cat $Book | grep -iw $find`
		if [[ -z "$result" ]]
		then
			echo "No record found"
			continue
		else
			cat $Book | grep -iw $find | awk -F";" '{print "First Name: "$1;print "Last Name: "$2;print "Address: "$3;print "Pin Code: "$4;print "Mobile Number: "$5;print "------------------------------"}'
		fi
		echo 
		echo "Enter your choice"
		echo "1) Print Data"
		echo "2) Search Again"
		echo "3) Quit"
		read usr_response
		case $usr_response in
			1)
				touch print_out.txt
				cat $Book | grep -iw $find | awk -F";" '{print "First Name: "$1;print "Last Name: "$2;print "Address: "$3;print "Pin Code: "$4;print "Mobile Number: "$5;print "------------------------------"}' >> print_out.txt
				echo "Data copied to 'print_out.txt' in Current Directory"
				read -p "Press Any Key to Search more or 'q' to Quit." usr_response
				echo ""
				if [[ $usr_response == 'q' ]]
				then
					break
				else
					continue
				fi
				;;
			2)
				continue
				;;
			3)
				break
				;;
			*)
				echo "Please enter number from 1 to 3"
				echo ""
				;;
				
		esac
	done
}

#Function to Update any entry
update () {
	echo "**********Update Record**********"
	while $True
	do
		echo "Enter Any thing to Search"
		echo "First Name or Last Name or Pin Code or Mobile Number"
		read find
		find=`echo $find | sed 's/./\L&/g'`
		result=`cat $Book | grep -iw $find`
		if [[ -z "$result" ]]
		then
			echo "No record found"
			echo ""
			continue
		else
			cat $Book | grep -iw $find | awk -F";" '{print "First Name: "$1;print "Last Name: "$2;print "Address: "$3;print "Pin Code: "$4;print "Mobile Number: "$5;print "------------------------------"}'
		fi
		echo ""
		echo "Enter your choice to update"
		echo "1)Update First Name"
		echo "2)Update Last Name"
		echo "3)Update Address"
		echo "4)Update Pin Code"
		echo "5)Update Mobile Number"
		echo "6)Search Again"
		echo "7)Quit"
		read to_update
		case $to_update in 
			1)
				while $True
				do
					echo "Enter New First Name"
					read new_usr_first
					usr_first_pattern="^[a-zA-Z]{1}[a-zA-Z]{2,}*$"
						
					if [[ $new_usr_first =~ $usr_first_pattern ]]
					then
						#Using stream editor i.e. 'sed' to make all data in lower case
						new_usr_first=`echo $new_usr_first | sed 's/./\L&/g'`
						#Finding First Name to replace
						to_replace=`cat $Book | grep -iw $find | awk -F";" '{print $1}'`
						#Replacing Old First Name with New First Name
						entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
						updated_entry=`echo $entry | sed -e "s/$to_replace/$new_usr_first/"`
						sed -i "/$entry/d" $Book
						echo $updated_entry >> $Book
						sed -i '/^$/d' $Book
						break
					else
						echo "First Name not Valid !!"
						echo "First Name should contain only Alphabets"
						echo ""
						continue
					fi
				done
				;;
			2)
				while $True
				do
					echo "Enter New Last Name"
					read new_usr_last
					usr_last_pattern="^[a-zA-Z]{1}[a-zA-Z]{2,}*$"
						
					if [[ $new_usr_last =~ $usr_last_pattern ]]
					then
						#Using stream editor i.e. 'sed' to make all data in lower case
						new_usr_last=`echo $new_usr_last | sed 's/./\L&/g'`
						#Finding Last Name to replace
						to_replace=`cat $Book | grep -iw $find | awk -F";" '{print $2}'`
						#Replacing Old Last Name with New Last Name
						entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
						updated_entry=`echo $entry | sed -e "s/$to_replace/$new_usr_last/"`
						sed -i "/$entry/d" $Book
						echo $updated_entry >> $Book
						sed -i '/^$/d' $Book
						break
					else
						echo "Last Name not Valid !!"
						echo "Last Name should contain only Alphabets"
						echo ""
						continue
					fi
				done
				;;
			3)
				echo "Enter New Address"
				read new_usr_add
					
				#Using stream editor i.e. 'sed' to make all data in lower case
				new_usr_add=`echo $new_usr_add | sed 's/./\L&/g'`
				#Finding Address to replace
				to_replace=`cat $Book | grep -iw $find | awk -F";" '{print $3}'`
				#Replacing New Address
				entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
				updated_entry=`echo $entry | sed -e "s/$to_replace/$new_usr_add/"`
				sed -i "/$entry/d" $Book
				echo $updated_entry >> $Book
				sed -i '/^$/d' $Book
				;;
			4)
				while $True
				do
					echo "Enter New Pin Code"
					read new_usr_pin_code
					usr_pin_code_pattern="^[0-9]{6}$"
						
					if [[ $new_usr_pin_code =~ $usr_pin_code_pattern ]]
					then
						#Using stream editor i.e. 'sed' to make all data in lower case
						new_usr_pin_code=`echo $new_usr_pin_code | sed 's/./\L&/g'`
						#Finding Pin Code to replace
						to_replace=`cat $Book | grep -iw $find | awk -F";" '{print $4}'`
						#Replacing Old Pin Code with New Pin Code
						entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
						updated_entry=`echo $entry | sed -e "s/$to_replace/$new_usr_pin_code/"`
						sed -i "/$entry/d" $Book
						echo $updated_entry >> $Book
						sed -i '/^$/d' $Book
						break
					else
						echo "Pin Code not Valid !!"
						echo "Pin Code should contain only Numbers"
						echo "Pin Code should contain exact 6 Digits"
						echo ""
						continue
					fi
				done
				;;
			5)
				while $True
				do
					echo "Enter New Mobile Number"
					read new_usr_mob_no
					usr_mob_no_pattern="^[0-9]{10}$"
						
					if [[ $new_usr_mob_no =~ $usr_mob_no_pattern ]]
					then
						#Using stream editor i.e. 'sed' to make all data in lower case
						new_usr_mob_no=`echo $new_usr_mob_no | sed 's/./\L&/g'`
						#Finding Mobile Number to replace
						to_replace=`cat $Book | grep -iw $find | awk -F";" '{print $5}'`
						#Replacing Old Mobile Number with New Mobile Number
						entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
						updated_entry=`echo $entry | sed -e "s/$to_replace/$new_usr_mob_no/"`
						sed -i "/$entry/d" $Book
						echo $updated_entry >> $Book
						sed -i '/^$/d' $Book
						break
					else
						echo "Mobile Number not Valid !!"
						echo "Mobile Number should contain only Numbers"
						echo "Mobile Number should contain exact 10 Digits"
						echo ""
						continue
					fi
				done
				;;
			6)
				continue
				;;
			7)
				break
				;;
			*)
				echo "Please Enter Number from 1 to 7"
				echo ""
				continue
				;;
			esac
		read -p "Press Any Key to Update more or 'q' to Quit." usr_response
		if [[ $usr_response == 'q' ]]
		then
			echo "Record Updated successfully"
			break
		else
			continue
		fi
	done			
}

delete () {
	echo "**********Delete Record**********"
	while $True
	do
		echo "Enter Any thing to Search"
		echo "First Name or Last Name or Pin Code or Mobile Number"
		read find
		find=`echo $find | sed 's/./\L&/g'`
		result=`cat $Book | grep -iw $find`
		if [[ -z "$result" ]]
		then
			echo "No record found"
			echo ""
			continue
		else
			cat $Book | grep -iw $find | awk -F";" '{print "First Name: "$1;print "Last Name: "$2;print "Address: "$3;print "Pin Code: "$4;print "Mobile Number: "$5;print "------------------------------"}'

			echo "Enter your Choice"
			echo "1) Delete this record"
			echo "2) Search Again"
			echo "3) Quit"
			read usr_response
			case $usr_response in 
				1)
					entry=`cat $Book | grep -iw $find | awk -F";" '{print $0}'`
					sed -i "/$entry/d" $Book
					echo "Record Deleted"
					;;
				2)
					continue
					;;
				3)
					break
					;;
				*)
					echo "Please Enter Number from 1 to 3"
					;;
			esac
		fi
		read -p "Press Any Key to Delete more or 'q' to Quit." usr_response
		echo ""
		if [[ $usr_response == 'q' ]]
		then
			echo "Record Deleted successfully"
			break
		else
			continue
		fi
	done	
}
#Main Program 
while $True
do
	echo ""
	echo "Welcome!! to Address Book"
	echo "Enter your Choice"
	echo "1) Add Person"
	echo "2) Search Person"
	echo "3) Update Record"
	echo "4) Delete Record"
	echo "5) Quit"
	read usr_choice
	case $usr_choice in 
		1)
			new
			;;
		2)
			search
			;;
		3)
			update
			;;
		4)
			delete
			;;
		5)
			break
			;;
		*)
			echo "Please Enter Number from 1 to 5"
			;;
	esac	
done
