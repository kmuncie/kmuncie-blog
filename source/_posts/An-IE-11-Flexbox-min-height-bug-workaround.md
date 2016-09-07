---
title: An IE 11 Flexbox min-height bug workaround
permalink: ie-11-flexbox-min-height-bug-workaround
id: 34
updated: '2016-07-12 15:53:28'
date: 2016-07-12 15:38:04
tags:
---

You may have run into this "flexbug" on Philip Walton's excellent list of odd and frustrating Flexbox bugs, this one is currently [bug #3](https://github.com/philipwalton/flexbugs#3-min-height-on-a-flex-container-wont-apply-to-its-flex-items). He offers a solution which uses viewport heights and nested containers, but those approaches did not work for my problem. Below is a solution I found to my specific implementation that may be helpful to you. 

In my case, I had a button which used a min-height to ensure uniformity but not a set height in order to accommodate wrapping text.

I found that IE 11 would correctly align the flex items IF there was something inside which it could measure. In order to give it something to measure I am including a pseudo-element with a height set to match the min-height of the flex container. This provides for no visible change but gives IE enough information to correctly layout the flex items. 

If this helps you I would love to know about it. Hit me up on Twitter [@kmuncie](https://twitter.com/kmuncie)! 

<p data-height="570" data-theme-id="dark" data-slug-hash="kXxGxO" data-default-tab="css,result" data-user="kmuncie" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/kmuncie/pen/kXxGxO/">IE11 Flexbox Bug Workaround</a> by Kevin Muncie (<a href="http://codepen.io/kmuncie">@kmuncie</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>