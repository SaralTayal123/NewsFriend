var contextMenuItem = {
  "id": "NewsFriend",
  "title": "Analyze With NewsFriend",
  "contexts":["selection"]
};

chrome.contextMenus.create(contextMenuItem);

function isValidURL(string) {
  var res = string.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
  return (res !== null)
};

async function requestData(url){
  console.log("getting data")
  response = await fetch(url)
  console.log(response.json())
  console.log("got data")

}
chrome.contextMenus.onClicked.addListener(function(clickedItem){
  if (clickedItem.menuItemId == "NewsFriend" && isValidURL(clickedItem.linkUrl)) {
    if (isValidURL(clickedItem.linkUrl)){
      cleanedURL = clickedItem.linkUrl.replace(/\//g, '|')
    }
    else if (isValidURL(clickedItem.selectionText)){
      cleanedURL = clickedItem.selectionText.replace(/\//g, '|')
    }
    api = "http://127.0.0.1:8000/ping/"

    requestUrl = api.concat(cleanedURL)
    chrome.extension.getBackgroundPage().console.log(requestUrl)
    requestData(requestUrl)
  } 
});