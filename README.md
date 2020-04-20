# RWTH-VPN
Template scripts to connect to the RWTH Aachen Cisco Anyconnect VPN server on *NIX systems using openconnect
---
The latest change of the RWTH Aachen VPN infrastructure to a Cisco Anyconnect-based web-vpn service disables users of the old IPsec vpnc configuration to connect. Notwithstanding this, the RWTH provides detailed instructions how to connect to their service using GUI configuration and even provides the Cisco Anyconnect client.

However, in contrast to the vpnc configuration (available anymore!), the documentation found at the [IT-Center documentation portal](https://doc.itc.rwth-aachen.de/display/VPN) lacks information for "unexperienced" users on how to connect using an advanced non-gui configuration as well as information on how to generically set up the VPN connection on other operating systems that are not documented there, e.g. *BSD derivates etc.

These scripts assist users in setting up a connection to the RWTH Aachen Cisco Anyconnect VPN server from the terminal using [openconnect](https://www.infradead.org/openconnect/).

These scripts are included:
* `rwth-vpn-split` Connect to "Split Tunnel"
* `rwth-vpn-full` Connect to "Full Tunnel"
* `local-rwth-nameserver.sh` Controlled overwriting of `/etc/resolv.conf`. The script is adapted from a [Stack Exchange post](https://unix.stackexchange.com/a/467018) and invokes the "legacy" vpnc connection script which is used by openconnect after defining nameservers that should be located in the `resolv.conf` file to maintain a custom configuration. My local nameserver is prepended the RWTH nameservers that should still be used upon a VPN connection. You may have to alter the parameters to suit your configuration. If you are fine with the openconnect VPN autoconfiguration, you must alter the `rwth-vpn-*` scripts to not use the dns configuration script.
* `vpn-disconnect` Disconnect/terminate `openconnect`. You may use `^C` instead if openconnect is run in foreground to cleanly disconnect. While being forked to background, it is much more comfortable to shut down openconnect via the `vpn-disconnect` script.

Please ensure to define your VPN password `P="Your VPN password"` (cf. [RWTH Selfservice](https://idm.rwth-aachen.de/selfservice)) as well as your username (TIM ID). Save these scripts at a secure place (e.g. reachable from `$PATH` in `$HOME/bin/`) and __MAKE SURE! that these scripts can ONLY BE ACCESSED BY YOURSELF!__ (eg. `chmod 700 ...` and applying further MAC/ACL attributes if possible)

__!!! NEVER DISTRIBUTE ANY FILES CONTAINING YOUR CREDENTIALS !!!__

The provided connection scripts, `rwth-vpn-split` and `rwth-vpn-full`, respectively, contain parameters which I have tested to work  well and are sufficient to me to a certain degree for daily use:

* `--user="[Your TIM-ID, omit the domain, e.g. @rwth-aachen.de]"`
* `--passwd-on-stdin` Reads your password from `stdin`, used to comfortably connect by piping `P="Your VPN password"` to `openconnect`
* `--authgroup="RWTH-VPN (XYZ Tunnel)"` Using `Split` or `Full` tunnel configuration
* `--pfs` enforcing [perfect forward secrecy](https://en.wikipedia.org/wiki/Forward_secrecy)
* `--deflate --compression=all` Enable statefull compression (might disable UDP)
* `--script=/absolute/path/to/local-rwth-nameserver.sh` controlled overriding of `/etc/resolv.conf` (see above)
* `$@` Passing further command line arguments on demand (unfiltered!); might be a security issue due to `openconnect` must be run as superuser!
* `vpn.rwth-aachen.de` RWTH VPN domain to connect to.
