#!/usr/bin/bash


echo
echo "Select Your Database number from menu"
echo

cd ~/ITI/Bash/Project/DB-result

array=(`ls -F | grep /`)
# If database directory is empty
if [ ${#array[@]} -eq 0 ]; then
  echo "there is no database to connect to..."
  exit 1 
fi 

# Print the databases menu
select choice in ${array[*]}
do
if [ $REPLY -gt ${#array[*]} ] # If choosed number gretter than the number of databases
then 
echo "$REPLY not on the menu"
continue

else
cd ../DB-result/${array[${REPLY}-1]}
DB_NAME=${array[${REPLY}-1]} # Save the selected database name to use it in other scripts
echo "...You Are connected to ${array[${REPLY}-1]}"
break
fi
done

echo "Type Your Choice Number : "
select choice in Create_Table List_Tables Drop_table insert_table select_table delete_from_tb update_table insert_into_tb
do 
case $choice in 
Create_Table )
        echo "Creating table..."
        export DB_NAME
        /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/create_tb
        ;;
List_Tables ) 
        echo "List_Table..."
        export DB_NAME
        /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/list_tb 
          ;;

Drop_table )
  echo "Drop_table..."
  export DB_NAME
       /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/drop_tb 
        ;;
                 
insert_table )
        echo "insert_table..."
        export DB_NAME
      /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/insert_tb 
        ;;
select_table )
         echo "select_table..."
         export DB_NAME
     /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/select_tb 
        ;;

delete_from_tb )
    echo "delete_from_tb..."
    export DB_NAME
     /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/delete_from_tb.sh
        ;;
update_table )
        echo "update_table..."
        export DB_NAME
         /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/update_tb 
        ;;
insert_into_tb )
        echo "insert_into_tb..."
        export DB_NAME
         /home/nadaabutaleb/ITI/Bash/Project/Code/Tables/insert_into_tb.sh
        ;;
*)
        echo "Invalid Choice"
        ;;
esac
done
cd - &> ~/../../dev/null