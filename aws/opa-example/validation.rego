package terraform.validation

import data.terraform.library as lib

default allow = false

violations[msg] {
  no_open_cidr_blocks[msg]
}

no_open_cidr_blocks[msg] {
  open_cidr := "0.0.0.0/0"
  cidr_blocks := lib.resources[r].values.ingress[x].cidr_blocks
  lib.list_contains_value(cidr_blocks, open_cidr)
  msg = sprintf("No security groups should be open to all IP addresses. Resource in violation: %v",[r.address])
}

allow {
  count(violations) == 0
}
