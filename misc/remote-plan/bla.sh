#!/bin/bash
{ # try

    terraform apply &&
    #save your output

} || { # catch
    # save log for exception 
}
