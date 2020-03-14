#これはコメントです。

# テキストファイル定義
FILE_NAME=filelist.txt

# 一時ファイル定義
#tmp="/media/pi/8C69-AF16/tmp/samuel.mp4"
tmp="/media/pi/FC30-3DA9/tmp/ysw_sample.mp4"

# IFS は文字列リストのフィールド区切り文字で、デフォルトは半角スペース。
# 行をそのまま取り込むために IFS を改行に変更
OLDIFS="$IFS"
IFS="\n"

# 過去に表示したURLを少し覚えておく
ARY_FEW=()
FEW_NUM=20		# 最大要素数

while :
#for (( MLoop = 0; MLoop < 10; ++MLoop ))
do

# 配列定義
ARY_CODE=()

#### テキストファイルを1行ずつ読み込む  ####
while read LINE
do
    # 1行分の文字列の先頭から9～14文字目を取得
    # CODE=`echo $LINE | cut -c9-14`  # <= これでもよいが少し処理が遅い。
    # CODE="${LINE:8:6}"

    # 空行、空白行は飛ばし、行として格納しない。
    CODE="${LINE}"

	# コメント部をカット #より左を抽出
	URL="${CODE%#*}"

    # 配列に追加
    ARY_CODE=("${ARY_CODE[@]}" "$URL")
done < $FILE_NAME

#### URLの数が少ない
if [ ${#ARY_CODE[@]} -lt `expr 2*$FEW_NUM` ] ; then
	echo "The number of URLs is small !!"
	IFS="$OLDIFS"
	exit
fi

#### 配列の内容を出力して確認  ####
for (( I = 0; I < ${#ARY_CODE[@]}; ++I ))
do
    # 近い過去に表示したこのないランダム数値を出す。
	tikai=0
	jrand=`expr $RANDOM % ${#ARY_CODE[@]}`
	echo $jrand
	for (( few_co = 0;few_co < ${#ARY_FEW[@]} ;++few_co ))
	do
	   if [ "${ARY_FEW[few_co]}" = "${ARY_CODE[jrand]}" ] ; then
			echo "url:tikai"
			tikai=1
			continue;
		fi
	done
   if [ $tikai = 1 ] ; then
		continue;
	fi

	#末尾に新しい番号を追加して、先頭の古い番号を消す。
	ARY_FEW=("${ARY_FEW[@]}" "${ARY_CODE[jrand]}")
	if [ ${#ARY_FEW[@]} -gt $FEW_NUM ] ; then
		ARY_FEW=("${ARY_FEW[@]:1}")
	fi

	 # 表示したURLをファイルに書き出し
    echo $jrand , ${ARY_CODE[jrand]} >> exed_idx.txt
    echo ${ARY_CODE[jrand]}

	# YouTube表示
    node pontube_Arg.js "${ARY_CODE[jrand]}" ${tmp}

	# jsを使用しない YouTube表示
#	rm ${tmp}
#	youtube-dl "${ARY_CODE[jrand]}" -o ${tmp} --no-playlist
#	/usr/bin/omxplayer ${tmp} -b -o alsa

done


# リスト1週ループ
done

end0:

# IFS を元に戻す
IFS="$OLDIFS"

exit
