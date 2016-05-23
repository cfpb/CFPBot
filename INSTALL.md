## Installation (Mac OS X)

### Install a modern version of Node.js

1. `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.2/install.sh | bash`
1. `nvm install 4`
1. `nvm use 4`
1. `nvm alias default 4`

### Install Redis

1. `brew install redis`
1. Start redis with `redis-server`

### Install CFPBot

1. `git clone https://github.com/cfpb/CFPBot.git`
1. `cd CFPBot`
1. `cp .env.sample .env`
1. Edit `.env` appropriately.

## Installation (CentOS)

### Install Node.js

1. `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash`
1. `source ~/.bashrc`
1. `nvm install 5`

### Install Redis on your CentOS machine

1. `sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`
1. `sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm`
1. `sudo yum -y --enablerepo=remi,remi-test install redis git`
1. `sudo chkconfig --add redis`
1. `sudo chkconfig --level 345 redis on`
1. `sudo service redis start`

### Install CFPBot

1. `git clone https://github.com/cfpb/CFPBot.git`
1. `cd CFPBot`
1. `cp .env.sample .env`
1. Edit `.env` appropriately.

## Running CFPBot locally

Run `npm start` to start the bot.
It will not attempt connect to our live chat server unless `HUBOT_PRODUCTION` is set to `true`.

Some plugins require environment variables to be set and may not behave as expected.
Try `curl -O https://[secret-internal-repo]/.env` to pull down CFPB's `.env` file with all our secrets in it.

You'll see some start up output and a prompt:

    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    CFPBot>

Then you can interact with CFPBot by typing `cfpbot help`.

    cfpbot> cfpbot help
    cfpbot animate me <query> - The same thing as `image me`, except adds [snip]
    cfpbot help - Displays all of the help commands that cfpbot knows about.
    ...

### Scripting

Check out Hubot's [scripting guide](scripting-docs) to learn how to write plugins for Hubot.
Feel free to reach out to folks in the `FooBar` chat room for guidance.

[scripting-docs]: https://github.com/github/hubot/blob/master/docs/scripting.md
