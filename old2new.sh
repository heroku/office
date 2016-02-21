#!/bin/bash

# This script can't handle the room numbers that are rendered one letter/digit at a time
# in the SVG file. 

# Other Notes:
# The following rooms didn't get new assignments:
# 334 - I am calling this 319
# 342 - There's a mapping from 343 to 315 and 343 doesn't exist. I'll use that. So this room is now 315.


IFS=$'\n'
FILES="new_names_floor1.csv
new_names_floor2.csv
new_names_floor3.csv"
MAPFILE=$(cat public_html/index.html)
for file in $FILES; do
  for line in $(tail -n +2 $file); do
    old=$(echo $line | cut -d ',' -f 1)
    new=$(echo $line | cut -d ',' -f 2)
    echo "OLD: $old ---> NEW: $new"
    MAPFILE=$(echo "$MAPFILE" | sed -e "s/id=\"$old\"/id=\"NNN$new\"/")
    MAPFILE=$(echo "$MAPFILE" | sed -e "s/>$old</>NNN$new</")
  done
done
MAPFILE=$(echo "$MAPFILE" | sed -e "s/>NNN/>/g" -e "s/id=\"NNN/id=\"/g")

echo "$MAPFILE" > test.html
