#!/bin/bash
for i in 0 1 2 3; do sudo cpufreq-set -c $i -g powersave --max 800MHz; done
