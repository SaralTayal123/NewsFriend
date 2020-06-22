console = chrome.extension.getBackgroundPage().console

document.addEventListener('DOMContentLoaded', function () {
  var generateButton = document.getElementById('generate');
  generateButton.addEventListener('click', function(tabs){
    chrome.tabs.getSelected(null, function(tab){
      chrome.tabs.sendMessage(tab.id, { action: 'fetchTitle'}, doStuffWithTitle);
    });
    chrome.tabs.getSelected(null, function (tab) {
      chrome.tabs.sendMessage(tab.id, { action: 'fetchParagraphs' }, doStuffWithParagraphs);
    });
    chrome.tabs.getSelected(null, function (tab) {
      chrome.tabs.sendMessage(tab.id, { action: 'fetchUrl' }, doStuffWithURL);
    });
  }, false);
}, false);

function doStuffWithTitle(domContent) {
  chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
}

function doStuffWithParagraphs(domContent) {
  chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
}

function doStuffWithURL(domContent) {
  chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
}