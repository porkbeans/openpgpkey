# openpgpkey.porkbeans.dev
Hosting WKD on GitHub Pages

# Note for updating public key
```sh
gpg --list-options show-only-fpr-mbox -k '@porkbeans.dev' | "$(gpgconf --list-dir libexecdir)/gpg-wks-client" -C .well-known/openpgpkey -v --install-key
```
