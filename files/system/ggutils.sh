#!/usr/bin/bash

ghpr () {
  echo "do PR stuff"
}

gghelm () {
  repo="$1"
  aws ecr describe-images \
  --repository-name "gg/$repo" \
  --filter 'tagStatus=TAGGED' \
  --query "reverse(sort_by(imageDetails,& imagePushedAt))" \
  --region us-east-2 \
  --profile cicd_GreenlightEngineer \
  | jq -r 'map(select(.artifactMediaType | contains("helm"))) | .[:20] | .[].imageTags[]'
}

ggrepolist () {
	gh repo list stingerlabs \
		--source --no-archived \
		--limit=500 \
		--json="name,sshUrl,url,nameWithOwner,owner,pushedAt" \
		| jq -r 'sort_by(.pushedAt) | reverse | .[] | .sshUrl'
}
