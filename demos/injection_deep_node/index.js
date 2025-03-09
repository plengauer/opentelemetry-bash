const https = require('https');
const options = {
  hostname: 'example.com',
  port: 443,
  path: '/',
  method: 'GET',
  headers: {
    Host: 'example.com'
  }
};
https.request(options, response => {
  var result = ''
  response.on('data', function (chunk) {
    result += chunk;
  });
  response.on('end', function () {
    console.log(result);
  });  
}).end();
