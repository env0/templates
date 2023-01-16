#!/bin/bash

APPLY_OUT_FILE="apply-out.txt"

function checkApplyOutput () {
  status=$1
  if [ "$status" -eq "0" ]; then
    echo "Apply succeeded instead of failing"
    exit 1
  fi
  ERRORS=`grep -c 'Apply not allowed for workspaces with a VCS connection' $APPLY_OUT_FILE`
  if [ "$ERRORS" -eq "0" ]; then echo "plan failed" 1>&2 && exit 1; fi
}

echo "test apply failure"
status="0"
terraform -chdir='./local-run' apply 2> $APPLY_OUT_FILE || status="1"
checkApplyOutput $status

echo "test destroy failure"
status="0"
terraform -chdir='./local-run' destroy 2> $APPLY_OUT_FILE || status="1"
checkApplyOutput $status



