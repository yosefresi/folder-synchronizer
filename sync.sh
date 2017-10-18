#!/bin/sh

dirawal=$1
dirtujuan=$2

sync_replace (){
	for FILE in `ls $dirawal`
	do
		cp -v $dirawal/$FILE $dirtujuan
	done
}

sync_force (){
	for FILE in `ls $dirtujuan`
	do
		rm $dirtujuan/$FILE
	done
	for FILE in `ls $dirawal`
	do
		cp -v $dirawal/$FILE $dirtujuan
	done
}

sync_add (){
	for FILE in `ls $dirawal`
	do
		cp -n -v $dirawal/$FILE $dirtujuan
	done
}

sync_extension (){
        if [ "$param" = "/r" ]; then
                find $dirawal -name "*.$ext" -exec cp -v {} $dirtujuan \;
        elif [ "$param" = "/f" ]; then
                sync_force
        elif [ "$param" = "/a" ]; then
                find $dirawal -name "*.$ext" -exec cp -v -n {} $dirtujuan \;
        fi
}

if [ "$dirawal" = "/?" ]; then
	#write HELP doc here.
	echo -e  "# \t Name : Synchronized folder"
	echo -e  "# \t Synopsis	sync.sh [source] [destination]"
	echo -e  "# \t Description :	"
	echo -e  "# \t \t replace/r -- Overwrite semua file yang ada pada direktori tujuan \n"
	echo -e  "# \t \t force/r -- menghapus file yang berada pada direktori tujuan kemudian
				     memindahkan file dari direktori awal "
	echo -e  "# \t \t add/r -- memindahkan file yang ada pada direktori awal ke direktori
				   tujuan. Hanya akan memindahkan file yang belum ada pada
				   direktori tujuan"
	exit 0
fi

if  [ -d $dirawal ]; then
	if [ -d $dirtujuan ]; then
		if [ $# -eq 4 ]; then
			ext=$4
			param=$3
			sync_extension
			exit 0
		elif [ $# -eq 3 ]; then
			ext=""
		else
			echo "Must use 3 or 4 params. See /? for help."
			exit 1
		fi
		if [ "$3" = "/r" ]; then
			sync_replace
			exit 0
		elif [ "$3" = "/f" ]; then
			sync_force
			exit 0
		elif [ "$3" = "/a" ]; then
			sync_add
			exit 0
		else
			echo "Param unknown. See /? for help."
			exit 1
		fi
	else
		echo "Not found : $dirtujuan"
		exit 1
	fi
else
	echo "Not found : $dirawal"
	exit 1
fi
