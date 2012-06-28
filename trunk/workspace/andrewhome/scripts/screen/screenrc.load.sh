#!/bin/bash
cat /proc/loadavg | awk '{printf $1}'
