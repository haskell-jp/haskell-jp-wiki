#!/bin/bash

set -eu

cat <<END >> ./gitit.conf
oauthclientid: "$GITIT_OAUTH_CLIENT_ID"
oauthclientsecret: "$GITIT_OAUTH_CLIENT_SECRET"
END

mkdir -p ~/.ssh/
chmod 0700 ~/.ssh/
echo "$DEPLOY_SSH_PRIVATE_KEY" > ~/.ssh/id_ed25519
chmod 0600 ~/.ssh/id_ed25519

if [ ! -d ./wikidata ]; then
  (
    git clone "$GITIT_GIT_URL" ./wikidata
    cd ./wikidata

    echo -e '#!/bin/sh\ngit push origin master' > .git/hooks/post-commit
    chmod +x .git/hooks/post-commit

    git config 'user.email' "$GITIT_GIT_USER_EMAIL"
    git config 'user.name' "$GITIT_GIT_USER_NAME"
  )
fi

gitit --config-file=./gitit.conf --port="$PORT"
