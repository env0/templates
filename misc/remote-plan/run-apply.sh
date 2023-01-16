#!/bin/bash

APPLY_OUT_FILE="apply-out.txt"

function checkApplyOutput () {
  status=$1
  echo "status $status"
  if [ "$status" -eq "0" ]; then
    echo "Apply succeeding instead of failing"
    exit 1
  fi
  ERRORS=`grep -c 'Apply not allowed for workspaces with a VCS connection' $APPLY_OUT_FILE`
  if [ "$ERRORS" -eq "0" ]; then echo "Apply failed fo a reason other than VCS" 1>&2 && exit 1; fi
}

echo "testing apply failure"
status="0"
terraform -chdir='./local-run' apply 2> $APPLY_OUT_FILE || status="1"
checkApplyOutput $status

echo "testing destroy failure"
status="0"
terraform -chdir='./local-run' destroy 2> $APPLY_OUT_FILE || status="1"
checkApplyOutput $status



