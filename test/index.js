var request = require('request'),
    open = require('nodegit').Repository.open,
    emojis;

function isAnEmoji(msg) {
  return JSON.parse(emojis).some(function(emoji) {
    return msg && emoji.aliases.indexOf(msg.replace(/\:/g,'')) > -1;
  });
}

function processEmojis(error, response, body) {
  emojis = body;

  // Open the repository directory.
  open('./')
    // Open the current branch.
    .then(function(repo) {
      return repo.getHeadCommit();
    })
    // Display information about commits.
    .then(function(firstCommitOnMaster) {
      // Create a new history event emitter.
      var history = firstCommitOnMaster.history();

      // Listen for commit events from the history.
      history.on('commit', function(commit) {

        var msg = commit.summary(),
            isAMerge = msg.toLowerCase().indexOf('merge') > -1;

        if (error || response.statusCode != 200 || (!isAMerge && !isAnEmoji(msg))) {
          if (error) {
            console.log(error);
          }
          msg = 'Error! Commit ' +
                commit.sha() +
                ' by ' +
                commit.author() +
                ' on ' +
                commit.date() + 
                ' is not an emoji. >:| The commit message is "' +
                msg +
                '".';
          console.error(msg);
          process.exit(1);
        } else if (isAMerge) {
          console.log('✓ Commit ' + commit.sha().substring(0, 8) + ' ignored because it\'s merging a PR.');
        } else {
          console.log('✓ Commit ' + commit.sha().substring(0, 8) + ' passes: "' + msg + '" is a valid GitHub emoji.');
        }

      });

      // Start emitting events.
      history.start();
    });

};

request('https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json', processEmojis);
