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
        if [ $param = "/r" ]; then
                find $dirawal -name "*.$ext" -exec cp -v {} $dirtujuan \;
        elif [ $param = "/f" ]; then
                sync_force
        elif [ $param = "/a" ]; then
                find $dirawal -name "*.$ext" -exec cp -v -n {} $dirtujuan \;
        fi
}

if [ "$dirawal" = "/?" ]; then
	#write HELP doc here.
	echo -e "Folder Synchronizer"
	echo -e "\nUSAGE"
	echo -e "\tsync.sh sourcedir destdir OPTION [EXT]"
	echo -e "\nOPTIONS"
	echo -e "\t/r -- Replace Synchronize - Menyalin semua file di folder sumber ke folder tujuan. File yang sudah ada akan ditimpa."
	echo -e "\t/f -- Force Synchronize - Memaksa folder tujuan berisi sama persis dengan folder sumber."
	echo -e "\t/a -- Add Synchronize - Menyalin semua file yang belum ada di folder tujuan."
	echo -e "\nEXT"
	echo -e "\tExtensi file. Misal mp3, pdf."
	echo -e "\tJika ada, maka hanya akan memproses file dengan ekstensi yang disebutkan. Akan diabaikan jika menggunakan /f."
	echo -e "\nEXAMPLE"
	echo -e "\tsync.sh old new /f"
	echo -e "\tMenyalin semua file di folder 'old' ke folder 'new'. Memaksa isi folder 'new' sama persis dengan folder 'old'."
	echo -e "\n\tsync.sh old new /r mp3"
	echo -e "\tMenyalin semua file berekstensi mp3 dari folder 'old' ke folder 'new'. Menimpa file yang sudah ada."
	echo -e "\nVERSION"
	echo -e "\t1.0"
	echo -e "\nAUTHOR"
	echo -e "\tDitulis oleh Johan Alda, Yosef Resi Augmanto, dan Silvanus Satno Nugraha."
	echo -e ""
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
