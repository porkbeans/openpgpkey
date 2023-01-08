# openpgpkey.porkbeans.dev
Hosting WKD on GitHub Pages

# Note for recreating .well-known/openpgpkey
```sh
$ rm -rf .well-known/openpgpkey
$ mkdir -p .well-known/openpgpkey
$ gpg --list-options show-only-fpr-mbox -k '@porkbeans.dev' | "$(gpgconf --list-dir libexecdir)/gpg-wks-client" -C .well-known/openpgpkey -v --install-key
```
