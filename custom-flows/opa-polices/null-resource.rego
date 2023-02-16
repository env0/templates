package resource.limit

import input as tfplan

default allow := false

allow := true {
    score < 2
}

# Consider exactly these resource types in calculations
resource_types := {"null_resource"}

score := s {
    all := [ x |
            some resource_type
            new := num_creates[resource_type];
            mod := num_modifies[resource_type];
            x := new + mod
    ]
    s := sum(all)
}

####################
# Terraform Library
####################

# list of all resources of a given type
resources[resource_type] := all {
    some resource_type
    resource_types[resource_type]
    all := [name |
        name:= tfplan.resource_changes[_]
        name.type == resource_type
    ]
}

# number of creations of resources of a given type
num_creates[resource_type] := num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    creates := [res |  res:= all[_]; res.change.actions[_] == "create"]
    num := count(creates)
}

# number of modifications to resources of a given type
num_modifies[resource_type] := num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    modifies := [res |  res:= all[_]; res.change.actions[_] == "update"]
    num := count(modifies)
}
