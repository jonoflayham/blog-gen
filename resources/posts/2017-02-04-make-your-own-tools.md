---
title : Make your own tools
tags : clojure
---

As developers, we're far too fond of the blunt, primitive tools we find lying around at the bottom of the software development stack - logs, CI GUIs, low-level bash commands, inflexible build scripts.  Too rarely do we write bespoke, higher-order tools to make ourselves more productive and the job more enjoyable.  We're missing out on real opportunities to go faster.

When we're writing production or test code which gets repetitive or unwieldy, it's not long before we naturally break it up into chunks and compose those chunks together at a higher, more useful level, then as things grow still more we refactor _that_ and compose over it, and so on up the ladder of abstraction.  We don't end up writing files of source code thousands of lines long, or at least I hope not.  But when it comes to the _machinery_ of software development, we're perfectly happy bolting together the same old steps by hand.  We seem unaware that we're death-marching through numerous repetitive, un-factored-out, long-winded, ambiguously-defined, error-prone steps time and time again.

What would be so wrong in daring to create project-specific tools?  Not just traditional automation, but an interface which is deliberately, intimately tailored to the software we're currently engaged in producing?  It could be somethign we use at the command line or REPL, or even through its own GUI.                                                             

There are many reasons why we tend not to write our own tools, or tend not to give much love to the ones we do create.

1. We can get buy using the facilities we already have, albeit inefficiently, so we allow ourselves to be drugged by comforting familiarity and forget that it's possible to improve.

1. When we're not very experienced, we take it as read that everything's been done for us.  "Surely Maven is all you need!"

1. It's quite easy to write a wiki page to capture complex, often-repeated processes.  You get to be a published author!  Your effort is evident to others, and they'll thank you for it.  And it's comforting to follow instructions by rote - at least for the first few times.

1. We're easily demotivated by the effort required to make something new, even if its utility is blindingly obvious.

1. Admittedly, automation sometimes hides things which it's useful to see, especially at the start of a project or a new kind of activity.  That's why manual testing is still valuable.  But this shouldn't stop us continually assessing how to avoid day-to-day drudgery.

1. When we're working at scales where the effort definitely would be worth our while, there's often too much weight of opinion behind old practices, and we're engaged in so much fire-fighting - ironically often exacerbated by the very lack of tooling - that we can't think clearly anyway.

1. Software development work is often ultimately dictated or influenced by someone who hasn't experienced the value of taking stock and investing in improving the delivery process itself.  "Delivery-focussed" people like this see a team writing its own tools as a self-indulgence.

1. Writing tools to solve messy software development problems often involves understanding many kinds of technologies - eg in infrastructure or cloud automation - and not everyone has the confidence nor the breadth of knowledge required to bring them all together.

1. There might be a Product out there which Already Does This.  Writing something specific to your situation might be seen as unnecessary effort, even if there's every chance the enterprise equivalent is expensive, bloated and doesn't in practice do what you need, or at least not without considerable customisation.  And money.  And formal procedures for requesting installation.  And teams of experts.  And time spent finding nothing useful about it on StackOverflow.  And restrictions born of the fact that it's shared by many people.  And downtime.

1. Larger companies, especially, tend to mandate the use of specific toolsets, and explicitly making more tools is officially naughty.  "We already have everything we need!"  Which will either be nothing or one of those bloated enterprise things.

1. Ground-up efforts to improve software delivery often see developers use tools, languages or patterns which are novel to the rest of the team, and as a result the initiative is frowned upon.

1. Conversely, when it comes to writing tools we're often suckered by convention into believing we can't use the first-class programming language we're using in our core deliverables.

1. When we're done writing our tools, there might not be anywhere acceptable to host or distribute whatever we've written, and so it won't get used and can't be promoted.

1. Finally, some of us give the whole 'invent what you need' principle a bad name because in the past we've applied it for the wrong reasons, preferring to solve an easier, more interesting and mostly unrelated problem rather than the one our clients care about and are paying us for.


.....


Once you start thinking like this, the ideas pile on thick and fast.  In a way, that's another reason why I've failed in the past to take the first step, because by the time I steel myself up to it, the first step looks decidedly drab compared to the grandiose vision in my head, and it all seems unachievable.  "Time travel!  Fantastic!  Oh, wait - what shall I use for the UI?"  Once I realise my first step can't get me straightaway to something like [Brett Victor](http://worrydream.com/)'s [round-tripping](https://vimeo.com/36579366) [code editor](https://www.youtube.com/watch?v=PUv66718DII), I give up then and there.

So let's come back down to reality.  The first few steps to giving ourselves a tool like the one I've described ought to be really simple.  If we give ourselves permission we'll see more and more opportunities for improvement using the skills we already have at our fingertips.  And that is the most motivating thing about delivering software: making a useful difference more quickly than last time, getting to powerful and interesting levels of abstraction, and giving yourself more time to think.