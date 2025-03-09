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
const req = https.request(options, (res) => {});
req.end();
