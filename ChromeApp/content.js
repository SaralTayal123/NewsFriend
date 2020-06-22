// content.js
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.action === 'fetchTitle') {
        // sendResponse(document.all[0].outerHTML)
        sendResponse(document.getElementsByTagName("h1")[0].innerHTML)
    }
    if (request.action === 'fetchParagraphs') {
        var ptags = "init"
        var ptagLen = document.getElementsByTagName("p").length
        for (var i = 0; i < ptagLen; i++) {
            var nextElem = document.getElementsByTagName("p")[i].innerHTML
            ptags = ptags.concat(nextElem);
            ptags = ptags.concat("\n NEXT PARA \n");

        }
        sendResponse(ptags)

        // sendResponse(document.all[0].outerHTML.text())
        // sendResponse(document.getElementsByTagName("p")[0].innerHTML)
    }
    if (request.action === 'fetchUrl') {
        // sendResponse(document.getElementsByTagName("h1")[0].innerHTML)

        sendResponse(document.URL)
    }
});