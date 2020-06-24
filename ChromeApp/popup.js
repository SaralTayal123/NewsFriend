import { } from './progressbar.js';

var circle = new ProgressBar.Circle('#readdability', {
    color: '#ffffff',
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
var circle2 = new ProgressBar.Circle('#relativeReaddability', {
    color: '#ffffff',
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

// var bar = new ProgressBar.Line('#readingTime', {
//     strokeWidth: 4,
//     easing: 'easeInOut',
//     duration: 1400,
//     color: '#FFEA82',
//     trailColor: '#eee',
//     trailWidth: 1,
//     svgStyle: { width: '100%', height: '100%' },
//     text: {
//         style: {
//             // Text color.
//             // Default: same as stroke color (options.color)
//             color: '#999',
//             position: 'relative',
//             right: '30px',
//             top: '30px',
//             padding: 0,
//             margin: 0,
//             transform: null
//         },
//         autoStyleContainer: false
//     },
//     from: { color: '#ff2200', width: 2 },
//     to: { color: '#04ff00', width: 4 },
//     step: (state, bar) => {
//         bar.setText(Math.round(bar.value() * 100) + ' %');
//     }
// });


var bar = new ProgressBar.Line("#readingTime", {
    strokeWidth: 4,
    easing: 'easeInOut',
    duration: 1400,
    color: '#FFEA82',
    trailColor: '#eee',
    trailWidth: 1,
    svgStyle: { width: '100%', height: '100%' },
    from: { color: '#FFEA82' },
    to: { color: '#ED6A5A' },
    step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
    }
});
circle.animate(0.6);  // Number from 0.0 to 1.0
circle2.animate(0.7);  // Number from 0.0 to 1.0
bar.animate(0.5)

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