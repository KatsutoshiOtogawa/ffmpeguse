# ffmpeguse

## ファイルの連結
```
# もし、list.txtという形で使うなら-protocol_whitelistにpipeはいらない。
# sedはファイル名に半角スペースが含まれているときのための処理。
# できれば、ファイル名に半角スペースが含まれていないことを仕様に入れたい。
$ filename=“filename”
$ ext=mp4
$ ls -1 | sed 's/ /\\ /' |awk '{print "file " $0}' | ffmpeg -f concat -protocol_whitelist file,pipe -safe 0 -i - -c copy  "${filename}.${ext}"
```

## ファイルのエンコードの変更

```
# 元のファイルは残ります。
# ffmpeg -i 元のファイル 変更後のファイル
$ filename=“filename”
$ ffmpeg -i "${filename}.wmv" "${filename}.mp4"
```
