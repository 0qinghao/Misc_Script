#!/bin/sh

cat encode.md5 | while read line; do
    md5_only=$(echo $line | cut -d " " -f1)
    # echo $md5_only
    file_name=$(echo $line | cut -d " " -f2)
    # echo $file_name
    if $(grep -qE "$md5_only\s+$file_name" md5_encode.md5); then # -q: 安静模式, 匹配成功返回 TRUE
        echo $file_name MATCH
    else
        echo ERROR. $file_name LOST
    fi
done
