// header.js
(function($) {
    var $body = $('body');
    var $menu = $('#menu');
    var $search = $('#search');
    var $search_input = $search.find('input');

    // 메뉴 동작
    $menu
        .appendTo($body)
        .panel({
            delay: 500,
            hideOnClick: true,
            hideOnSwipe: true,
            resetScroll: true,
            resetForms: true,
            side: 'right',
            target: $body,
            visibleClass: 'is-menu-visible'
        });

    // 검색창 동작
    $body.on('click', '[href="#search"]', function(event) {
        event.preventDefault();
        if (!$search.hasClass('visible')) {
            $search[0].reset();
            $search.addClass('visible');
            $search_input.focus();
        }
    });

    $search_input
        .on('keydown', function(event) {
            if (event.keyCode == 27)
                $search_input.blur();
        })
        .on('blur', function() {
            window.setTimeout(function() {
                $search.removeClass('visible');
            }, 100);
        });

})(jQuery);
