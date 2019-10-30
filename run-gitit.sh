#!/bin/bash

set -eux

cat <<END >> ./gitit.conf
oauthclientid: "$GITIT_OAUTH_CLIENT_ID"
oauthclientsecret: "$GITIT_OAUTH_CLIENT_SECRET"
END

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
