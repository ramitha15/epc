# Building

To build:
```shell
sudo apt install snapcraft
snapcraft
```

# Installation

Install a locally built snap with:
```shell
sudo snap install --devmode *.snap
```

Or from a store:
```shell
sudo snap install --devmode --beta quortus-epc-lool
```

## Sentinel LDK daemon

In some installations, depending on the licensing scheme, you might need the
Sentinel LDK daemon installed on the target system. This is currently only
available as a .deb, so this is not available for Ubuntu Core but works on
Ubuntu classic 16.04+.

The daemon is available as a `.deb` package inside a tarball after accepting a
license at:
<https://sentinelcustomer.gemalto.com/sentineldownloads/?o=Linux>

This is a direct link if you've already accepted the license:
<ftp://ftp.cis-app.com/pub/hasp/Sentinel_HASP/Runtime_(Drivers)/7.51/Sentinel_LDK_Ubuntu_DEB_Run-time_Installer.tar.gz>

To run the daemon on an `amd64` system, you need the `i386` libc6 package;
here's how to install it:
```shell
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libc6:i386
```

Install the daemon and check it's running with:
```shell
sudo dpkg -i aksusbd_*.deb
ps ax | egrep '(aksusb|winehasp|hasplmd)'
```

# Setup and operation

Check your system is configured properly:
```shell
/snap/quortus-epc-lool/current/check-sys
```

Upon installation, the `ran` daemon is launched. It creates a config file under
`/var/snap/quortus-epc-lool/current` which you may edit; restart the service to
pick up changes:
```shell
sudo vi /var/snap/quortus-epc-lool/current/ran.cfg
sudo systemctl restart snap.quortus-epc-lool.ran
```

## RAN cli

An interactive RAN shell is available via the `rancli` tool:
```shell
quortus-epc-lool.rancli
```

The first time you connect should prompt you to accept the license.

## Provisioning of USB dongle

If you're using an USB dongle licensing, you might have to provision it with
a long token as input to the RAN cli shell:
```shell
upd license token=xyz
```

## Diagnosis and debugging

Check the service is running or follow its output with:
```shell
sudo systemctl status snap.quortus-epc-lool.ran
sudo journalctl -u snap.quortus-epc-lool.ran -f
```

To start the daemon interactively, stop the service and launch the `ran`
command of the snap with `snap run`:
```shell
sudo systemctl stop snap.quortus-epc-lool.ran
sudo snap run quortus-epc-lool.ran
```

To enable logs, use this `rancli` command:
```shell
set oam mon=on
```

To debug eNodeB to EPC connection issues, use `sudo netstat -anp | grep LISTEN`
to see all listening sockets. Note that support for SCTP sockets is missing
from Ubuntu's 16.04 net-tools; installing the .deb from zesty works fine:
<http://launchpadlibrarian.net/301885046/net-tools_1.60+git20161116.90da8a0-1ubuntu1_amd64.deb>

