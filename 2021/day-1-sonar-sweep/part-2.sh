#!/bin/bash
LINE1=0
LINE2=0
PREVIOUS=0
GREATER=0

while read LINE; do
	((CURRENT=$LINE1+$LINE2+$LINE))
	if [ $PREVIOUS -gt 0 ] && [ $CURRENT -gt $PREVIOUS ]; then
		((GREATER=$GREATER+1))
	fi

	if [ $LINE1 -gt 0 ] && [ $LINE2 -gt 0 ]; then
		PREVIOUS=$CURRENT
	fi

	LINE2=$LINE1
	LINE1=$LINE
done < "${1:-/dev/stdin}"

echo $GREATER
