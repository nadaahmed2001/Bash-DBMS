#!/usr/bin/bash
PS3=" Type Your Table Number To Drop : "
cd /home/rahma/Documents/test/DATA

array=(`ls -F | grep /`)

if [ ${#array[@]} -eq 0 ]; then
  echo "there is no database to delete."
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
echo "
...Your ${array[${REPLY}-1]} DB Deleted successfully...
" 
break 2
fi
done





cd - &> ~/../../dev/null