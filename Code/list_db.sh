#!/usr/bin/bash

cd /home/rahma/Documents/test/DATA


array=(`ls -F | grep /`)

if [ ${#array[@]} -eq 0 ]; then
  echo "there is no database to show."
  exit 1 
fi 

echo "Your List Of Database"
ls -F | grep / 

cd - &> ~/../../dev/null

