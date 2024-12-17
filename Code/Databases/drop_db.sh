#!/usr/bin/bash

cd ../DB-result

array=(`ls -F | grep /`)

if [ ${#array[@]} -eq 0 ]; then
  echo "There is no database to delete."
  exit 1
fi 

echo
echo "Select Your Database number to drop from menu"
echo

# echo ${array[*]}
select choice in ${array[*]}
do
if [ $REPLY -gt ${#array[*]} ] 
then 
echo "
$REPLY not on the menu
"
continue 
else
rm -r ${array[${REPLY}-1]}
cd -
echo "
...Your ${array[${REPLY}-1]} DB Deleted successfully...
" 
break
fi
done


cd - &> ~/../../dev/null