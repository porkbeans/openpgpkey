GPG_FINGERPRINT = F99A0AD6BEACC33FF4C433A715BE96E2297B9E3B

.PHONY: update send backup restore

update:
	gpg --list-options show-only-fpr-mbox -k '@porkbeans.dev' | "$(shell gpgconf --list-dir libexecdir)/gpg-wks-client" -C docs/.well-known/openpgpkey -v --install-key

send:
	# Send to keyserver.ubuntu.com
	gpg --keyserver keyserver.ubuntu.com --send-keys $(GPG_FINGERPRINT)

	# Send to keys.openpgp.org with email verification
	# https://keys.openpgp.org/about/usage#gnupg-upload
	gpg --export $(GPG_FINGERPRINT) | curl -T - https://keys.openpgp.org

backup:
	gpg --export-secret-keys -a | rclone rcat pcloud:secrets/gpg/gpg_secret.asc
	gpg --export-secret-subkeys -a | rclone rcat pcloud:secrets/gpg/gpg_secret_sub.asc
	gpg --export-ownertrust | rclone rcat pcloud:secrets/gpg/gpg_ownertrust.txt

restore:
	rclone cat pcloud:secrets/gpg/gpg_secret.asc | gpg --import
	rclone cat pcloud:secrets/gpg/gpg_ownertrust.txt | gpg --import-ownertrust
