#!/bin/sh

# fixup dashboard, panel format for ES 6.x

JSON_FILES=$(find ./ -name '*.json')


for F in $JSON_FILES; do
  
  
  HAS_FIX=$(jq 'has("attributes")' $F)
  
  if [ "$HAS_FIX" == "false" ] ; then
    echo "$F: needs fix"
    TYPE=$( echo "$F" | cut -d/  -f3 -)
    ID=$(basename $F .json)
    jq '{ version: 1, id: "'"$ID"'", type: "'"$TYPE"'", attributes: . }' $F > $F.converted
    mv $F.converted $F
  fi 
  
  
  
done


