# Guide for connecting drones over 4G LTE

Authors [Simon Ranefjärd](https://github.com/Ranis94) and [Emil Fresk](https://github.com/korken89)

TODO: Write a small intro here

## D-Link DWM-222 LTE Modem (fixed IP)

### Prerequisites for automatic 4G connection

Install `usb_modeswitch` and `wvdial`:

```console
$ sudo apt install usb-modeswitch wvdial
```

**Note:** If the installer gets stuck on wvdial, run: `sudo killall wvdialconf`

Update the file `/etc/wvdial.conf` so it looks the same as the files in this repository.
Add the following files at the following locations:

* The file `2001:ab00`, in the `./usb_modeswitch.d/` directory, to `/etc/usb_modeswitch.d/`, with:

```
$ sudo cp ./usb_modeswitch.d/2001\:ab00 /etc/usb_modeswitch.d/
```

* The file `modem_attachment.sh` to `/usr/sbin/` and make it executable with:

```
$ sudo cp modem_attachment.sh /usr/sbin/
$ sudo chmod +x /usr/sbin/modem_attachment.sh
```

* The file `modem-attachment.service` to `/etc/systemd/system/` with:

```
$ sudo cp modem-attachment.service /etc/systemd/system/
```

* The file `lte-dwm222.rules` to `/etc/udev/rules.d/` with:

```
$ sudo cp lte-dwm222.rules /etc/udev/rules.d/
```

Add the following lines to `/etc/network/interfaces`, so the connection is directly used:

```
# 4G connection
auto ppp0
iface ppp0 inet wvdial
```

Now after a reboot the 4G stick will be detected automatically.

### Manual test connection

Make the modem switch from USB Storage Mode to Modem Mode:

```console
$ sudo usb_modeswitch -v 0x2001 -p 0xab00 -M "55534243123456780000000000000011062000000100000000000000000000"
```

Load serial drivers to communicate with AT interface:

```console
$ sudo modprobe option; sudo sh -c "echo 2001 7e35 > /sys/bus/usb-serial/drivers/option1/new_id"
```

Connect to the internet using `wvdial`:

```console
$ sudo wvdial &
```

You should now have a working 4G LTE connection!

### Make connection automatic on detection of LTE Modem
