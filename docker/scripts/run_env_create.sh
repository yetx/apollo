#!/usr/bin/env bash

###############################################################################
# Copyright 2017 The Apollo Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

set -x

TIME=$(date  +%Y%m%d_%H%M)

if [ -z "${DOCKER_REPO}" ]; then
    DOCKER_REPO=apolloauto/internal
fi

APOLLO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
TAG="run-env-${TIME}"

# Build image from APOLLO_ROOT, while use the specified Dockerfile.
docker build -t "${DOCKER_REPO}:${TAG}" \
    -f "${APOLLO_ROOT}/docker/run_env.dockerfile" \
    "${APOLLO_ROOT}"

sed -i "s/run-env.*\"/${TAG}\"/g" ${APOLLO_ROOT}/apollo_docker.sh
