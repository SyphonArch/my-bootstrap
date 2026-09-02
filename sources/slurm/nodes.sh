#!/bin/bash

# Applies when: The machine is a Slurm node with sinfo and scontrol available.

# !!! BOOTSTRAP_RESOLVE_BEGIN: SLURM_PARTITION !!!
partition="<SLURM_PARTITION>"
# !!! BOOTSTRAP_RESOLVE_END: SLURM_PARTITION !!!

for n in $(sinfo -p "$partition" -h -N -o "%N"); do
  cfg=$(scontrol show node "$n" | sed -n 's/.*CfgTRES=.*gres\/gpu=\([0-9]*\).*/\1/p')
  alloc=$(scontrol show node "$n" | sed -n 's/.*AllocTRES=.*gres\/gpu=\([0-9]*\).*/\1/p')
  alloc=${alloc:-0}
  [ -n "$cfg" ] && [ "$cfg" -gt "$alloc" ] && \
    printf "%-12s free=%d / %d\n" "$n" "$((cfg-alloc))" "$cfg"
done
