# Gentoo EGO_VENDOR updater

Helper script to update hashes inside an ebuild's `EGO_VENDOR` variable. It goes over the list
of dependencies, fetches the latest `HEAD`'s hash and outputs an up-to-date `EGO_VENDOR`.

Builds on Zac Medico's one-liners from https://bugs.gentoo.org/show_bug.cgi?id=615444

## Usage

    $ ./update_ego_vendor.sh /usr/portage/app-emulation/lxd/lxd-2.14-r1.ebuild

## Limitations

* Assumes github. Either the dependency line is in the `github.com/foo/bar <hash>` form or in the
  `some-name <hash> github.com/foo/bar` one.
* Github limits access to its API to 60 requests per hour.
