#!/usr/bin/ksh
# Generated by Structorizer 3.32-01 

# Copyright (C) 2020-03-21 Kay Gürtzig 
# License: GPLv3-link 
# GNU General Public License (V 3) 
# https://www.gnu.org/licenses/gpl.html 
# http://www.gnu.de/documents/gpl.de.html 

# Tries to read as many integer values as possible upto maxNumbers 
# from file fileName into the given array numbers. 
# Returns the number of the actually read numbers. May cause an exception. 
function readNumbers {
 typeset fileName=$1
 typeset -n numbers=$2
 typeset -i maxNumbers=$3
# TODO: Check and revise the syntax of all expressions! 

 typeset -i number
 typeset -i nNumbers
 typeset -i fileNo
 nNumbers=0
 fileNo=$( fileOpen "${fileName}" )

 if (( ${fileNo} <= 0 ))
 then
  throw "File could not be opened!"
 fi

 # try (FIXME!) 

  while (( ! fileEOF(${fileNo}) && ${nNumbers} < ${maxNumbers} ))
  do
   number=$( fileReadInt "${fileNo}" )
   numbers[${nNumbers}]=${number}
   nNumbers=$(( ${nNumbers} + 1 ))
  done

 # catch error (FIXME!) 
  throw
 # finally (FIXME!) 
  fileClose "${fileNo}"
 # end try (FIXME!) 
 result6ca1ae16=${nNumbers}
}
# Computes the sum and average of the numbers read from a user-specified 
# text file (which might have been created via generateRandomNumberFile(4)). 
#  
# This program is part of an arrangement used to test group code export (issue 
# #828) with FileAPI dependency. 
# The input check loop has been disabled (replaced by a simple unchecked input 
# instruction) in order to test the effect of indirect FileAPI dependency (only the 
# called subroutine directly requires FileAPI now). 
# TODO: Check and revise the syntax of all expressions! 

fileNo=1000
# Disable this if you enable the loop below! 
echo -n "Name/path of the number file" ; read file_name
#  
# If you enable this loop, then the preceding input instruction is to be disabled 
# and the fileClose instruction in the alternative below is to be enabled. 
# NOTE: Represents a REPEAT UNTIL loop, see conditional break at the end. 
# while : 
# do 
#  echo -n "Name/path of the number file" ; read file_name 
#  fileNo=$( fileOpen "${file_name}" ) 
#  : 
#  (( ! (${fileNo} > 0 || ${file_name} == "") )) || break 
# done 
#  

if (( ${fileNo} > 0 ))
then
 # This should be enabled if the input check loop above gets enabled. 
#  fileClose "${fileNo}" 
 set -A values
 nValues=0
 # try (FIXME!) 
  readNumbers "${file_name}" values 1000
  nValues=${result6ca1ae16}
 # catch failure (FIXME!) 
  echo failure
  exit  (( -7 ))
 # finally (FIXME!) 
  :
 # end try (FIXME!) 
 sum=0.0

 for (( k=0; k<=(( ${nValues}-1 )); k++ ))
 do
  sum=$(( ${sum} + ${values[${k}]} ))
 done

 echo "sum = " ${sum}
 echo (( "average = ", ${sum} / ${nValues} ))
fi
