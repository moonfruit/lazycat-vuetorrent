#!/usr/bin/env bash
if [[ -z "$PROXY_ENABLED" ]] && hash proxy 2>/dev/null; then
    exec proxy "$0" "$@"
fi

source "$ENV/lib/bash/github.sh"

echo " --- === Updating VueTorrent-backend === ---"
VERSION=$(find-latest-version VueTorrent vuetorrent-backend)
sed -e 's/^version:.*/version: '"$VERSION"'/;' \
    -e 's|ghcr.io/vuetorrent/vuetorrent-backend:.*|ghcr.io/vuetorrent/vuetorrent-backend:'"$VERSION"'|' \
    -i lzc-manifest.yml
echo "Using version: $VERSION"
echo

echo " --- === Updating qBittorrent === ---"
VERSION=$(find-latest-version linuxserver docker-qbittorrent)
sed -e 's|\(lscr.io/linuxserver/qbittorrent:\).*|\1'"$VERSION"'|' \
    -i lzc-manifest.yml
echo "Using version: $VERSION"
echo

echo " --- === Result === ---"
git diff lzc-manifest.yml
