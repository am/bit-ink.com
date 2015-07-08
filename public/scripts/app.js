(function () {
    // settings
    // the timeout is high since the response could not be cached
    $.pjax.defaults.timeout = 2000;
    // events bind
    $(document).on('pjax:complete', function() {
        Prism.highlightAll();
    });
    $(document).pjax('a[data-pjax]', '#viewsource');
}());
