#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
#
# repoint-nf.sh <nf-dir> [<tossi-libs-version> | --local <tossi-libs-dir>]
#
# Switches an SD-Core network function (amf, smf, nrf, ...) from the
# omec-project libraries (openapi, nas, ngap, util) to Tossi-libs:
#   1. rewrites Go imports to github.com/Shiva-Marshall/Tossi-libs/<lib>
#   2. drops the four omec-project requirements from go.mod
#   3. requires Tossi-libs at the given version (default: latest tag), or
#      replaces it with a local checkout when --local is given
#   4. runs `go mod tidy` (needs Go >= 1.26)
set -euo pipefail

M=github.com/Shiva-Marshall/Tossi-libs
nf=${1:?usage: repoint-nf.sh <nf-dir> [<version> | --local <tossi-libs-dir>]}
mode=${2:-latest}
[ -f "$nf/go.mod" ] || { echo "no go.mod in $nf" >&2; exit 1; }

grep -rlIZ --include='*.go' 'github.com/omec-project/' "$nf" | xargs -0 -r sed -i \
	-e "s#github.com/omec-project/openapi/v2#$M/openapi#g" \
	-e "s#github.com/omec-project/nas/v2#$M/nas#g" \
	-e "s#github.com/omec-project/ngap/v2#$M/ngap#g" \
	-e "s#github.com/omec-project/util#$M/util#g"

sed -i -E '/^[[:space:]]*(require[[:space:]]+)?github\.com\/omec-project\/(openapi\/v2|nas\/v2|ngap\/v2|util)[[:space:]]+v/d' "$nf/go.mod"

cd "$nf"
case "$mode" in
--local)
	libs=$(cd "${3:?--local needs a path}" && pwd)
	go mod edit -require="$M@v0.0.0" -replace="$M=$libs"
	;;
latest) go get "$M@latest" ;;
*) go get "$M@$mode" ;;
esac
go mod tidy

left=$(grep -rIl --include='*.go' -e 'github.com/omec-project/\(openapi\|nas\|ngap\|util\)' . || true)
[ -z "$left" ] || { echo "still importing omec-project libraries:" >&2; echo "$left" >&2; exit 1; }
echo "repointed $(basename "$PWD") to $M"
