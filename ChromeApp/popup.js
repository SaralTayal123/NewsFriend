import { } from './progressbar.js';




var readabilityCircle = new ProgressBar.Circle('#readdability', {
    color: '#252842',
    // This has to be the same size as the maximum width to
    // prevent clipping
    strokeWidth: 4,
    trailWidth: 1,
    easing: 'easeInOut',
    duration: 1800,

    from: { color: '#ff2200', width: 2 },
    to: { color: '#04ff00', width: 4 },
    // Set default step function for all animate calls
    step: function (state, circle) {
        circle.path.setAttribute('stroke', state.color);
        circle.path.setAttribute('stroke-width', state.width);

        var value = Math.round(circle.value() * 100);
        if (value === 0) {
            circle.setText('');
        } else {
            circle.setText(value);
        }

    }
});
var timeCircle = new ProgressBar.Circle('#relativeReaddability', {
    color: '#252842',
    // This has to be the same size as the maximum width to
    // prevent clipping
    strokeWidth: 4,
    trailWidth: 1,
    easing: 'easeInOut',
    duration: 1800,

    from: { color: '#04ff00', width: 2 },
    to: { color: '#ff2200', width: 4 },
    // Set default step function for all animate calls
    step: function (state, circle) {
        circle.path.setAttribute('stroke', state.color);
        circle.path.setAttribute('stroke-width', state.width);

        var value = Math.round(circle.value() * 100);
        if (value === 0) {
            circle.setText('');
        } else {
            circle.setText(value);
        }

    }
});

var ratingBar = new ProgressBar.Line('#readingTime', {
    strokeWidth: 4,
    easing: 'easeInOut',
    duration: 1400,
    color: '#FFEA82',
    trailColor: '#eee',
    trailWidth: 1,
    svgStyle: { width: '100%', height: '100%' },
    text: {
        style: {
            // Text color.
            // Default: same as stroke color (options.color)
            color: '#252842',
            position: 'relative',
            top: '-40px',
            padding: 0,
            margin: 0,
            transform: null
        },
        autoStyleContainer: false
    },
    from: { color: '#ff2200', width: 2 },
    to: { color: '#04ff00', width: 4 },
    step: (state, bar) => {
        bar.setText('Rating: ' + Math.round(bar.value() * 10));
    }
});


function isValidURL(string) {
    var res = string.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    return (res !== null)
};

async function requestData(url) {
    chrome.extension.getBackgroundPage().console.log("getting data")
    await fetch(url).then(response => {
        chrome.extension.getBackgroundPage().console.log("Got data");
        return response.json();
    }).then(data => {
        chrome.extension.getBackgroundPage().console.log("Got data2");
        // Work with JSON data here
        // chrome.extension.getBackgroundPage().console.log(data);
        chrome.extension.getBackgroundPage().console.log(data['Headline']);
        // chrome.extension.getBackgroundPage().console.log(data['readingscore']["readTime"]);
        // chrome.extension.getBackgroundPage().console.log(data['readingscore']["readability"]);
        // readabilityCircle.animate(data['readingscore']["readability"] / 100)
        // timeCircle.animate(data['readingscore']["readTime"] % 10)
        // // ratingBar.animate(data['relativeScore'])
        // ratingBar.animate(1)
        // animation((data['readingscore']["readability"] / 100), (data['readingscore']["readTime"] / 10), 1)
        readabilityCircle.animate(0.1);  // Number from 0.0 to 1.0
        timeCircle.animate(0.1);  // Number from 0.0 to 1.0
        ratingBar.animate(0.1)
    }).catch(err => {
        chrome.extension.getBackgroundPage().console.log(err)
    });
}

chrome.tabs.getSelected(null, function (tabs) {
        if (isValidURL(tabs.url)) {
            var cleanedURL = tabs.url.replace(/\//g, '|')
            var api = "http://127.0.0.1:8000/ping/"
            var requestUrl = api.concat(cleanedURL)
            chrome.extension.getBackgroundPage().console.log(requestUrl)
            requestData(requestUrl)
        }
    }
);

//-------------------------


readabilityCircle.animate(0.6);  // Number from 0.0 to 1.0
timeCircle.animate(0.7);  // Number from 0.0 to 1.0
ratingBar.animate(0.5)



// console = chrome.extension.getBackgroundPage().console

// document.addEventListener('DOMContentLoaded', function () {
//   var generateButton = document.getElementById('generate');
//   generateButton.addEventListener('click', function(tabs){
//     chrome.tabs.getSelected(null, function(tab){
//       chrome.tabs.sendMessage(tab.id, { action: 'fetchTitle'}, doStuffWithTitle);
//     });
//     chrome.tabs.getSelected(null, function (tab) {
//       chrome.tabs.sendMessage(tab.id, { action: 'fetchParagraphs' }, doStuffWithParagraphs);
//     });
//     chrome.tabs.getSelected(null, function (tab) {
//       chrome.tabs.sendMessage(tab.id, { action: 'fetchUrl' }, doStuffWithURL);
//     });
//   }, false);
// }, false);

// function doStuffWithTitle(domContent) {
//   chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
// }

// function doStuffWithParagraphs(domContent) {
//   chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
// }

// function doStuffWithURL(domContent) {
//   chrome.extension.getBackgroundPage().console.log('I received the following DOM content:\n' + domContent);
// }