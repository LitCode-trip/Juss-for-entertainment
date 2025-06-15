#!/bin/bash
OS=`cat /etc/os-release | egrep -iw id | awk -F = 'NF > 1 {print $2}'`
if  [[ $OS =~ ubuntu ]]
then
echo "Os is ubutnu"
elif [[ $OS =~ debian ]]
then
echo "OS is debain"
elif [[ $OS =~ centos ]]
then
echo "OS is centos"
else
echo "OS is type linux need manual checks"
fi

