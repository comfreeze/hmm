###ComFreeze HMM

(H)eadworks (M)achination (M)amagement

This is just some basic helpers scripts you can deploy in a system to help launch a bunch of docker containers on a standard base with some simple access to advanced features.

---

###Installing globally

If you're user's bin directory isn't already in your path, add it:

```
export PATH=~/bin:$PATH
```

HMM should identity where it lives no matter where you put it, so it'll find it's own scripts, just symlink the primary access script to whatever name you like:

```
ln -s ~/Downloads/hmm ~/bin/hmm
```

Or if you prefer another name:

```
ln -s ~/Downloads/hmm ~/bin/purple-people-eater
```

---

###Getting started

To get started using HMM, make sure you're in a shell in a directory with a '''Dockerfile''' and '''config''' file.

* REGISTRY   | Home registry to manage this configs images (ie. docker.org)
* BASE       | Base image name in the registry (ie. ubuntu)
* BRANCH     | Branch name from base image (ie. 14.04)
* ENV_VARS   | Environment variables to inject (ie. -f ENV=dev)
* VOLUMES    | Volumes to link/mount (ie. -v /home/me/stuff:/inside/dir)
* PORTS      | Ports to forward/manage (ie. -p 8181:80)

For more information once running, use '''''hmm --help''''' for runtime information.