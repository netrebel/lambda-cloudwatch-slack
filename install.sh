#!/bin/sh
set -e

DEPLOYMENT_ENV=${ENV-'predev'}
REGION=${REGION-'us-west-2'}
AWS_DEFAULT_PROFILE=${AWS_DEFAULT_PROFILE-'yggi-api-saml'}

npm install
make deploy