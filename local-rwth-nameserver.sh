#!/bin/sh
# Adapted from: https://unix.stackexchange.com/a/467018

# DNS nameservers that are written to /etc/resolv.conf.
# However, the vpnc script only writes the INTERNAL_IP4_DNS servers to
# /etc/resolv.conf. Thus, also the IPv6 nameservers should be included there.

export INTERNAL_IP6_DNS="::1";
export INTERNAL_IP4_DNS="${INTERNAL_IP6_DNS} 127.0.0.1 134.130.4.1 134.130.5.1";

# Source the legacy vpnc script for applying the custom DNS configuration.
# Since openconnect v8.10, the legacy vpnc script is no longer provided by
# openconnect. Adjust VPNC_SCRIPT according to your configuration.

# VPNC_SCRIPT=/etc/openconnect/openconnect.sh # OpenConnect <= v8.9
VPNC_SCRIPT=/etc/vpnc/vpnc-script # OpenConnect >= v8.10

. ${VPNC_SCRIPT}

