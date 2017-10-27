# CFPBot [![Build Status](https://travis-ci.org/cfpb/CFPBot.svg)](https://travis-ci.org/cfpb/CFPBot)

CFPB's internal chat bot built on [Hubot](http://hubot.github.com).

## Installation (Docker-less)

1. Install [Node.js](https://nodejs.org) (v4 or greater).
1. Install and start [Redis](http://redis.io/).
1. Clone this repo.
1. `cp .env.sample .env`
1. Edit `.env` appropriately.
1. `npm start`.

See [INSTALL](INSTALL.md) for complete installation steps.

## Installation using Docker

1. Clone this repo.
1. `cp .env.sample .env`
1. Add `export REDIS_URL="redis://redis:6379"` to the end of `.env`
1. Add or modify any other settings in `.env`
1. Run `docker-compose up -d`
1. Run `docker-compose run cfpbot start`

## Contributing

**IMPORTANT:** All git commits to this repo should have messages consisting of a single [emoji code](http://www.emoji-cheat-sheet.com/). 
Please select an emoji that is most applicable to the edits you have made to the codebase.
PRs that fail to comply with this request will be rejected.

Please read our [contributing guidelines](CONTRIBUTING.md) to learn how to add functionality to CFPBot.

## Open source licensing info

1. [TERMS](TERMS.md)
2. [LICENSE](LICENSE)
3. [CFPB Source Code Policy](https://github.com/cfpb/source-code-policy/)
