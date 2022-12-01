#!/bin/bash
PREVIOUS=0
GREATER=0

while read LINE; do
	if [ $PREVIOUS -gt 0 ] && [ $LINE -gt $PREVIOUS ]; then
		((GREATER=$GREATER+1))
	fi
	PREVIOUS=$LINE
done < "${1:-/dev/stdin}"

echo $GREATER
