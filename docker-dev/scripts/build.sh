#/bin/sh
#updating dependencies
mix do deps.get, deps.compile
mix compile

cd apps/block_scout_web/assets/
npm install
npm rebuild node-sass
npm run deploy

cd /home/blockscout/src/apps/explorer
npm install
