#!/bin/bash

set -e

REPOSITORY_NAME=$(basename "${GITHUB_REPOSITORY}")

unset JAVA_HOME

if [[ ! -f "${INPUT_PROJECTBASEDIR%/}/sonar-project.properties" ]]; then
  [[ -z "${INPUT_PROJECTKEY}" ]] && SONAR_PROJECTKEY="${REPOSITORY_NAME}" || SONAR_PROJECTKEY="${INPUT_PROJECTKEY}"
  [[ -z "${INPUT_PROJECTNAME}" ]] && SONAR_PROJECTNAME="${REPOSITORY_NAME}" || SONAR_PROJECTNAME="${INPUT_PROJECTNAME}"
  [[ -z "${INPUT_PROJECTVERSION}" ]] && SONAR_PROJECTVERSION="" || SONAR_PROJECTVERSION="${INPUT_PROJECTVERSION}"
  sonar-scanner \
    -Dsonar.host.url="${INPUT_HOST}" \
    -Dsonar.projectKey="${SONAR_PROJECTKEY}" \
    -Dsonar.projectName="${SONAR_PROJECTNAME}" \
    -Dsonar.projectVersion="${SONAR_PROJECTVERSION}" \
    -Dsonar.projectBaseDir="${INPUT_PROJECTBASEDIR}" \
    -Dsonar.token="${INPUT_LOGIN}" \
    -Dsonar.sources="${INPUT_PROJECTBASEDIR}" \
    -Dsonar.sourceEncoding="${INPUT_ENCODING}"
else
  sonar-scanner \
    -Dsonar.host.url="${INPUT_HOST}" \
    -Dsonar.token="${INPUT_LOGIN}"
fi
