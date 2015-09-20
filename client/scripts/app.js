// exposing jQuery to globals to support the plugins
global.jQuery = $ = require('jquery');
var pjax = require('jquery-pjax');
var Prism = require('../../bower_components/prism/components/prism-core.js');
require('../../bower_components/prism/components/prism-markup.js');
require('../../bower_components/prism/components/prism-markdown.js');
require('../../bower_components/prism/components/prism-clike.js');
require('../../bower_components/prism/components/prism-javascript.js');
require('../../bower_components/prism/components/prism-coffeescript.js');
require('../../bower_components/prism/components/prism-jade.js');
require('../../bower_components/prism/components/prism-stylus.js');
require('../../bower_components/prism/components/prism-css.js');

(function(){
    'use strict';

    // settings
    // the timeout is high since the response could not be cached
    $.pjax.defaults.timeout = 2000;

    var updatePrism = function() {
        Prism.highlightAll();
    };
    var updateGA = function() {
        Prism.highlightAll();
    };

    var updateUI = function () {
        setTimeout( function () {
            $('.viewsource').height($('#viewsource').outerHeight(true));
        }, 300);
    };

    // events bind
    $(document).on('pjax:complete', function() {
        updatePrism();
        updateGA();
    });

    $(document).on('pjax:end', function() {
        updateUI();
    });
    // init pjax
    $(document).pjax('a[data-pjax]', '#viewsource');
    // update UI at first load
    updateUI();

}());
