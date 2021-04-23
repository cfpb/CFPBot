## Installation on macOS

### Install a modern version of Node.js

First, install and activate Node Version Manager, if you haven't already:
1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash`
1. `export NVM_DIR="$HOME/.nvm"`
1. `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"`

Then use NVM to install the latest long-term support release of Node:

```sh
nvm install lts/*
```

The new version should be activated for use automatically, but if not, run:

```sh
nvm use lts/*
```

### Install Redis

1. `brew install redis`
1. Start redis with `redis-server`

You can verify that it's working as expected by opening a new terminal window
and running `redis-cli ping`, which should return `PONG`.

### Install CFPBot

1. `git clone https://github.com/cfpb/CFPBot.git`
1. `cd CFPBot`
1. `cp .env.sample .env`
1. Edit `.env` appropriately.


## Installation on CentOS/RHEL 7

CFPB EC2 instances currently run RHEL 7. These instructions assume a freshly spun-up instance.

### Install Node.js

First, install and activate Node Version Manager:
1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash`
1. `export NVM_DIR="$HOME/.nvm"`
1. `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"`

Then use NVM to install the latest long-term support release of Node:

```sh
nvm install lts/*
```

The new version should be activated for use automatically, but if not, run:

```sh
nvm use lts/*
```

### Install Redis

1. `sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm`
1. `sudo rpm -ivh https://rpms.remirepo.net/enterprise/remi-release-7.rpm`
1. `sudo subscription-manager repos --enable=rhel-7-server-optional-rpms`
   - The output from this step suggests that it may not be necessary.
1. `sudo yum install -y redis --enablerepo=remi`
1. `sudo systemctl start redis`
1. `sudo systemctl enable redis`

You can verify that it's working as expected by running `systemctl status redis`,
and `redis-cli ping` should return `PONG`.

### Install CFPBot

First, install Git:

```sh
sudo yum install -y git
```

1. `git clone https://github.com/cfpb/CFPBot.git`
1. `cd CFPBot`
1. `cp .env.sample .env`
1. Edit `.env` appropriately.


## Running CFPBot

Run `npm start` to start the bot.
It will not attempt connect to our live chat server unless `HUBOT_PRODUCTION` is set to `true`.

Some plugins require environment variables to be set and may not behave as expected.
Try `curl -O https://[secret-internal-repo]/.env` to pull down CFPB's `.env` file with all our secrets in it.

You'll see some start up output and a prompt:

```
[Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
cfpbot>
```

Then you can interact with CFPBot by typing commands such as `cfpbot help`.

```
cfpbot> cfpbot help
cfpbot animate me <query> - The same thing as `image me`, except adds [snip]
cfpbot help - Displays all of the help commands that cfpbot knows about.
...
```

### Scripting

Check out Hubot's [scripting guide](scripting-docs) to learn how to write plugins for Hubot.
Feel free to reach out to folks in the `FooBar` chat room for guidance.

[scripting-docs]: https://github.com/github/hubot/blob/master/docs/scripting.md
