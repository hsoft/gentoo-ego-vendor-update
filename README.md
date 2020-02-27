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

## Generate EGO_VENDOR from source

Manually updating `EGO_VENDOR`, even with `update_ego_vendor.sh` was becoming tiresome when the
package would add new dependencies with lots of sub-dependencies, so I created a whole new script
with a new approach: `extract_ego_vendor.sh`.

To use this script, you must first create yourself an empty directory and set your `GOPATH` env
variable to that path. Then, use `go get` or whatever else you need and let it fetch its
dependencies. Then call `extract_ego_vendor.sh` with one argument: a path inside your `GOROOT` that
has the `github.com`, `gopkg.in` and `golang.org` subdirectories.

You will then get a neat `EGO_VENDOR` output.

For now, this has only been tested with `lxc/lxd`.
