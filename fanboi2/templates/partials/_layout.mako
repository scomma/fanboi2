<%namespace name="formatters" module="fanboi2.helpers.formatters" />
<%namespace name="partials" module="fanboi2.helpers.partials" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">

        <link rel="icon" href="${request.tagged_static_path('fanboi2:static/icon.png')}" sizes="256x256">
        <link rel="shortcut icon" href="${request.tagged_static_path('fanboi2:static/icon.ico')}" type="image/x-icon">
        <link rel="apple-touch-icon" href="${request.tagged_static_path('fanboi2:static/touch-icon.png')}">
        <link rel="stylesheet" href="${request.tagged_static_path('fanboi2:static/app.css')}">

        <title>${self.title() + ' - ' if hasattr(self, 'title') else ''}Fanboi Channel</title>

        % if hasattr(self, 'header'):
            ${self.header()}
        % endif

        <% global_css = partials.global_css(request) %>
        % if global_css:
            <style>
             ${global_css}
            </style>
        % endif
    </head>
    <body id="${request.route_name}" class="${formatters.user_theme(request)}">

        <header id="top" class="header" data-board-selector="true">
            <div class="container container--plain header__container">
                <a class="header__logo" href="/">Fanboi Channel</a>
                <a class="header__button icon icon--burger util-pull-left" href="/">Sidebar</a>
                <a class="header__button icon icon--arrow util-pull-right" href="#bottom">Scroll to bottom</a>
            </div>
        </header>

        ${next.body()}

        <% global_appendix = partials.global_appendix(request) %>
        % if global_appendix:
            <div class="panel panel--inverse">
                <div class="container">
                    <div class="panel__item util-padded util-text-small typo-plain">
                        ${global_appendix}
                    </div>
                </div>
            </div>
        % endif

        <div class="container container--plain">
            <footer class="footer panel util-text-small" id="bottom">
                <div class="footer__left" data-theme-selector="true">All contents are responsibility of its poster.</div>
                <ul class="footer__right links links--tablet-vertical">
                    <li class="links__item"><a href="${request.route_path('api_root')}">API documentation</a></li>
                    <li class="links__item"><a href="https://github.com/forloopend/fanboi2">Source code</a></li>
                </ul>
                <a class="footer__up icon icon--arrow-up" href="#top">Scroll to top</a>
            </footer>
        </div>

        <script type="text/javascript" src="${request.tagged_static_path('fanboi2:static/vendor.js')}"></script>
        <script type="text/javascript" src="${request.tagged_static_path('fanboi2:static/app.js')}"></script>

        <% global_footer = partials.global_footer(request) %>
        % if global_footer:
            ${global_footer}
        % endif

    </body>
</html>
