---
title : Clojure for an experienced Java developer
tags : clojure
---

_I'd promised a friend at work that I would put together a few suggestions for learning Clojure, and here they are.  He has masses of experience developing in other languages - mostly Java - and is a deep and quick thinker.  We've already talked a bit about Clojure and he's seen some in action, but is otherwise new to the language and its ecosystem._

# Build tool

For a build and dependency management tool, let's go with Leiningen for now, since it's pretty much the standard.  One of the nice things about the Clojure ecosystem is that questioning the _status quo_ is the norm, so don't worry that you'll become the equivalent of a Mavenite. 

# Clojure version

The latest stable Clojure is at version 1.8.  You specify it just like any other project dependency, in Leiningen's `project.clj` file.

# Tools

## Cursive

You've got Cursive installed, and you have access to an ordinary Leiningen REPL (via `lein repl`).  That should be enough.  We've talked about Emacs, and I gather that for you as for me it wouldn't be helpful go down that road at the moment.

Cursive has 3 editing modes: plain, paredit, and parinfer.  The last of these is new to the most recent version of Cursive.  The mode's shown at the very bottom right of IntelliJ.  I'd use paredit for minimum surprises and maximum usefulness.

You should probably get to grips fairly early on with the interplay between source code 'in' a project and what the REPL is evaluating, just so you can quickly get out into the clear waters of guided experimentation and even productivity.  In the early days you'll inevitably end up being puzzled about why a change hasn't 'taken' or why you can't evaluate something.  Get used to the Cursive keyboard shortcuts, or at least menu options, for 'load this file in REPL' and friends, and when you come to understanding namespaces more deeply (more below) you'll really benefit.

Off the top of my head, places to explore in IntelliJ re Cursive/Clojure: the Run menu; right-clicking on the top of the project structure; the Edit/Structural editing menu; Preferences/Keymap/Clojure Keybindings.

## REPLs in general

A REPL is in some namespace.  It has access to definitions you've evaluated in it, whether by typing them or by asking eg Cursive to evaluate some source code in the REPL context.  It has history, so up-arrow works.  For the Leiningen REPL, history is stored in the current working directory in `.lein-repl-history`; dunno about Cursive's history.  REPLs also generally have auto-complete - start typing then use tab.

There are 3 or 4 really useful REPL functions.  They're in the clojure.repl namespace.  When invoking these functions you don't start off by having to mention the name space, but depending on what you do with namespaces in your REPL session you may find you later have to specify the namespace explicitly.  So e.g.

```clj
    (doc interpose)
    (clojure.repl/doc interpose)
    (clojure.repl/source clojure.repl/source)
```

The last prints its own source code.

Of course, since you're in IntelliJ you can delve into source code in the ways you'd expect (command-click, command-b etc).

# Going deep

While you're learning Clojure and getting to grips with the fundamentals, I heartily support your natural tendency to go deep first.  Understand why the REPL prints exactly what it does; think deeply about evaluation contexts and lifecycles; and keep track of those questions which you can't solve yourself - I'd be very happy to try to answer them with you.  Since I'm not very far ahead of you, I'm sure I'd learn in the process...

There'll be two particular wrinkles to smooth over in this early phase.

## Early wrinkle 1: stack traces

You'll probably be baffled along the way by stack traces.  Both the Leiningen REPL and Cursive's will shorten exception reports.  In both cases, `*e` evaluates to the last exception met.  If you want grab hold of that to take a look,   `(def bla *e)`   then you've got `bla`, without worrying about `*e` being overwritten by your next experiment.  Cursive will pretty-print a useful representation of exceptions when you evaluate them - you could try that out early on:

```clj
    wibble
    ; Cursive reports "huh?" as an exception.  Save the last one:
    (def bla *e)

    ; Now evaluate the exception you've captured, and take a look
    bla
```

There are libraries for colorising stack traces, rolling them up etc etc, making them more expressive - but they can wait and are a matter of personal preference.  The're just JVM exceptions, at the end of the day.  Leave that kind of thing til you're trying to be fluent and uber-productive.

## Early wrinkle 2: namespaces

Namespaces are hierarchical contexts in which symbols live.

For all that Clojure champions statelessness, where namespaces are concerned the evaluation context (of source code being compiled, of evaluations you request in a REPL) is very stateful indeed.

You are always 'in' some namespace, whether you're at some point in time in your use of a REPL or you are the Clojure reader going through the process of compiling a source code file.  You can change the namespace you're in, at any point.  Swapping in and out of namespaces is generally something you'd only do in REPL contexts - in source code files, you generally declare the namespace stuff at the top and that's that.

Before you can refer to symbols in a namespace, you have to load (read and evaluate and compile) a source containing those symbols defined in that namespace.  The source generally has to be on the classpath, which is defined by your build tool (more often than not, Leiningen).

You can almost always refer to a symbol by fully qualifying it using its namespace, provided that you've loaded the corresponding source.

Multiple source files/locations can contribute symbols to the same namespace, or even to different namespaces - but the convention is generally one file = one namespace = all of the symbols in that namespace.

When you declare the namespace of a source file, you generally use the `ns` macro, and it's that you should focus on understanding.  At any rate and however you do it, in source files you declare which namespace you're in and also say what other namespaces your source uses and how you'd like to refer to them.  The choices you make here are yours, and are all about brevity/expressivity.   If you use only one function from a foreign namespace, and use it only once, you might as well fully qualify it.  If you use a foreign function a lot, you'll probably want to (use the ns macro or some other mechanism to) alias its namespace or do away with having to mention it at all... unless the function name clashes with another.

Namespaces are initially one of the most confusing things about Clojure, for several reasons:

* there are several ways of doing the same thing
* `ns` is a macro which therefore doesn't need its arguments quoted, whereas namespace-related `require`, `use`, `alias` and friends are functions whose arguments are evaluated by the time they get to them
* `ns` in particular, being a macro, is free to make use of idomatic Clojure in which keywords (`:require`, `:refer`, `:only`...) are interspersed with symbols, vectors etc in an initially baffling way

However, be reassured that everything is pretty logical, and definitely deterministic!   I suggest you let yourself run into a few difficulties to build up a desire to grok the subject, then go and read http://www.braveclojure.com/organization/ to understand it all much more deeply.  Warning: that goes into the underlying mechanism of namespace management, which you may never need to know about.  If it all gets too confusing, leave it for a while and come back to it after a bit more real-world experience.

By the way, since the namespace mechanism is by and large completely accessible to real Clojure, there's a healthy tendency for people to build tools which augment/improve/subvert the whole structure.  In other contexts this might be worrying ("Oh no!  Developers have power!  Things are bound to go wrong!") but Clojurists don't seem to be so afraid of thinking.

# A good teaching narrative: Clojure for the Brave and True

If you'd like something with a nice narrative and crystal clear explanations (and only the occasional piece of style which may not suit everybody) then I'd recommend http://www.braveclojure.com.  You have the book on your desk at work, but the online version is great - and even styled with a nice light vellum background!  This will get you a long way - beyond me atm :)  Personally I'd ignore its advice to use Emacs unless that really grabs you.

# A book for inspiration and reassurance: Clojure Cookbook

Once the number of wtf?! moments is down to a manageable level when you look at Clojure code, the best book I can recommend is the Clojure Cookbook.  Real-world problems, using real-world libraries, with succinct explanations and things you can easily try out.  Core things (joining two lists, mapping functions over things), cool things (eg core/async) plus the real messy stuff (using Lucene, stashing things in Redis, generating PDFs...).  The only downside is that it was published in 2014, but I should think all the libraries it mentions, and certainly all the patterns, are relevant.

It's available as a book/an ebook from O'Reilly via http://clojure-cookbook.com/ or Amazon etc, or in source code at https://github.com/clojure-cookbook/clojure-cookbook.

# The community

Follow [#clojure](https://twitter.com/hashtag/clojure) to a while to get a flavour of what's going on and how people in the community interact.  More at http://clojure.org/community/resources.