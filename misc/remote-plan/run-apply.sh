#!/bin/bash

APPLY_OUT_FILE="apply-out.txt"

function checkApplyOutput {
  ERRORS=`grep -c 'Apply not allowed for workspaces with a VCS connection' $APPLY_OUT_FILE`
  if [ "$ERRORS" -eq "0" ]; then echo "plan failed" 1>&2 && exit 1; fi
}

echo "test apply failure"
terraform -chdir='./local-run' apply > $APPLY_OUT_FILE || echo "apply failed as excpected. checking reason..."
checkApplyOutput

echo "test destroy failure"
terraform -chdir='./local-run' destroy > $APPLY_OUT_FILE || echo "destroy failed as excpected. checking reason..."
checkApplyOutput



