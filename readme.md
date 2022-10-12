This repo has two functions

1. A place to keep my configs where I can easily keep them synced and deploy them

2. So others can view and use them


If you know what you're doing you could copy my environment to your own system, I would set up a new user for this in case
you end up overwriting something you'll miss later.

With your new user in the home directory you can do something like:
1. ```git glone ...
2. ```cp dots/* .
3. ```rmdir dots
4. ```cd .scripts && ./installdeps.sh
