
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

select choice in DELETE_ALL DELETE_ROW
do
case $choice in 
DELETE_ALL )
sed -i '/^[[:digit:]]/d' $table_name
echo "the table deleted succesfully"
;;
DELETE_ROW )
while true
do 
read -p "input the pk of the row" pk
row =`awk -F':' '{ if($1=='$pk') print $0}' $table_name `
if grep -Fxq "$row" "$table_name"  &> ~/../../dev/null;
then
sed -i '/'$row'/d' $table_name
echo "row deleted succesfully"
break
else
echo "the pk is not exist"
continue
fi
done
break
;;
* )
echo "type available choise"
continue 
;;
esac
done