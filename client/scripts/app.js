(function(){
    'use strict';

    var Prism = require('../../node_modules/prismjs/components/prism-core.js');
    require('../../node_modules/prismjs/components/prism-markup.js');
    require('../../node_modules/prismjs/components/prism-markdown.js');
    require('../../node_modules/prismjs/components/prism-clike.js');
    require('../../node_modules/prismjs/components/prism-javascript.js');
    require('../../node_modules/prismjs/components/prism-coffeescript.js');
    require('../../node_modules/prismjs/components/prism-jade.js');
    require('../../node_modules/prismjs/components/prism-stylus.js');
    require('../../node_modules/prismjs/components/prism-css.js');

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
