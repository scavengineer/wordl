#!/bin/bash
NW=`cat wordle-La.txt| wc -l`
WORD=(`head -$(( $RANDOM % NW)) wordle-La.txt  | tail -1| grep -o .`)
echo ${WORD}
printf "\033[38;5;255;48;5;0m"  
for i in 1 2 3 4 5 6; do
until [ 0 -eq 1 ] ; do
read -r -n5 N 
W=`echo $N | tr "A-Z" "a-z"`
grep -q "^${W}$" allwords.txt
if [ $? -ne 0 ] ; then
echo "\"$W\" is not a word in my dictionary, try again"
else break
fi
done
T=(`echo $W| grep -o .`)
AW=""
c=0
for L in 0 1 2 3 4  ; do
  if [ ${WORD[$L]} = ${T[$L]} ] ; then
     AW="${AW}\033[48;5;35m\033[38;5;255m${T[$L]}" # white letter on green background
     c=$(( $c+1 ))
  else
     if [[ " ${WORD[*]} " =~ " ${T[$L]} " ]]; then
       AW="${AW}\033[48;5;226m\033[38;5;0m${T[$L]}" # black letter on yellow
  else
     AW="${AW}\033[48;5;251m\033[38;5;0m${T[$L]}" # black letter on grey background
  fi
  fi
done
printf "\033[5D${AW}\033[38;5;255;48;5;0m"  # resetcolors
echo ""
if [ $c -eq 5 ] ; then
   printf "\033[48;5;35m\033[38;5;0m"
   echo -n "you win!"
   printf "\033[38;5;255;48;5;0m"  # resetcolors
   echo ""
   exit
fi
done
   printf "\033[48;5;124m\033[38;5;255m" # white on red
   echo -n "you lose! ${WORD[*]}"
   printf "\033[38;5;255;48;5;0m"  # resetcolors
   echo ""

