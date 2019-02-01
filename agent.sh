#!/bin/ash

echo "Retrieving resources..."
echo "Types: ${RESOURCE_TYPES}"

SUFFIX=$(date +'%Y-%m-%d')
kubectl get --all-namespaces --export --output=json "${RESOURCE_TYPES}" | \
  jq -c '.items[]' | \
  jq -c --arg cluster "${CLUSTER}" '.metadata.cluster = $cluster' | \
  while IFS= read -r line; do
  echo "${line}" | curl \
    --insecure --basic --ssl-reqd \
    --request POST --header 'Content-Type: application/json' \
    --data @- "${ELASTICSEARCH_INDEX_URL}-${SUFFIX}/_doc" \
      | jq '.'
  echo
done
