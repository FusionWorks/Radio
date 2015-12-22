requirejs.config({
    packages: [
        {
            name    : 'cs',
            location: '../vendor/require-cs',
            main    : 'cs'
        },
        {
            name    : 'coffee-script',
            location: '../vendor/coffeescript',
            main    : 'extras/coffee-script'
        }
    ],
    paths: {
        jquery              : '../vendor/jquery/dist/jquery',
        underscore          : '../vendor/underscore/underscore',
        moment              : '../vendor/moment/moment',
        backstretch         : '../vendor/jquery-backstretch/jquery.backstretch',
        buzz                : 'buzz',
        io                  : 'http://' + opts.config.hostname + ':' + opts.config.ws_port + '/socket.io/socket.io',
        foundation          : '../vendor/foundation-sites/js/foundation.core',
        "foundation.slider": '../vendor/foundation-sites/js/foundation.slider',
        "foundation.offcanvas": '../vendor/foundation-sites/js/foundation.offcanvas',
        "foundation.util.mediaQuery": '../vendor/foundation-sites/js/foundation.util.mediaQuery',
        "foundation.util.motion": '../vendor/foundation-sites/js/foundation.util.motion',
        "foundation.util.triggers": '../vendor/foundation-sites/js/foundation.util.triggers',
        "foundation.util.keyboard": '../vendor/foundation-sites/js/foundation.util.keyboard',
        "foundation.util.touch": '../vendor/foundation-sites/js/foundation.util.touch'
    },
    shim: {
        "foundation"    : ['jquery'],
        "foundation.slider": ['foundation'],
        "foundation.offcanvas": ['foundation'],
        "foundation.util.mediaQuery": ['foundation'],
        "foundation.util.motion": ['foundation'],
        "foundation.util.triggers": ['foundation'],
        "foundation.util.keyboard": ['foundation'],
        "foundation.util.touch": ['foundation'],
        "backstretch"   : ['jquery']
    },
});

requirejs(["cs!radio/radio"], function(Radio) {
    new Radio
});
