
// Execute the inject.js in a tab and call a method,
// passing the result to a callback function.
function injectedMethod(tab, method, callback) {
  chrome.tabs.executeScript(tab.id, { file: 'inject.js' }, function () {
    chrome.tabs.sendMessage(tab.id, { method: method }, callback);
  });
}

function getBgColors(tab) {
  // When we get a result back from the getBgColors
  // method, alert the data
  injectedMethod(tab, 'getBgColors', function (response) {
    console.log("TEST")
    alert('Elements in tab: ' + response.data);
    return true;
  });
}

// When the browser action is clicked, call the
// getBgColors function.
chrome.browserAction.onClicked.addListener(getBgColors);