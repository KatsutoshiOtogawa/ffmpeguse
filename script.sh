# 引数代入
filename=$1
origext=$2
ext=$3

# ffmpeg存在確認
which ffmpeg > /dev/null
if [[ $? -ne 0 ]]; then
    echo you need to install ffmpeg for edit movie file.
    exit 1
fi

# 引数のチェック
if [[ ! ($filename && $origext && $ext) ]]; then
    echo you need to set variable filename, ext and origext.
    exit 1
fi

ls -1 | sort -V | sed 's/ /\\ /g' |awk '{print "file " $0}' | ffmpeg -f concat -protocol_whitelist file,pipe -safe 0 -i - -c copy  "${filename}.${origext}"

# 変更後の拡張子と変更前の拡張子が一致しない場合は動画ファイルの種類を変更する。
if [[ ! ($origext = $ext) ]]; then
    ffmpeg -i "${filename}.${origext}" "${filename}.${ext}"
fi
