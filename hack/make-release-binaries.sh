#!/bin/bash

set -eux

VERSION="${1}"

cp _out/httpserve httpserve-${VERSION}-linux-amd64
gzip httpserve-${VERSION}-linux-amd64
