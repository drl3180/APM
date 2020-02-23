#!/bin/bash

#functions

run () {
	i=1
	while [ $i -lt 7 ]
	do
		chmod 755 APM$i
		./APM$i $1 &
		((i++))
	done
}

cpumem () {
	i=1
	while [ $i -lt 7 ]
	do
		ps -C APM$i -o %cpu,%mem | sed 's/  /,/g' | tail -1 | echo $SECONDS,$(cut -f 1,2 -d ',') >> "APM$i"_metric.csv
		((i++))
	done
}

net () {
	i=1
	while [ $i -lt 7 ]
	do
		
		((i++))
	done
}

hdd () {
	i=1
	while [ $i -lt 7 ]
	do
		
		((i++))
	done
}

cleanup () {
	i=1
	while [ $i -lt 7 ]
	do
		killall APM$i
		((i++))
	done
}
trap cleanup EXIT

run $1

while [ true ]
do
		
	sleep 5
done

