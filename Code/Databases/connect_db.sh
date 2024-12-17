#!/usr/bin/bash


echo
echo "Select Your Database number from menu"
echo

cd ../DB-result

array=(`ls -F | grep /`)

if [ ${#array[@]} -eq 0 ]; then
  echo "there is no database to connect to..."
  exit 1 
fi 

select choice in ${array[*]}
do
if [ $REPLY -gt ${#array[*]} ]
then 
echo "
$REPLY not on the menu
"
continue 
else
cd ../DB-result/${array[${REPLY}-1]}

echo "
...You Are connected to ${array[${REPLY}-1]}
"
break
fi
done

echo "Type Your Choice Number : "
select choice in Create_Table List_Tables Drop_table insert_table select_table delete_from_tb update_table insert_into_tb
do 
case $choice in 
Create_Table )
        echo "Creating table..."
        /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/create_tb
        ;;
List_Tables ) 
        echo "List_Table..."
         source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/list_tb
          ;;

Drop_table )
  echo "Drop_table..."
     source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/drop_tb
        ;;
                 
insert_table )
        echo "insert_table..."
     source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/insert_tb
        ;;
select_table )
         echo "select_table..."
     source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/select_tb
        ;;

delete_from_tb )
    echo "delete_from_tb..."
     source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/delete_from_tb
        ;
update_table )
        echo "update_table..."
         source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/update_tb
        ;;
insert_into_tb )
        echo "insert_into_tb..."
         source /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/insert_into_tb
        ;;
esac
done
cd - &> ~/../../dev/null