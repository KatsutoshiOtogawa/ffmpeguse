# ffmpeguse

## ファイルの連結
```
# もし、list.txtという形で使うなら-protocol_whitelistにpipeはいらない。
# sedはファイル名に半角スペースが含まれているときのための処理。
# できれば、ファイル名に半角スペースが含まれていないことを仕様に入れたい。
# 数字の連番 filename-1,filename-2を正しく接続するためにsort -V
$ filename=“filename”
$ ext=mp4
$ ls -1 | sort -V | sed 's/ /\\ /g' |awk '{print "file " $0}' | ffmpeg -f concat -protocol_whitelist file,pipe -safe 0 -i - -c copy  "${filename}.${ext}"
```

## ファイルのエンコードの変更

```
# 元のファイルは残ります。
# ffmpeg -i 元のファイル 変更後のファイル
$ filename=“filename”
$ ffmpeg -i "${filename}.wmv" "${filename}.mp4"
```
## まとめて実行

```
$ filename=“filename”
$ origext=wmv
$ ext=mp4
$ ls -1 | sort -V | sed 's/ /\\ /g' |awk '{print "file " $0}' | ffmpeg -f concat -protocol_whitelist file,pipe -safe 0 -i - -c copy  "${filename}.${origext}"
$ ffmpeg -i "${filename}.${origext}" "${filename}.${ext}"
```

## scriptから実行
```
$ filename=“filename”
$ origext=wmv
$ ext=mp4
$ curl -sf https://raw.githubusercontent.com/KatsutoshiOtogawa/ffmpeguse/master/script.sh | bash -s "${filename}" $origext $ext
```
# 動画から静画へのぬき出し

```
$ filename="filename"
$ ext=mp4
$ # 開始時間(秒)
$ start_time=120
$ # 開始時間から何秒抜き取るか
$ pop_time=7200
$ ffmpeg -i "${filename}.${ext}" -ss $start_time -t $pop_time $filename_%06d.jpg
```
