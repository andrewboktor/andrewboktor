#!/bin/bash
for i in 0 1 2 3; do sudo cpufreq-set -c $i -g conservative --max 2.1GHz; done
