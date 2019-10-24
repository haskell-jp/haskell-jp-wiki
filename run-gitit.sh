#!/bin/bash

set -eux

cat <<END >> ./gitit.conf
oauthclientid: "$GITIT_OAUTH_CLIENT_ID"
oauthclientsecret: "$GITIT_OAUTH_CLIENT_SECRET"
END

mkdir -p ~/.ssh/
chmod 0700 ~/.ssh/

set +x
echo "$DEPLOY_SSH_PRIVATE_KEY" > ~/.ssh/id_ed25519
set -x

chmod 0600 ~/.ssh/id_ed25519

cat <<END > ~/.ssh/known_hosts
|1|QDszvvHTErxIwgV2W78r+CpC2tY=|p1G5nsIyKz8Swg7qlKbsTp8M8V4= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|txCuojdqvICjfjY4D65ELx9DE0U=|uz3ZCM5c/PNbZ4TQpAstMYHTnC4= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
END
chmod 0600 ~/.ssh/known_hosts

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
