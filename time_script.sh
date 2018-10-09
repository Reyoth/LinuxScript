#!/bin/bash
echo "UTC=no" >> /etc/default/rcS && timedatectl set-local-rtc 1
