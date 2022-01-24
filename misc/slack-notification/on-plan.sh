DIFFERENCE=$(terraform show -json .tf-plan | jq '.resource_changes[] | select(.| .change.actions[0] != "no-op")')  

if [[ -z "${DIFFERENCE}" ]]; then
  echo "No changes in terraform plan"
else
  __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  source "${__dir}"/slack.sh "Found changes in terraform plan"
fi
