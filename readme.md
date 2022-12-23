# You're gonna love my nux (really)
This repo has two functions:

1. A place to keep my configs where I can easily keep them synced and deploy them

2. So others can view and use them

If you know what you're doing you could copy my environment to your own system to try it, I would set up a new user for this in case
you end up overwriting something you'll miss later.

As your new user in your new user's home directory you can do something like:
1. ``git clone...``
2. ``cp DeezNux/* .``
3. ``rmdir DeezNux``
4. ``.scripts/installdeps``

Some packages are probably missing from the install script, also it assumes you use [yay](https://github.com/Jguer/yay)
