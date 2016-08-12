//npm install webduino-blockly
require("webduino-js");
require("webduino-blockly");
var firebase = require("firebase");

var request = require("request");
var cheerio = require("cheerio");
var fs = require("fs");

//http://www.ibon.com.tw/js/commonutil.js

var pm25 = function() {
  request({
    url: "http://www.ibon.com.tw/retail_inquiry.aspx#gsc.tab=0",
    method: "POST"
  }, function(error, response, body) {
    if (error || !body) {
      return;
    }
    var $ = cheerio.load(body);
    var result = [];
    var titles = $("#InquiryResule");
    var location;
    for (var i = 0; i < titles.length; i++) {
      result.push(titles);
    }
    fs.writeFile("result.json", result);
  });
};

pm25();
setInterval(pm25,30*60*1000);