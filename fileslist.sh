#!/bin/sh
for entry in /research2/Oxford_1year/*;
do
	echo ${entry##*/} >> "oxford_file.txt"
	
done
