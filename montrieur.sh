#!/bin/bash

cd ./WDGAS_files;

IFS=' ';

function createDepartementDirectory {
  mkdir $1;
}

function moveEmploye {
  mv $1 ./$4/$3_$2.data;
}


for file in *
do
  if [[ $file == *.data ]]; then
    employerFileNormalize=`echo $file | sed -e 's/[0-9]*//g'`;
    employerFileNormalize=`echo $employerFileNormalize | tr - " " | tr _ " "`;
    employerFileNormalize=${employerFileNormalize%.*};
    read -ra employerArray <<< "$employerFileNormalize";
    
    bufferCheckDepartement=`echo ${employerArray[2]} | sed -r 's/[a-z]*//g'`;
    checkOrderDepartement=${#bufferCheckDepartement};
    
    if [ $checkOrderDepartement -eq 2 ]; then
      firstName=${employerArray[0]};
      lastName=${employerArray[1]};
      department=${employerArray[2]};
    else
      firstName=${employerArray[2]};
      lastName=${employerArray[1]};
      department=${employerArray[0]};

    fi

    if [ ! -e  $department ]; then
      echo "directory $department create";
      createDepartementDirectory $department;
    fi
    moveEmploye $file $firstName $lastName $department;
  fi
done
