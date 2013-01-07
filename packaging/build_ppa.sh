#!/bin/sh

set -e

cd `dirname "$0"`/..

. "$HOME/.devscripts"

DEBIAN_CHANGELOG=$PWD/packaging/debian/changelog
PPA_CHANGELOG=$PWD/packaging/ubuntu/changelog

latest=`head -n 1 "$DEBIAN_CHANGELOG" | sed -e 's#(\([^)]*\))#(\1ppa1)#; s#UNRELEASED#precise#'`
cat - "$DEBIAN_CHANGELOG" > "$PPA_CHANGELOG" <<_CHANGELOG
$latest

  * Customized debian/ for ubuntu launchpad ppa.

 -- $DEBFULLNAME <$DEBMAIL>  $(date -R)

_CHANGELOG

DISTRIBUTION=ubuntu
DEBIAN_FILES_EXTRA=$PWD/packaging/ubuntu
DEBUILD_ARGS="-S"
. packaging/build_deb.sh

rm -f "$PPA_CHANGELOG"

#dput solaar-ppa solaar_*_source.changes
