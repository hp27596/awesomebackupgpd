#!/bin/sh
ip link set dev wlp44s0 down
macchanger -r wlp44s0
ip link set dev wlp44s0 up
