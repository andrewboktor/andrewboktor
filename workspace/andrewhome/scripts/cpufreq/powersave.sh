#!/bin/bash
for i in 0 1 2 3; do sudo cpufreq-set -c $i --governor conservative --max 1.4GHz; done
