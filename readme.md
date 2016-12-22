# RPI OpenELEC XBox Remote Patch

This repository is a patch to enable the XBox DVD remote on OpenELEC (Tested on version 6.0.3)

To use, clone the repo `git clone git@github.com:BrianSidebotham/rpi-xbox-ir-openelec.git`

Scp the files to the storage folder of the OpenELEC RPI:

    cd rpi-xbox-ir-openelec
    scp -r . root@192.168.1.20:/storage

Reboot the OpenELEC RPI and your XBox DVD remote should now be working.

## Troubleshooting

If the remote doesn't work, there's some tests you can do.

Check the output of `dmesg` on the OpenELEC box, you should see something along the lines of:

    [    3.743857] lirc_dev: IR Remote Control driver registered, major 245
    [    3.750203] lirc_xbox: module is from the staging directory, the quality is unknown, you have been warned.
    [    3.750206] lirc_xbox: module is from the staging directory, the quality is unknown, you have been warned.
    [    3.750721]
    [    3.750721] lirc_xbox: XBOX DVD Dongle USB remote driver for LIRC $Revision: 0.01 $
    [    3.750732] lirc_xbox: Jason Martin <austinspartan@users.sourceforge.net>
    [    3.751259] lirc_xbox 1-1.2:1.0: lirc_dev: driver lirc_xbox  registered at minor = 0
    [    3.751271] lirc_xbox[4]:  on usb1:4

Monitor the IR activity with `irw`. When running, start pressing remote buttons and you should see the remote button names printed along with the xboxdvd remote name.

## Adding new buttons

In order to record new buttons we use the `irrecord` tool:

    irrecord -d /dev/lirc0 /storage/.config/lircd.conf

This will write out the conf file directly, if you'd rather just record some buttons into another configuration file, change the command to suit!

In order to `irrecord` you'll need to know buttons from the namespace. You can list the button names in the namespace by using:

    irrecord -list namespace

## Mapping Buttons to Kodi

There are two abstractions for Kodi, `/storage/.kodi/userdata/Lirxmap.xml` which maps the lirc namespace to the Kodi namespace, so for example `<up></up>` in the Kodi world gets mapped to `KEY_UP` in the lirc world.

Then there are the keymaps in `/storage/.kodi/userdata/keymaps/remote.xml` which map the Kodi Namespace to UI actions. Therefore you can assign buttons to do special tasks like start an Add-on or Reboot the system.
