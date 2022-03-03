#!/bin/bash

destFile=dest.txt
textFile=appendices
tempFile=.temp.txt

cp $destFile $destFile.bak

appendText () {
    wordCount=$([[ -f $destFile ]] && cat $destFile | wc -w)

    ed -s $destFile <<< w
    
    if [[ $wordCount -eq 0 ]]; then
        tail -n +2 $textFile > $destFile
    else
        cat $textFile >> $destFile
    fi    
}
