# Guide for connecting drones over 4G LTE

Authors [Simon Ranefjärd](https://github.com/Ranis94) and [Emil Fresk](https://github.com/korken89)

TODO: Write a small intro here

## D-Link DWM-222 LTE Modem (fixed IP)

### Prerequisites

Install `usb_modeswitch` and `wvdial`:

```console
$ sudo apt install usb_modeswitch wvdial
```

Update the files `/etc/usb_modeswitch.conf` and `/etc/wvdial.conf` so it looks the same as the files in this repository.

### First test connection

Make the modem switch from USB Storage Mode to Modem Mode:

```console
$ sudo usb_modeswitch -v 0x2001 -p 0xab00 -M "55534243123456780000000000000011062000000100000000000000000000"
```

Load serial drivers to communicate with AT interface:

```console
$ sudo modprobe option; sudo echo "2001 7e35" > /sys/bus/usb-serial/drivers/option1/new_id
```

Connect to the internet using `wvdial`:

```console
$ sudo wvdial &
```

You should now have a working 4G LTE connection!

### Make connection automatic on detection of LTE Modem
