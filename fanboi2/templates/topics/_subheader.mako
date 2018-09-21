<%namespace name="datetime" file="../partials/_datetime.mako" />
<header class="panel panel--inverse panel--shadowed util-padded-bottom">
    <div class="container">
        <h2 class="panel__item"><a class="util-text-gray" href="${request.route_path('board', board=board.slug)}">${board.title}</a></h2>
        <h2 class="panel__item"><a href="${request.route_path('topic', board=board.slug, topic=topic.id)}">${topic.title}</a></h2>
        <p class="panel__item">${topic.meta.post_count} posts at ${datetime.render_datetime(topic.meta.posted_at)}</p>
    </div>
</header>
