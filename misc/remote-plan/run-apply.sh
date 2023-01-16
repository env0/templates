#!/bin/bash
set -e

APPLY_OUT_FILE="apply-out.txt"

function checkApplyOutput {
  ERRORS=`grep -c 'Apply not allowed for workspaces with a VCS connection' $APPLY_OUT_FILE`
  if [ "$ERRORS" -eq "0" ]; then echo "plan failed" 1>&2 && exit 1; fi
}

terraform -chdir='./local-run' init >> $APPLY_OUT_FILE || checkApplyOutput

