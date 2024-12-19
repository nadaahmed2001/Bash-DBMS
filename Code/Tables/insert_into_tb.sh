#!/usr/bin/bash

cd "$DB_NAME"

# List tables in the selected database
array2=($(ls))
if [ ${#array2[@]} -eq 0 ]; then

    echo "No tables available in this database."
    exit
fi

# Show table selection menu
echo "Select your table number from the menu:"

select choice in "${array2[@]}"; do
    if [ $REPLY -gt ${#array2[@]} ] || [ $REPLY -lt 1 ]; then
        echo "$REPLY is not a valid option."
        continue
    else
        echo "You selected table: ${array2[REPLY-1]}"
        table_name="${array2[REPLY-1]}"
        break
    fi
done
################################################
# user choise db name and table name succesfully

# Show column names to the user
    array=(`awk -F: '{print $1}' "${table_name}metadata"`) #insert each column name ($1) in array
    # Display column names from the metadata file
    echo ${array[@]}


#Get the column that is primary key
    pk=$(awk -F: '$3 == "pk" {print $1}' "${table_name}metadata")
    #keep the column number of the primary key
    pk_index=$(awk -F: -v pk="$pk" '{if ($1 == pk) print NR}' "${table_name}metadata")
    echo "pk ($pk) index is $pk_index"

echo "How many rows you want to insert?"
read rows

# Loop over the number of rows
for ((i = 0; i < $rows; i++)); do
    # Loop over the columns
    for ((j = 0; j < ${#array[@]}; j++)); do
        column_name="${array[j]}"
        # Get the data type of the column from the second field in the metadata file
        column_type=$(awk -F: -v col="$column_name" '$1 == col {print $2}' "${table_name}metadata")

        while true; do
            echo "Enter the value for ${column_name} for row $((i + 1)):"
            read value

            # If this column is the primary key, make sure the value is unique
            if [ "$column_name" == "$pk" ]; then
                existing_values=($(cut -d: -f$pk_index "$table_name"))
                if [[ " ${existing_values[@]} " =~ " $value " ]]; then
                    echo "Error: The value '$value' already exists for the primary key. Please enter a unique value."
                    continue
                fi
            fi

            # Validate data type
            case $column_type in
            int)
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                    echo "Invalid input. The value for '$column_name' must be an integer. Try again."
                    continue
                fi
                ;;
            str)
                if ! [[ "$value" =~ ^[a-zA-Z]+$ ]]; then
                    echo "Invalid input. The value for '$column_name' must be a string. Try again."
                    continue
                fi
                ;;
            *)
                echo "Unknown data type for column '$column_name', enter 'int' or 'str'."
                continue
                ;;
            esac

            # Append the value to the table file
            if [ $j -eq $((${#array[@]} - 1)) ]; then # Last column
                echo -n "$value" >>"$table_name"
            else
                echo -n "$value:" >>"$table_name"
            fi
            break
        done
    done
    echo >>"$table_name" # Add a newline
done

echo "Rows inserted successfully."

cd - > /dev/null
~/ITI/Bash/Project/Code/mainScript

#1- pk unique
#2- data inserted is valid (int/str)