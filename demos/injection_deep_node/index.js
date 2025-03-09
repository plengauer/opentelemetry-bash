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
  response.on('data', function (chunk) {});
  response.on('end', function () {});  
}).end();
