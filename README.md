# CFPBot

CFPB's internal chat bot built on [Hubot](http://hubot.github.com).

## Installation

1. `git clone https://github.com/cfpb/CFPBot.git`
1. `cd CFPBot`
1. `cp .env.sample .env`
1. Edit `.env` appropriately.
1. `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.2/install.sh | bash`
1. `nvm install 0.10`
1. `nvm use 0.10`
1. `npm i -g forever`
1. `forever -c /bin/sh ./start.sh`

## Contributing

Please read our general [contributing guidelines](CONTRIBUTING.md). To add functionality to CFPBot, first check the [hubot-scripts](https://github.com/github/hubot-scripts#hubot-scripts) organization for community-created scripts. These scripts can be loaded by adding their filename to [hubot-scripts.json](hubot-scripts.json).

If you wish to write new scripts, fork this repo and add them to the `scripts` directory. Submit a pull request and they will be reviewed. If a new script requires environment variables, please make note of them in our internal documentation.

**IMPORTANT:** All git commits to this repo should have messages consisting of a single [emoji code](http://www.emoji-cheat-sheet.com/). Please select an emoji that is most applicable to the edits you have made to the codebase. PRs that fail to comply with this request will be rejected.

### Running CFPBot Locally

You can test your hubot by running the following, however some plugins will not
behave as expected unless the [environment variables](#configuration) they rely
upon have been set.

You can start CFPBot locally by running:

    % bin/hubot

You'll see some start up output and a prompt:

    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    CFPBot>

Then you can interact with CFPBot by typing `CFPBot help`.

    CFPBot> CFPBot help
    CFPBot animate me <query> - The same thing as `image me`, except adds [snip]
    CFPBot help - Displays all of the help commands that CFPBot knows about.
    ...

### Configuration

A few scripts (including some installed by default) require environment
variables to be set as a simple form of configuration.

Each script should have a commented header which contains a "Configuration"
section that explains which values it requires to be placed in which variable.
When you have lots of scripts installed this process can be quite labor
intensive. The following shell command can be used as a stop gap until an
easier way to do this has been implemented.

    grep -o 'hubot-[a-z0-9_-]\+' external-scripts.json | \
      xargs -n1 -i sh -c 'sed -n "/^# Configuration/,/^#$/ s/^/{} /p" \
          $(find node_modules/{}/ -name "*.coffee")' | \
        awk -F '#' '{ printf "%-25s %s\n", $1, $2 }'

How to set environment variables will be specific to your operating system.
Rather than recreate the various methods and best practices in achieving this,
it's suggested that you search for a dedicated guide focused on your OS.

### Scripting

An example script is included at `scripts/example.coffee`, so check it out to
get started, along with the [Scripting Guide](scripting-docs).

For many common tasks, there's a good chance someone has already one to do just
the thing.

[scripting-docs]: https://github.com/github/hubot/blob/master/docs/scripting.md

### external-scripts

There will inevitably be functionality that everyone will want. Instead of
writing it yourself, you can use existing plugins.

Hubot is able to load plugins from third-party `npm` packages. This is the
recommended way to add functionality to your hubot. You can get a list of
available hubot plugins on [npmjs.com](npmjs) or by using `npm search`:

    % npm search hubot-scripts panda
    NAME             DESCRIPTION                        AUTHOR DATE       VERSION KEYWORDS
    hubot-pandapanda a hubot script for panda responses =missu 2014-11-30 0.9.2   hubot hubot-scripts panda
    ...


To use a package, check the package's documentation, but in general it is:

1. Use `npm install --save` to add the package to `package.json` and install it
2. Add the package name to `external-scripts.json` as a double quoted string

You can review `external-scripts.json` to see what is included by default.

##### Advanced Usage

It is also possible to define `external-scripts.json` as an object to
explicitly specify which scripts from a package should be included. The example
below, for example, will only activate two of the six available scripts inside
the `hubot-fun` plugin, but all four of those in `hubot-auto-deploy`.

```json
{
  "hubot-fun": [
    "crazy",
    "thanks"
  ],
  "hubot-auto-deploy": "*"
}
```

**Be aware that not all plugins support this usage and will typically fallback
to including all scripts.**

[npmjs]: https://www.npmjs.com

### hubot-scripts

Before hubot plugin packages were adopted, most plugins were held in the
[hubot-scripts][hubot-scripts] package. Some of these plugins have yet to be
migrated to their own packages. They can still be used but the setup is a bit
different.

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo.

[hubot-scripts]: https://github.com/github/hubot-scripts

## Open source licensing info

1. [TERMS](TERMS.md)
2. [LICENSE](LICENSE)
3. [CFPB Source Code Policy](https://github.com/cfpb/source-code-policy/)

## Credits and references

1. Projects that inspired you
2. Related projects
3. Books, papers, talks, or other sources that have meaniginful impact or influence on this project