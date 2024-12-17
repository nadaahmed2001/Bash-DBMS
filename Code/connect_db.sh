#!/usr/bin/bash

PS3=" Type Your DB Number To Connect With : "

echo
echo "Select Your Database number from menu"
echo

cd /home/rahma/Documents/test/DATA

array=(`ls -F | grep /`)
select choice in ${array[*]}
do
if [ $REPLY -gt ${#array[*]} ]
then 
echo "
$REPLY not on the menu
"
continue 
else
cd /home/rahma/Documents/test/DATA/${array[${REPLY}-1]}

echo "
...You Are connected to ${array[${REPLY}-1]}
"
echo
break
fi
done
echo
PS3="Type Your Choice Number : "
select choice in Create_Table List_Tables Drop_table insert_table select_table delete_table
do 
case $choice in 
Create_Table )
        echo "creating table..."
        source  /home/rahma/Documents/test/SOFTWARE/create_table.sh
        ;;
List_Tables ) 
        echo "List_Table..."
         source /home/rahma/Documents/test/SOFTWARE/list_table.sh
          ;;

Drop_table )
  echo "Drop_table..."
     source /home/rahma/Documents/test/SOFTWARE/drop_table.sh
        ;;
                 
insert_table )
        echo "insert_table..."
     source /home/rahma/Documents/test/SOFTWARE/insert_table.sh
        ;;
select_table )
         echo "select_table..."
     source /home/rahma/Documents/test/SOFTWARE/select_table.sh
        ;;

delete_table )
    echo "delete_table..."
     source /home/rahma/Documents/test/SOFTWARE/delete_table.sh
        ;;       
esac
done
cd - &> ~/../../dev/null