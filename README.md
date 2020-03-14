# YoutubeListPlay
ユーザーがYoutubeの再生リストを作成していおき、スクリプトが順番に再生する
ラズパイ（Raspbian）のシェルスクリプトで動作
filelist.txt 内に1行1つのURLを記述しておき、再生される。

■インストール

 node (JavaScript 環境)のインストール
$ sudo apt-get install -y nodejs npm
$ sudo npm cache clean
$ sudo npm install n -g
$ sudo n stable

 node インストールの確認
$ node -v

 youtube-dl (動画ダウンロードソフト)インストール
$ npm install youtube-dl

 node-omxplayer (動画再生ソフト)のインストール
$ npm install node-omxplayer
$ vim pontube.js

ラズパイのエクスプローラなどでys.sh と filelist.txt をラズパイの中にコピーして、ys.sh に実行権限を与えておく。

■実行

ターミナルを起動して、カラントディレクトリをコピーした場所へ移動。

実行する。
$ ./ys.sh

