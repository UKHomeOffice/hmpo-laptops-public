#!/bin/bash
GIT_HOST="gitlab.com.hmpo.net"
GIT_TEAM="hmpo-dsst"
GIT_REPO="ansible-laptops"
WORKING_DIR="/home/ansible/"
GIT_WORKING_DIR=${WORKING_DIR}${GIT_REPO}
GIT_URL="https://${GIT_HOST}/${GIT_TEAM}/${GIT_REPO}.git"

echo "**** Starting $0 at $(date --iso-8601='seconds')"

################################
## IF "ONLINE" GIT PULL/CLONE ##
################################
echo "**** Checking network with host ${GIT_HOST}"
if host ${GIT_HOST}; then
  echo "**** DNS for ${GIT_HOST} online"
  echo "**** Running https_proxy=http://proxy-l:3128 GIT_SSL_NO_VERIFY=false git -C ${GIT_WORKING_DIR} pull"
  if https_proxy=http://proxy-l:3128 GIT_SSL_NO_VERIFY=false git -C "${GIT_WORKING_DIR}" pull; then
    echo "**** Pull successful in ${GIT_WORKING_DIR}"
  else
    echo "**** Pull failed in ${GIT_WORKING_DIR}, trying to clone instead"
    if https_proxy=http://proxy-l:3128 GIT_SSL_NO_VERIFY=false git clone "${GIT_URL}" "${GIT_WORKING_DIR}"; then
      echo "**** Clone successful for ${GIT_URL}"
    else
      echo "**** Clone failed for ${GIT_URL}"
    fi 
  fi 
else
  echo "**** DNS for ${GIT_HOST} unreachable"
fi
##########################
## RUN ANSIBLE-PLAYBOOK ##
##########################
echo "**** Running ansible-playbook ${GIT_WORKING_DIR}/site.yml -l localhost"
if ansible-playbook ${GIT_WORKING_DIR}/site.yml -l localhost; then
  echo "**** Playbook successful"
else
  echo "**** Playbook failed"
fi

echo "**** Completed $0 at $(date --iso-8601='seconds')"
echo
