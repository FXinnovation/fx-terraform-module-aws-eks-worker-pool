#!/bin/bash
set -o xtrace
${customized_commands}
/etc/eks/bootstrap.sh --use-max-pods '${use_max_pods}' ${bootstrap_arguments} '${cluster_name}'
