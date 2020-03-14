//youtube-dlを呼び出します。

var fs = require('fs');

var youtubedl = require('youtube-dl');

// savefilepath
var movefilename = './samuel.mp4'
if(process.argv.length > 3){
  movefilename = process.argv[3]
}

//ここで読み込みURLを指定します
// --format=18
// --prefer-free-formats
var video = youtubedl(process.argv[2],

  ['--format=18'],

  { cwd: __dirname, maxBuffer: 1000*1024 });

video.on('info', function(info) {

  console.log('Download started');

  console.log('filename: ' + info.filename);

  console.log('size: ' + info.size);

});

//video.pipe(fs.createWriteStream('./samuel.mp4'));
//video.pipe(fs.createWriteStream('/media/pi/8C69-AF16/youtube-show2/samuel.mp4'));
video.pipe(fs.createWriteStream(movefilename));

video.on('end', function(){

  console.log('Download end');

  console.log('Play start');

  //node-omxplayerを呼び出します

  var Omx = require('node-omxplayer');

//  var player = Omx('samuel.mp4');
//  var player = Omx('/media/pi/8C69-AF16/youtube-show2/samuel.mp4');
  var player = Omx(movefilename);


});
