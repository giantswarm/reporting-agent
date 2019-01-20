#!/bin/bash

echo "Retrieving resources..."
echo "Types: ${RESOURCE_TYPES}"

SUFFIX=$(date +'%d-%m-%Y')
kubectl get --all-namespaces --export --output=json "${RESOURCE_TYPES}" | jq -c '.items[]' | while IFS= read -r line; do
  echo "${line}" | curl \
    --insecure --basic --ssl-reqd \
    --request POST --header 'Content-Type: application/json' \
    --data @- "${ELASTICSEARCH_INDEX_URL}-${SUFFIX}/_doc" \
      | jq '.'
  echo
done