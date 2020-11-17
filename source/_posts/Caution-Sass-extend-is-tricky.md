---
title: 'Caution: Sass @extend is tricky!'
date: 2020-11-15 13:03:52
tags:
   - Sass
   - scss
   - extend
   - danger
   - css
---

The dangers of Sass `@extend` have been [written](https://css-tricks.com/the-extend-concept/)
[about](https://www.sitepoint.com/sass-extend-nobody-told-you/) [many](https://webinista.com/updates/dont-use-extend-sass/)
[times](https://www.smashingmagazine.com/2015/05/extending-in-sass-without-mess/)
[before](https://pressupinc.com/blog/2014/11/dont-overextend-yourself-in-sass/).


However, this is my personal short list of why I almost never use `@extend`. Much of my reasoning below is based on years of experience
writing and maintaining codebases with 10,000 or 20,000+ scss lines of code. In smaller projects or codebases maintained by a single
developer these dangers become easier to manage. Hopefully the example below help you know when it's time to reconsider your usage of
`@extend`.

## Compiled Footguns

Some of the dangers of [`@extend`](https://sass-lang.com/documentation/at-rules/extend) are baked into the directive and liberal warnings
are given in the documentation. It is always worth a read if you have not studied it.

### Media Queries

You are unable to extend a class inside a media query. This is a limitation which hints at other dangers, which do not produce compilation
errors. We will consider a few of these next.

<p class="codepen" data-height="500" data-theme-id="dark" data-default-tab="css,result" data-user="kmuncie" data-slug-hash="rNLRZeG"
style="height: 500px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0;
padding: 1em;" data-pen-title="@extend media queries">
   <span>See the Pen <a href="https://codepen.io/kmuncie/pen/rNLRZeG">
   @extend media queries</a> by Kevin Muncie (<a href="https://codepen.io/kmuncie">@kmuncie</a>)
   on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### Source Order

When using `@extend` it can be difficult to keep track of the order to which the selectors will compile.

<p class="codepen" data-height="500" data-theme-id="dark" data-default-tab="css,result" data-user="kmuncie" data-slug-hash="abZMzNK"
style="height: 500px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0;
padding: 1em;" data-pen-title="@extend selector order">
   <span>See the Pen <a href="https://codepen.io/kmuncie/pen/abZMzNK">
   @extend selector order</a> by Kevin Muncie (<a href="https://codepen.io/kmuncie">@kmuncie</a>)
   on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

{% codeblock compiled.css lang:css %}
   .global-green, .subtitle-modifier {
   color: green;
   }

   .subtitle {
   color: red;
   }
{% endcodeblock %}

### Extending Everywhere

In a large project with many developers it can be hard to keep track of what is happening in the entire scss codebase. It thus requires
extreme vigilance to ensure that any class you extend is only used as intended. It can be very hard for others to understand this intent when
coming into a codebase for the first time.

Notice the following scss code and try to visualize what the compiled css will look like.

<p class="codepen" data-height="500" data-theme-id="dark" data-default-tab="css,result" data-user="kmuncie" data-slug-hash="WNxmggp"
style="height: 500px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0;
padding: 1em;" data-pen-title="@extend all over">
<span>See the Pen <a href="https://codepen.io/kmuncie/pen/WNxmggp">
@extend all over</a> by Kevin Muncie (<a href="https://codepen.io/kmuncie">@kmuncie</a>)
on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


{% codeblock compiled.css lang:css %}
   .normal-boundary .outline, .normal-boundary .keep-it-dry .new-outline, .keep-it-dry .normal-boundary .new-outline {
      background-color: green;
   color: white;
   }

   .special-case .outline, .special-case .keep-it-dry .new-outline, .keep-it-dry .special-case .new-outline {
      color: yellow;
   }

   .extra-special-case .weird-stuff .outline, .extra-special-case .weird-stuff .keep-it-dry .new-outline, .keep-it-dry
   .extra-special-case .weird-stuff .new-outline {
      color: red;
   }
{% endcodeblock %}

Is that what you expected? Do you think the developer who added `@extend .outline` researched and knew about all the various instances of
`.outline` throughout the codebase? Could you imagine `_second-file.scss` and `_third-file.scss` being added by other developers **after**
the `@extend` had already been implemented without realizing the impact?

This is surely a contrived example but hopefully it is realistic enough to realize how slippery a slope `@extend` can be.

## Developer Brain Drain

### Understanding Debug Tools

{% asset_img clearfix-insanity.png "Clearfix @extend in Dev Tools" %}

This is purely a personal preference but I find it very unpleasant to try and debug an element on a page which uses `@extend`. The
properties are broken up and the selector blocks are massive. This puts you at the mercy of your browsers Dev Tools to be able to easily
read and digest what is happening. Not all browsers are good at this.
