## Overview

This is the content for reubenpeeris.github.io and www.reubenpeeris.com

This site is generated using jekyll. GitHub pages supports jekyll, but only supports a very limited number of plugins. In order to use unsupported plugins, this site needs to be generated manually.

In this repository there are 3 types of branch:

  1. master
    + content can be accessed using the above URLs.
    + contains generated files (e.g. .html, .css etc)
    + *should only be committed to by the `_bin/deploy` script*
  2. jekyll
    + contains input files (e.g. _config.yml, .md etc)
    + contains the `_bin/deploy` script
  3. feature branches
    + used just like feature branches in typical repositories
    + typically based on the jekyll branch
    + when work is complete will be merged back into the jekyll branch

When work has been completed, it should be committed to the jekyll branch and pushed to GitHub. Then the `_bin/deploy` script should be run, which will:

  1. build the website
  2. commit the content to the master branch
  3. push the changes to GitHub

## Build-machine install

To build this website will require a number of tools to be installed:

```
sudo aptitude install ruby ruby-dev
sudo gem install jekyll
sudo gem install jekyll-gist
```
