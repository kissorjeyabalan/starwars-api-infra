#!/bin/bash
set -e
set -x

export DIR=$( pwd )

M2_HOME="${HOME}/.m2"
M2_CACHE="${DIR}/maven"

echo "Symlinking cache"
[[ -d "${M2_CACHE}" && ! -d "${M2_HOME}" ]] && ln -s "${M2_CACHE}" "${M2_HOME}"

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${DIR}/source
mvn clean install

