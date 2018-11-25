#!/bin/bash


#Agamemnon Theodorakopoulos 6054


#gia ta sxolia opou vazw to # eksigw gia to sigkekrimeno pipe kai otan xrisimopoiw | alazw pipe kai eksigw gia to antistixo



if [ $# = 0 ] ;then #elenxos gia ta arguments pou dinei o xristis 

	echo "6054"

fi 



if [ $# = 2 ] ;then
 
	grep ^[^#]  "$2"   # grep ^[^#]= ektupwnei xwris ta sxolia

fi


if [ $# = 4 ] ;then

	if [ "$3" = "-id" ] ;then #elenxos gia seira parametrwn 
		
		#psaxnei (words) to arg $4 sto arxeio(persons.dat=$2) | me delimetre "|" ektypwnei ta fields 3,2,5|alazei ta "|" me " "|kanei alagi metavlitwn kai tupwnei
		grep -w  ^$4 "$2" | cut -d "|" -f 3,2,5 | tr "|" " " | awk ' { t = $1; $1 = $2; $2 = t; print; } '
	else 
		grep -w ^$2 "$4" | cut -d "|" -f 3,2,5 | tr "|" " " | awk ' { t = $1; $1 = $2; $2 = t; print; } '
	fi
	

	if [ "$1" = "-f" ] && [ "$3" = "--born-since" ]; then #elexos seiras metavlitwn
		date=$4
		f=$2		# me -v dilwnw tin metavliti stin awk kai kanw print analoga me ton elexno|taksinomisi me vasi to 5o field
		grep ^[^#] "$f" | awk -v datea=$4  -F "|" ' ( $5 >= datea  )  {print }' | sort -t "|" -k5

	elif [ "$1" = "-f" ] && [ "$3" = "--born-until" ]; then
		date=$4
		f=$2
		grep ^[^#] "$f" | awk -v datea=$4  -F "|" ' ( $5 <= datea  )  {print }' | sort -t "|" -k5

	elif [ "$3" = "-f" ] && [ "$1" = "--born-since" ]; then
		date=$2
		f=$4
		grep ^[^#] "$f" | awk -v datea=$2  -F "|" ' ( $5 >= datea  )  {print }' | sort -t "|" -k5

	elif [ "$3" = "-f" ] && [ "$1" = "--born-until" ]; then	
		date=$2
		f=$4
		grep ^[^#] "$f" | awk -v datea=$2  -F "|" ' ( $5 <= datea  )  {print }' | sort -t "|" -k5
	fi
		
fi

if [ $# = 3 ] ;then 


  if [ "$2" = "-f" ] ;then
    x="${1}"
       case ${x} in 
								  # taksinomei kai enfanizei mono ta diaforetika onomata
	--firstnames ) grep ^[^#] "$3" |  awk -F "|" '{print $3}' | sort -u
	;;
	--lastnames ) grep ^[^#] "$3" |  awk -F "|" '{print $2}' | sort -u
	;;								#alazei ta kena me . gia na mporei na ginei swsta h alagi metavlitwn gia thn swsth seira ||ksana alazw tis . me kena
	--browsers )  grep ^[^#] "$3" |  awk -F "|" '{print $8}' | sort | tr " " "." | uniq -c | awk ' { t = $1; $1 = $2; $2 = t; print; } ' | tr "." " "
	;;
       esac


  elif [ "$2" != "-f" ] ;then
   x="${3}"
       case ${x} in 
	
	--firstnames ) grep ^[^#] "$2" |  awk -F "|" '{print $3}' | sort -u
	;;
	--lastnames ) grep ^[^#] "$2" |  awk -F "|" '{print $2}' | sort -u
	;;
	--browsers ) grep ^[^#] "$2" |  awk -F "|" '{print $8}' | sort | tr " " "." | uniq -c | awk ' { t = $1; $1 = $2; $2 = t; print; } ' | tr "." " "
	;;
       esac
  fi

fi


if [ $# = 6 ] ;then 



	if [ "$1" = "-f" ] && [ "$3" = "--born-since" ] ;then
		fdate=$4
		edate=$6
		f=$2
		grep ^[^#] "$f" | awk -v datea=$4 -v dateb=$6 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5

	elif [ "$1" = "-f" ] && [ "$3" = "--born-until" ] ;then
		fdate=$6
		edate=$4
		f=$2
		grep ^[^#] "$f" | awk -v datea=$6 -v dateb=$4 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5

	elif [ "$5" = "-f" ] && [ "$3" = "--born-until" ] ;then
		fdate=$2
		edate=$4
		f=$6
		grep ^[^#] "$f" | awk -v datea=$2 -v dateb=$4 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5
	
	elif [ "$5" = "-f" ] &&  [ "$3" = "--born-since" ] ;then
		fdate=$4
		edate=$2
		f=$6
		grep ^[^#] "$f" | awk -v datea=$4 -v dateb=$2 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5

	elif [ "$3" = "-f" ] &&  [ "$5" = "--born-since" ] ;then
		fdate=$6
		edate=$2
		f=$4
		grep ^[^#] "$f" | awk -v datea=$6 -v dateb=$2 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5
	
	elif [ "$3" = "-f" ] &&  [ "$5" = "--born-until" ] ;then
		fdate=$2
		edate=$6
		f=$4
		grep ^[^#] "$f" | awk -v datea=$2 -v dateb=$6 -F "|" ' ( $5 >= datea  ) && ( $5 <= dateb )  {print }' | sort -t "|" -k5 		
	fi




	if [ "$1" = "-f" ] &&  [ "$3" = "--edit" ] && [ "$5" -ge "2" ] && [ "$5" -le "8" ]  ;then
	   ar=`grep -w ^$4 "$2"`
	    if [ "$ar" != "" ] ;then
              
		f=$2
		id=$4
		col=$5
		val=$6
		c=`grep -w ^$4 "$2" | awk -F "|" -v c=$col '{print $c;}'`
		sed -i "/^$4/ s/$c/$6/" $2
	     fi
	elif [ "$1" = "--edit" ] &&  [ "$5" = "-f" ] && [ "$3" -ge "2" ] && [ "$3" -le "8" ]  ;then 
	    ar=`grep -w ^$2 "$6"`

	    if [ "$ar" != "" ] ;then
              
		f=$6
		id=$2
		col=$3
		val=$4
		c=`grep -w ^$2 "$6" | awk -F "|" -v c=$col '{print $c;}'`
		sed -i  "/^$2/ s/$c/$4/g" $6 | cat $6
		
	    fi
               
	fi

fi







