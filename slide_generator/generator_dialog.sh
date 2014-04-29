#!/bin/bash

# Show dialog for picking up chapters
OUTPUT_DIR=$1
echo "Output dir is $OUTPUT_DIR"
CHDIR=chapters
CHAPTERS=`for FILE in $CHDIR/*; do NAME=$(basename $FILE | sed -e "s/.tex//g") && echo -n "$NAME "; done`
SELECTED=()

PS3="Kapitel hinzufügen: "

for (( ; ; ))
do
select NEXT in $CHAPTERS Beenden;
do
    if [ "$NEXT" != "Beenden" ]
    then
        SELECTED+=" $NEXT"
        echo ""
        echo "Aktuelle Kapitelauswahl: "
        IDX=1
        for CHAP in $SELECTED
        do
            echo "$IDX: $CHAP"
            IDX=$(( $IDX+1 ))
        done
        echo ""
    fi
    break
done
    if [ "${NEXT}" == "Beenden" ]
    then
        break
    fi
done

# Show dialog to enter presentation title, authors and date
echo -n "Titel der Präsentation: "
read TITLE
echo -n "Autor(en): "
read AUTHOR
echo -n "Datum: "
read DATE

OUT_FILE="$OUTPUT_DIR/slides.tex"
mkdir -p out
cat preamble.tex > $OUT_FILE

sed -i -e "s/<TITLE>/$TITLE/g" $OUT_FILE 
sed -i -e "s/<AUTHOR>/$AUTHOR/g" $OUT_FILE 
sed -i -e "s/<DATE>/$DATE/g" $OUT_FILE

for CHAP in $SELECTED
do
    echo "Adding $CHAP.tex"
    cat "chapters/$CHAP.tex" >> $OUT_FILE
done

echo "" >> $OUT_FILE
echo "\\end{document}" >> $OUT_FILE
