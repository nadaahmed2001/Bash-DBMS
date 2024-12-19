#!/usr/bin/bash

cd ~/ITI/Bash/Project/DB-result/$DB_NAME
echo "select your table number from the menu:"
array=(`ls`)
select choice in ${array[*]}
do 
if [ $REPLY -gt ${#array[*]} ]
then
echo " $REPLT is no on the menu"
continue
else 
echo " you selected ${array[${REPLY}-1]} table "
table_name=${array[${REPLY}-1]}
break
fi
done

select choice in DELETE_ALL DELETE_WITH_CONDITIONS
do
case $choice in 
DELETE_ALL )
#If table is already empty (contains no data)
if [ ! -s $table_name ]; then # -s checks if file contains data
    echo "The table is already empty."
    break
fi
#Delete all row
sed -i 'd' $table_name
echo "deleted the table data succesfully"
;;

DELETE_WITH_CONDITIONS )
    echo "$table_name"
    array=(`awk -F: '{print $1}' "${table_name}metadata"`)
    # Display column names from the metadata file
    echo ${array[@]}
    echo "Select the column number you want to delete from:"
    
    # Allow the user to select a column
    select choice in ${array[*]}
    do
        if [ $REPLY -gt ${#array[*]} ]; then
            echo " $REPLY is not on the menu"
            continue
        else
            echo "You selected ${array[${REPLY}-1]} column"
            column_name=${array[${REPLY}-1]} # Store the chosen column name
            column_index=$REPLY # Get the column index (1-based)
            break
        fi
    done

    # Prompt for the value to delete
    while true
    do
        echo "Enter the value you want to delete:"
        read value

        # Check if the value exists in the specific column
        echo " We wre searching in cloumn number $column_index for a value $value"
        if [ -z "$(awk -F: -v col="$column_index" -v val="$value" '$col == val { print $0 }' "$table_name")" ]; then
            echo "The value '$value' does not exist in column '$column_name'."
            continue
        else
        break
        fi
    done

    # Delete rows where the value exists in the specified column
    awk -F: -v col="$column_index" -v val="$value" 'BEGIN { OFS = FS } { if ($col != val) print $0 }' "$table_name" > temp && mv temp "$table_name"
    echo "Deleted rows where column '$column_name' contains the value '$value'."
    ;;

* )
    echo "Invalid choice, please select a valid option."
    continue
    ;;
esac
break

done

cd - > /dev/null
~/ITI/Bash/Project/Code/mainScript