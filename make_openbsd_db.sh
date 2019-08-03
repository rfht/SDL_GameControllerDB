#!/bin/sh

newline='
'
output=
while IFS= read -r line
do
	# skip lines starting with '#'
	if [ -n "$(echo "$line" | egrep '^[[:blank:]]*#')" ]; then
		continue
	fi
	gamecontroller="$(echo "$line" | cut -f 2 -s -d ',')"
	openbsd_guid="$(echo "$line" | cut -f 1 -s -d ',' )"
	openbsd_line="$(fgrep ",$gamecontroller," gamecontrollerdb.txt | fgrep Linux | head -1 \
		| cut -f 2- -s -d ',')"
	[ -n "$openbsd_line" ] && output="$output$openbsd_guid,$openbsd_line$newline"
done < openbsd_guids.txt

printf "$output" > gamecontrollerdb_openbsd.txt
