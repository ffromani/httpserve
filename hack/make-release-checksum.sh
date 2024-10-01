#!/bin/bash

set -eux

VERSION="${1}"
FILES="
httpserve-${VERSION}-linux-amd64.gz
"

for artifact in $FILES; do
	if [ ! -f "${artifact}" ]; then
		echo "MISSING: ${artifact}" >&2
		exit 1
	fi
done

:> SHA256SUMS
sha256sum ${FILES} >> SHA256SUMS
