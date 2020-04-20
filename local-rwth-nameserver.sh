#!/bin/sh
# Adapted from: https://unix.stackexchange.com/a/467018

# DNS nameservers that are written to /etc/resolv.conf.
# However, the vpnc script only writes the INTERNAL_IP4_DNS servers to
# /etc/resolv.conf. Thus, also the IPv6 nameservers should be included here.
export INTERNAL_IP4_DNS="::1 127.0.0.1 134.130.4.1 134.130.5.1";
export INTERNAL_IP6_DNS="::1";

# Sourcing the "legacy" vpnc script. May be altered to your configuration.
. /etc/openconnect/openconnect.sh
