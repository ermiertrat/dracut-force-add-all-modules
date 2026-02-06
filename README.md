# dracut-force-add-all-modules

This is a Dracut module that will add all available kernel modules to the initramfs, regardless of hostonly mode. It doesn't do any filtering, and will thus ignore the omit_drivers directive in dracut.conf. Use modprobe.d configuration to prevent modules from automatically being loaded if needed.


## How to use

You might have to slightly adjust the paths below (look up Dracut package contents on your distro to figure out the correct paths).

- Clone this Git repo into `/usr/lib/dracut/modules.d/99all-modules` (this dir should contain `module-setup.sh`).
- Run `sudo chmod +x /usr/lib/dracut/modules.d/99all-modules/module-setup.sh`
- In `/etc/dracut.conf` (or in a file under `/etc/dracut.conf.d`), add `add_dracutmodules+=all-modules`.
- Optionally, drop `all-modules.conf` from this repo into `/etc/dracut.conf.d` if you'd like.
- Regenerate the initramfs and see if the amount of included modules increased (`lsinitrd` can help, try something like
  `lsinitrd /boot/initramfs-test.img | grep lib/modules | wc -l` on images with and without this module).
