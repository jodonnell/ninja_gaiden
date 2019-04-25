var filewatcher = require('filewatcher');

var watcher = filewatcher();

var execFile = require('child_process').execFile;
execFile('find', [ '.' ], function(err, stdout, stderr) {
  var fileList = stdout.split('\n');
  fileList.forEach(file => {
    if (file.endsWith('.moon')) {
      watcher.add(file);
    }
  })
});

watcher.on('change', function(file, stat) {
  execFile('moonc', [ file ], function(err, stdout, stderr) {
    console.log(stdout)
    console.log(stderr)
  })
});
