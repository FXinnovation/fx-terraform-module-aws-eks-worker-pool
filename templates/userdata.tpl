#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --use-max-pods '${use_max_pods}' '${cluster_name}'
