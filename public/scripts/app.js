(function () {
    console.log('app initialize.');
    // the timeout is high since the response could not be cached
    $.pjax.defaults.timeout = 2000;
    $(document).pjax('a[data-pjax]', '#viewsource');
}());
