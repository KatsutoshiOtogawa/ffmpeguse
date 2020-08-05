# ffmpeg存在確認
which ffmpeg > /dev/null
if [[ $? -ne 0 ]]; then
    echo you need to install ffmpeg for edit movie file.
    exit 1
fi
# 引数はすべて環境変数から受け継ぐ
if [[ ! ($filename && $ext && $origext) ]]; then
    echo you need to set variable filename, ext and origext.
    exit 1
fi

ls -1 | sort -V
read -p "you want to concat movie file in this directory? [yes/no]" result
if [[ $result != "yes" ]]; then
    exit 1
fi

ls -1 | sort -V | sed 's/ /\\ /g' |awk '{print "file " $0}' | ffmpeg -f concat -protocol_whitelist file,pipe -safe 0 -i - -c copy  "${filename}.${origext}"
ffmpeg -i "${filename}.${origext}" "${filename}.${ext}"
