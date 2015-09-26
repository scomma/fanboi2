<%namespace name="formatters" module="fanboi2.formatters" />
<header class="subheader">
    <div class="container">
        <h2 class="subheader-title"><a href="${request.route_path('board', board=board.slug)}">${board.title}</a></h2>
        <div class="subheader-body">${formatters.format_markdown(request, board.description)}</div>
        <div class="subheader-footer">
            <ul class="actions">
                <li class="actions-item"><a class="button${' primary' if request.route_name == 'board' else ''}" href="${request.route_path('board', board=board.slug)}">Recent topics</a></li>
                <li class="actions-item"><a class="button${' primary' if request.route_name == 'board_all' else ''}" href="${request.route_path('board_all', board=board.slug)}">All topics</a></li>
                <li class="actions-item"><a class="button${' primary' if request.route_name == 'board_new' else ''}" href="${request.route_path('board_new', board=board.slug)}">New topic</a></li>
            </ul>
        </div>
    </div>
</header>