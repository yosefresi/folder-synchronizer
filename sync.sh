#!/bin/sh

dirawal=$1
dirtujuan=$2



sync_copy (){
	for FILE in `ls $dirawal`
	do
		cp -v $dirawal/$FILE $dirtujuan
	done
}

sync_delall (){
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

sync_delpart (){
	echo delpart
}

if  [ -d $dirawal ]; then
	if [ -d $dirtujuan ]; then
		if [ $# -eq 3 ]; then
			if [ "$3" = 1 ]; then
				sync_copy
			elif [ "$3" = 2 ]; then
				sync_delall
			elif [ "$3" = 3 ]; then
				sync_add
			elif [ "$3" = 4 ]; then
				sync_delpart
			else echo "Parameter salah harus antara 1 - 4"
			fi
		else echo "Parameter tidak ada"
		fi
	else echo "Directory tujuan salah, tidak ditemukan : $dirtujuan"
	fi
else echo "Directory awal salah, tidak ditemukan : $dirawal"
fi
