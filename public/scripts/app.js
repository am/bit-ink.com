(function () {
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
        $('.viewsource').height($('#viewsource').height());
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
p
