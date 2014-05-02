###ComFreeze ZED

(Z)ero (E)nergy (D)ocker

This is just some basic helpers scripts you can deploy in a system to help launch a bunch of docker containers on a standard base with some simple access to advanced features.

---

###Installing globally

If you're user's bin directory isn't already in your path, add it:

```
export PATH=~/bin:$PATH
```

ZED should identity where it lives no matter where you put it, so it'll find it's own scripts, just symlink the primary access script to whatever name you like:

```
ln -s ~/Downloads/zed ~/bin/zed
```

Or if you prefer another name:

```
ln -s ~/Downloads/zed ~/bin/purple-people-eater
```

---

###Getting started

To get started using ZED, make sure you're in a shell in a directory with a '''Dockerfile''' and '''config''' file.

(DEFINE CONSTANTS HERE FOR REFERENCE)

For more information once running, use '''''zed --help''''' for runtime information.

