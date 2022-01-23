terraform show -json .tf-plan | jq --sort-keys '.planned_values' > plan.json
terraform show -json | jq --sort-keys '.values' > state.json

DIFFERENCE=$(diff plan.json state.json)

if [[ -z "${DIFFERENCE}" ]]; then
  echo "No changes in terraform plan"
else
  __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  source "${__dir}"/slack.sh "Found changes in terraform plan"
fi