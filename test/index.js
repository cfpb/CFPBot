var request = require('request'),
    msg = process.env.TRAVIS_COMMIT_MSG;

function isAnEmoji(emoji) {
  return msg && emoji.aliases.indexOf(msg.replace(/\:/g,'')) > -1;
}

request('https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json', function (error, response, emojis) {
  if (!error && response.statusCode == 200 && JSON.parse(emojis).some(isAnEmoji)) {
    process.exit(0);
  } else {
    if (error) {
      console.log(error);
    }
    console.error('Commit message is not a single emoji!');
    process.exit(1);
  }
});
