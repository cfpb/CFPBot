# Adding a [hubot script](https://www.npmjs.com/browse/keyword/hubot-scripts) to CFPBot

1. Fork and clone this repo to your local machine.
1. `npm install hubot-script-name --save` to add it to package.json.
1. Add the script to `external-scripts.json`.
1. Open a PR to merge the change into this repo.

# Writing a new hubot script for CFPBot

```
mkdir ~/projects/hubot-really-awesome-script # Don't touch CFPBot, create a fresh directory elsewhere
cd ~/projects/hubot-really-awesome-script
npm install --global yo generator-hubot-script-mocha
yo hubot-script-mocha
```

Follow the prompts to create some [boilerplate](https://github.com/catops/generator-hubot-script-mocha).
After the generator finishes, run `npm test` to ensure the boilerplate's tests run A-OK.
Open `src/really-awesome-script.coffee` and inspect how the script [hears and responds](https://hubot.github.com/docs/scripting/#hearing-and-responding) to messages.

Now let's load the script into CFPBot and test it out.

```
cd ~/projects/hubot-really-awesome-script
npm link # This will create a symlink pointing to your new experimental hubot script
git clone git@github.com:cfpb/CFPBot.git ~/projects/CFPBot # Pull down the bot if you haven't already
cd ~/projects/CFPBot
npm link hubot-really-awesome-script # Tell the bot to look for your new symlink
open external-scripts.json # Add `hubot-really-awesome-script` to this array.
npm start
```

The bot will start up and show all sorts of log messages.
After it's calmed down, hit enter a few times to clear the command prompt.
The bot has started in "shell mode".
It's used to test commands without having to connect the bot to a live chat server.
Try typing `cfpbot help`. It should list all the available commands.

If you open your previous `really-awesome-script.coffee` file you'll see:

```
robot.respond /hello/, (res) ->
  res.reply "hello!"
```

Try typing `cfpbot hello` and I bet you can guess how the bot will respond!
Edit your script's code so that it responds with "hai!" instead of "hello!".
Restart CFPBot by hitting `ctrl + c` and then `npm start` again.
It should now respond with "hai!" when you type `cfpbot hello`.
Edit your script. Rinse and repeat.

## Publishing your script to npm

When your script is ready for production, unlink it and publish it to npm.

```
cd ~/projects/CFPBot
npm unlink hubot-really-awesome-script
cd ~/projects/hubot-really-awesome-script
npm publish
```

You'll need an [npm account](https://www.npmjs.com/) to publish an node module.
You'll also want to create a GitHub repository for your code and push it up there.
Once it's in npm, you can follow the standard "Adding a hubot script to CFPBot" directions above.
