Writing good issue reports
==========================

First things first: **the issue tracker is NOT for tech support**. It is for
reporting bugs and requesting features. If your issue amounts to "I can't get
ycmd to work on my machine" and the reason why is obviously related to your
machine configuration and the problem would not be resolved with _reasonable_
changes to the ycmd codebase, then the issue is likely to be closed.

**A good place to ask questions is the [ycmd-users][] Google group**. Rule of
thumb: if you're not sure whether your problem is a real bug, ask on the group.

**ycmd compiles just fine**; [the build bots say so][build-bots]. If the bots are
green and ycmd doesn't compile on your machine, then _your machine is the root
cause_. Now read the first paragraph again.

Realize that quite literally _thousands_ of people have gotten ycmd to work
successfully so if you can't, it's probably because you have a peculiar
system/Vim configuration or you didn't go through the docs carefully enough.
It's very unlikely to be caused by an actual bug in ycmd because someone would
have already found it and reported it.

This leads us to point #2: **make sure you have checked the docs before
reporting an issue**. The docs are extensive and cover a ton of things; there's
also an FAQ at the bottom that quite possibly addresses your problem.

Further, **search the issue tracker for similar issues** before creating a new
one. There's no point in duplication; if an existing issue addresses your
problem, please comment there instead of creating a duplicate.

You should also **search the archives of the [ycmd-users][] mailing list**.

Lastly, **make sure you are running the latest version of ycmd**. The issue you
have encountered may have already been fixed. **Don't forget to recompile
ycm_core.so too** (usually by just running `install.py` again).

OK, so we've reached this far. You need to create an issue. First realize that
the time it takes to fix your issue is a multiple of how long it takes the
developer to reproduce it. The easier it is to reproduce, the quicker it'll be
fixed.

Here are the things you should do when creating an issue:

1. **Write a step-by-step procedure that when performed repeatedly reproduces
   your issue.** If we can't reproduce the issue, then we can't fix it. It's
   that simple.
2. **Create a test case for your issue**. This is critical. Don't talk about how
   "when I have X in my file" or similar, _create a file with X in it_ and put
   the contents inside code blocks in your issue description. Try to make this
   test file _as small as possible_. Don't just paste a huge, 500 line source
   file you were editing and present that as a test. _Minimize_ the file so that
   the problem is reproduced with the smallest possible amount of test data.
3. **Include your OS and OS version.**


Creating good pull requests
===========================

1.  **Follow the code style of the existing codebase.**
    - The Python code **DOES NOT** follow PEP 8. This is not an oversight, this
      is by choice. You can dislike this as much as you want, but you still need
      to follow the existing style. Look at other Python files to see what the
      style is.
    - The C++ code has an automated formatter (`style_format.sh` that runs
      `astyle`) but it's not perfect. Again, look at the other C++ files and
      match the code style you see.

2.  **Your code needs to be well written and easy to maintain**. This is of the
    _utmost_ importance. Other people will have to maintain your code so don't
    just throw stuff against the wall until things kinda work.

3.  **Split your pull request into several smaller ones if possible.** This
    makes it easier to review your changes, which means they will be merged
    faster.

4.  **Write tests for your code**. Your pull request is unlikely to be merged
    without tests. See [TESTS.md][ycmd-tests] for instructions on running the
    tests.

5.  **Explain in detail why your pull request makes sense.** Ask yourself, would
    this feature be helpful to others? Not just a few people, but a lot of
    ycmd's users? See, good features are useful to many. If your feature is only
    useful to you and _maybe_ a couple of others, then that's not a good
    feature.  There is such a thing as ???feature overload???. When software
    accumulates so many features of which most are only useful to a handful,
    then that software has become ???bloated???. We don't want that.

    Requests for features that are obscure or are helpful to but a few, or are
    not part of ycmd's "vision" will be rejected. Yes, even if you provide a
    patch that completely implements it.

    Please include details on exactly what you would like to see, and why. The
    why is important - it's not always clear why a feature is really useful. And
    sometimes what you want can be done in a different way if the reason for the
    change is known. _What goal is your change trying to accomplish?_


Writing code that runs on Python 2 & 3
======================================

We support Python 2.7 and 3.5+. Since we use
[`python-future`][python-future], you should mostly write Python 3 as normal.
Here's what you should watch out for:

- New files should start with the following prologue after the copyright header:

    ```python
    from __future__ import absolute_import
    from __future__ import unicode_literals
    from __future__ import print_function
    from __future__ import division
    # Not installing aliases from python-future; it's unreliable and slow.
    from builtins import *  # noqa
    ```

- Write `dict(a=1, b=2)` instead of `{'a':1, 'b':2}`. `python-future` patches
  `dict()` to return a dictionary like the one from Python 3, but it can't patch
  dictionary literals. You could also create a dict with `d = dict()` and then
  use `d.update()` on it with a dict literal.
- Read the [_What Else You Need to Know_][what-else] doc from `python-future`.
- Create `bytes` objects from literals like so: `bytes( b'foo' )`. Note that
  `bytes` is patched by `python-future` on py2.
- Be careful when passing the `bytes` type from `python-future` to python
  libraries (includes the standard library) on py2; while that type should in
  theory behave just like `str` on py2, some libraries might have issues. If you
  encounter any, pass the value through `future.utils`'s `native()` function
  which will convert `bytes` to a real `str` (again, only on py2). Heed this
  advice for your own sanity; behind it are 40 hours of debugging and an
  instance of tears-down-the-cheek crying at 2 am.
- **Use the `ToBytes()` and `ToUnicode()` helper functions from
  `ycmd/utils.py`.** They work around weirdness, complexity and bugs in
  `python-future` and behave as you would expect. They're also extensively
  covered with tests.
- Use `from future.utils import iteritems`
  then `for key, value in iteritems( dict_obj )` to efficiently iterate dicts on
  py2 & py3
- Use `from future.utils import itervalues` then `for value in itervalues(
  dict_obj )` to efficiently iterate over values in dicts on py2 & py3
- `future.utils` has `PY2` and `PY3` constants that are `True` in the respective
  interpreter; be careful about checking for py3 (better to check for py2);
  don't write code that will break on py4!
- If you run tests and get failures on importing ycm_core that mention
  `initycm_core` or `PyInit_ycm_core`, you've built the C++ parts of ycmd for
  py2 and are trying to run tests in py3 (or vice-versa). Rebuild!
- Import the `urljoin` and `urlparse` functions from `ycmd/utils.py`:

    ```python
    from ycmd.utils import urljoin, urlparse
    ```


[build-bots]: https://travis-ci.org/Valloric/ycmd
[ycmd-users]: https://groups.google.com/forum/?hl=en#!forum/ycmd-users
[ycmd-tests]: https://github.com/Valloric/ycmd/blob/master/TESTS.md
[python-future]: http://python-future.org/index.html
[what-else]: http://python-future.org/what_else.html
