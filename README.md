###ComFreeze HMM

(H)eadworks (M)achination (M)amagement

This is just some basic helpers scripts you can deploy in a system to help launch a bunch of docker containers on a standard base with some simple access to advanced features.

---

###Introduction

**HMM** operates on the current directory in your shell environment.  It uses a hidden folder, expected to be relative to the primary executable entrypoint, title *.hmm*.  This folder must be reachable by **HMM** to operate properly.  If a local copy is found in the current directory, the local version will be used instead of, not in combination with, the original installation directory.

Since this directory may change over time and this README is intended to be a lazy reference, not continually updated, use the **-a** option to list available actions.

```
hmm -a
```

###Configuration

**HMM** expects it's configuration files to be named similar to *config.hmm* or *mySystemCONF.hmm* (using .hmm extension) but makes no assumptions about the actual name.  The configuration file will be searched for if not explicitly provided in the command line arguments (see --config) and my feature any filename desired (ie. --config my.conf).

The configuration file found or specified should provide values from the following table to customize as needed:

Variable      | Usage         | Example
------------- | ------------- | -------------
 REGISTRY     | Home registry to manage this configs images | docker.org
 BASE         | Base image name in the registry | ubuntu
 BRANCH       | Branch name from base image | 14.04
 ENV_VARS     | Environment variables to inject | -f ENV=dev
 VOLUMES      | Volumes to link/mount | -v /home/me/stuff:/inside/dir
 PORTS        | Ports to forward/manage | -p 8181:80

These elements are referenced through the **HMM** script system and will provide universal simplicity throughout.  To verify that your configuration file is being used, you can use the *info* option (see -i)

```
hmm -i
```

or alternatively for a custom configuration

```
hmm --config my.conf -i
```

###Core Elements

####Docker

At the heart and original inspiration of **HMM** (formerly Zero Energy Docker), docker is wrapped to ease use through configuration helpers.  Essential actions provided for the docker ecosystem are:

* build
* start
* stop
* restart
* reload
* kill

Early editions of the system relied heavily on **ssh** based containers until **nsenter** was discovered as a superior alternative to minimize resources.  To maintain broader support, a **control** feature was provided that allows all helper commands to access this method.  The **control** method itself uses a switch, manageable via command line parameters, to target preferred control type needed for each container (see -c).  Currently, only these options are supported:

* ssh
* nsenter

####Basic usage

1. Create config.hmm
2. Provide variables defined above
3. Run container (hmm reload)
4. ...

A lot of magic will happen automatically at this point to get started.  Provided the configuration is valid, docker will attempt to start the specified container/image.  If the image is not available, docker will check the specified registry and pull down the necessary layers as needed to run the request if possible or error.  Once all layers have been synced with the registry, docker will power up the container with the provided specifications and services should become accessible.

####Common usage

A frequent cycle while using the **HMM** script system is as follows:

1. Define docker specifics (Dockerfile && config.hmm)
2. Build image (hmm build)
3. Load image (hmm reload)
4. ...

In this example, **reload** is used and may throw errors on first launch which is expected.  **Reload** attempts to shut down any previously running containers under the same name, if none are found, errors will display.  After **reload** is complete, the container should be available and any services managed ready and accessible.

####Extending

Many commands provide wildcard command pass-through to allow end users to inject additional specifications at runtime.  A local .hmm directory may also be used to overwrite commands but **HMM** will only provide the commands in that directory and does not attempt to merge functionality missing when specifying custom extension libraries.

###Troubleshooting

**HMM** provides a *--verbose* option to display more information during operations if desired.

---

###Getting started

To get started using HMM, make sure you're in a shell in a directory with a '''Dockerfile''' and '''config''' file.

###More information

For more information once running, use '''''hmm --help''''' for runtime information.