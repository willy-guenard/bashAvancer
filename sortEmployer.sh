#!/bin/bash
cd ./stock

employers=`ls | sed -e 's/[0-9]*//g'`


for employers in employer
 do 
	echo $employer;
done
