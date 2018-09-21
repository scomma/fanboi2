<%namespace name="post" file="../partials/_post.mako" />
<%include file='_subheader.mako' />
<%inherit file='../partials/_layout.mako' />
<%def name='title()'>${topic.title} - ${board.title}</%def>
<%def name='header()'><link rel="canonical" href="${request.route_url('topic', board=board.slug, topic=topic.id)}"></%def>
<div class="panel panel--shadowed panel--translucent util-sticky-top">
    <div class="container">
        <div class="panel__item util-padded--small">
            <span class="button button--emboss button--compact util-text-smaller">Mode: <strong>Recent Posts</strong></span>
            <span class="button button--emboss button--compact util-text-smaller">Bury: <strong>Strict</strong></span>
            <div class="util-pull-right">
                <span class="button button--emboss button--compact util-text-smaller">Reload: Off</span>
            </div>
        </div>
    </div>
</div>
<div data-topic="${topic.id}">
    % if posts:
        <div class="panel panel--bordered panel--tint panel--unit-link">
            <div class="container">
                % if posts[0].number != 1:
                    <%
                    min_post_boundary = 50
                    min_post = max(1, posts[0].number - min_post_boundary)
                    max_post = posts[-1].number
                    %>
                    <div class="post post--plain">
                        <div class="post__item">
                            <a class="panel__link" href="${request.route_path('topic_scoped', board=board.slug, topic=topic.id, query="%s-%s" % (min_post, max_post))}">
                                % if posts[0].number <= 2:
                                    <span class="post__item post__item--bumped">1</span>
                                    <span class="post__item util-text-gray">Load previous post</span>
                                % else:
                                    <span class="post__item post__item--bumped">${min_post}-${max_post}</span>
                                    <span class="post__item util-text-gray">Load previous posts</span>
                                % endif
                            </a>
                        </div>
                    </div>
                % endif
            </div>
        </div>
        % for p in posts:
            ${post.render_post(topic, p)}
        % endfor
    % endif
    % if topic.status == 'locked':
        <div class="sheet">
            <div class="container">
                <h2 class="sheet-title">Topic locked</h2>
                <div class="sheet-body">
                    <p>Topic has been locked by moderator.</p>
                    <p>No more posts could be made at this time.</p>
                </div>
            </div>
        </div>
    % elif topic.status == 'archived':
        <div class="sheet">
            <div class="container">
                <h2 class="sheet-title">Posts limit exceeded</h2>
                <div class="sheet-body">
                    <p>Topic has reached maximum number of posts.</p>
                    % if board.status == 'restricted':
                        <p>Please request to start a new topic with moderator.</p>
                    % else:
                        <p>Please start a new topic.</p>
                    % endif
                </div>
            </div>
        </div>
    % elif board.status == 'locked':
        <div class="sheet">
            <div class="container">
                <h2 class="sheet-title">Board locked</h2>
                <div class="sheet-body">
                    <p>Board has been locked by moderator</p>
                    <p>No more posts could be made at this time.</p>
                </div>
            </div>
        </div>
    % elif board.status == 'archived':
        <div class="sheet">
            <div class="container">
                <h2 class="sheet-title">Board archived</h2>
                <div class="sheet-body">
                    <p>Board has been archived</p>
                    <p>Topic is read-only.</p>
                </div>
            </div>
        </div>
    % else:
        <form class="panel panel--shadowed util-padded" id="reply" action="${request.route_path('topic', board=board.slug, topic=topic.id)}" method="post" data-topic-inline-reply="true">
            <input type="hidden" name="csrf_token" value="${get_csrf_token()}">
            <div class="container">
                <div class="form-group${' form-group--error' if form.body.errors else ''}">
                    <label class="form-group__label" for="${form.body.id}">Reply</label>
                    ${form.body(class_='form-group__input', rows=4, **{'data-form-anchor': 'true', 'data-topic-quick-reply-input': 'true'})}
                    % if form.body.errors:
                        <span class="form-group__hint">${form.body.errors[0]}</span>
                    % endif
                </div>
                <div class="form-group">
                    <button class="button button--primary" type="submit">Post Reply</button>
                    <span class="form-group__hint">
                        ${form.bumped(**{'data-topic-state-tracker': "bump"})} <label for="${form.bumped.id}">${form.bumped.label.text}</label>
                    </span>
                </div>
            </div>
        </form>
    % endif
</div>
