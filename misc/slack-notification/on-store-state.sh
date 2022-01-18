#!/usr/bin/env bash

terraform show -json .tf-plan


echo "====="

terraform show -json