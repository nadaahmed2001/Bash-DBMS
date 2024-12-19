#!/usr/bin/bash


db_path="/home/rahma/Documents/test/DATA"

# List databases

array=($(ls -F "$db_path" | grep '/'))

if [ ${#array[@]} -eq 0 ]; then
    echo "There are no databases available."
    exit
fi

# Show database selection menu
echo
echo "Select Your Database number from the menu"
echo

select choice in "${array[@]}"; do
    if [ $REPLY -gt ${#array[@]} ] || [ $REPLY -lt 1 ]; then
        echo "$REPLY is not a valid option."
        continue
    else
        echo "You selected database: ${array[REPLY-1]}"
        selected_db="${array[REPLY-1]}"
        break
    fi
done

# Change directory to selected database
cd "$db_path/$selected_db" || exit

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
echo "Columns in the table '$table_name':"
for i in "${!columns[@]}"; do
    echo "$((i+1)). ${columns[i]}"
done

# Ask user to select columns for insertion
echo "Enter the column numbers (comma-separated) where you want to insert data, e.g., 1,3,5:"
read -p "Columns: " selected_columns

# Convert the comma-separated string to an array
IFS=',' read -r -a selected_columns_array <<< "$selected_columns"

# Prompt the user for data to insert into selected columns
for col in "${selected_columns_array[@]}"; do
    if [[ ! "$col" =~ ^[0-9]+$ ]] || [ "$col" -lt 1 ] || [ "$col" -gt ${#columns[@]} ]; then
        echo "Invalid column number: $col. Please select a valid column."
        exit 1
    fi
done

# Ask for values to insert into the selected columns
insert_data=""
for col in "${selected_columns_array[@]}"; do
    read -p "Enter value for ${columns[((col-1))]}: " value
    insert_data="$insert_data$value,"
done

# Remove trailing comma
insert_data=${insert_data%,}

# Insert the data into the table (append to the file)
echo "$insert_data" >> "$table_name"
echo "Data inserted successfully into $table_name!"

# Return to the previous directory
cd - > /dev/null
