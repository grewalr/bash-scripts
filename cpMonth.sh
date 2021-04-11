#!/bin/bash

function usage()
{
	echo "cpMonth MONTH {jan} YEAR {2015} MEM_SIZE {64/32} IMAGES_FOLDER {KIERAN}"
	exit 1
}


function makeDir()
{
    REMOTE_IMAGES_FOLDER="/Volumes/Images/${IMAGES_FOLDER}/${2}/${1}/$MEM_SIZE"
    REMOTE_RAW_FOLDER="/Volumes/RAW/${IMAGES_FOLDER}/${2}/${1}/$MEM_SIZE"

    if [[ ! -d "${REMOTE_IMAGES_FOLDER}" ]]
    then
        mkdir -p ${REMOTE_IMAGES_FOLDER}
    fi

    if [[ ! -d "${REMOTE_RAW_FOLDER}" ]]
    then
        mkdir -p ${REMOTE_RAW_FOLDER}
    fi


}

if [[ $1 == "" || $2 == "" || $3 == "" ]]
then
	usage
fi

MONTH=`echo $1 | tr '[:upper:]' '[:lower:]'`
YEAR=$2
MEM_SIZE=$3
IMAGES_FOLDER=$4
LOCAL_IMAGES_FOLDER="/Users/grewalr/Pictures/copyToNAS/$MEM_SIZE"
REMOTE_IMAGES_FOLDER=X
REMOTE_RAW_FOLDER=X

monthToCopy=X
monthEnd=X

if [[ ! -d "$LOCAL_IMAGES_FOLDER" ]]
then
	printf "Folder does not exist ${LOCAL_IMAGES_FOLDER}"
	printf "\nExiting..."
	exit 1
fi

case "$MONTH" in
    "jan")
    	monthToCopy="$YEAR-01-01"
    	monthEnd="$YEAR-01-01"
    	makeDir "01-Jan" $YEAR
    	;;
    "feb")
    	monthToCopy="$YEAR-02-01"
    	monthEnd="$YEAR-02-28"
    	makeDir "02-Feb" $YEAR
		;;
    "mar")
    	monthToCopy="$YEAR-03-01"
    	monthEnd="$YEAR-03-31"
    	makeDir "03-Mar" $YEAR
    	;;
    "apr")
    	monthToCopy="$YEAR-04-01"
    	monthEnd="$YEAR-04-30"
    	makeDir "04-Apr" $YEAR
		;;
    "may")
    	monthToCopy="$YEAR-05-01"
    	monthEnd="$YEAR-05-31"
		makeDir "05-May" $YEAR
		;;
    "jun")
    	monthToCopy="$YEAR-06-01"
    	monthEnd="$YEAR-06-30"
		makeDir "06-Jun" $YEAR
		;;
    "jul")
    	monthToCopy="$YEAR-07-01"
    	monthEnd="$YEAR-07-31"
		makeDir "07-Jul" $YEAR
		;;
    "aug")
    	monthToCopy="$YEAR-08-01"
    	monthEnd="$YEAR-08-31"
		makeDir "08-Aug" $YEAR
		;;
    "sep")
    	monthToCopy="$YEAR-09-01"
    	monthEnd="$YEAR-09-30"
		makeDir "09-Sep" $YEAR
		;;
    "oct")
    	monthToCopy="$YEAR-10-01"
    	monthEnd="$YEAR-10-31"
		makeDir "10-Oct" $YEAR
		;;
    "nov")
    	monthToCopy="$YEAR-11-01"
    	monthEnd="$YEAR-11-30"
		makeDir "11-Nov" $YEAR
		;;
    "dec")
    	monthToCopy="$YEAR-12-01"
    	monthEnd="$YEAR-12-31"
		makeDir "12-Dec" $YEAR
		;;
    *)
		usage
esac


## Copy CR2 file to RAW
printf "Now copying *.CR2 files...\n"
for i in `find ${LOCAL_IMAGES_FOLDER}/*.CR2 -type f -newermt "$monthToCopy" ! -newermt "$monthEnd"`
do
	cp -pv "$i" "$REMOTE_RAW_FOLDER"
	printf "\n"
done


printf "\n\n"
printf "Now copying *.THM *.MOV *.JPG files...\n"
for i in `find ${LOCAL_IMAGES_FOLDER} \( -name "*.THM" -o -name "*.MOV" -o -name "*.JPG" \) -type f -newermt "$monthToCopy" ! -newermt "$monthEnd"`
do
	cp -pv "$i" "$REMOTE_IMAGES_FOLDER"
	printf "\n"
done

printf "!!!!COMPLETE!!!!"

exit $?

