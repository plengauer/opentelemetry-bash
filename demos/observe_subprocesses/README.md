# Demo "apt-get"
This is a script that updates the system using apt-get. It observes all subprocesses recursively, even though they are not shells.
## Script
```sh
export OTEL_SHELL_CONFIG_OBSERVE_SUBPROCESSES=TRUE
. otel.sh
sudo apt-get update
```
## Trace Structure Overview
```
bash -e demo.sh
  sudo apt-get update
    apt-get update
      /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
      /usr/lib/apt/methods/mirror+file
      /usr/lib/apt/methods/https
      apt-get update
        id -u
        systemctl start --no-block apt-news.service esm-cache.service
      sh -c [ ! -e /run/systemd/system ] || [ $(id -u) -ne 0 ] || systemctl start --no-block apt-news.service esm-cache.service >/dev/null 2>&1 || true
      /usr/lib/apt/methods/https
      /usr/lib/apt/methods/mirror+file
      /usr/lib/apt/methods/file
      /usr/lib/apt/methods/file
      /usr/lib/apt/methods/gpgv
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
      /usr/lib/apt/methods/http
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.aHDd8g6FfC
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        gpgv --homedir /tmp/apt-key-gpghome.aHDd8g6FfC --keyring /etc/apt/keyrings/microsoft.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.uo2PXg /tmp/apt.data.x6Z1Nw
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.aHDd8g6FfC
      /usr/lib/apt/methods/http
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.1MLaiqdlSQ
        readlink -f /tmp/apt-key-gpghome.1MLaiqdlSQ
        rm -f /tmp/apt-key-gpghome.1MLaiqdlSQ/pubring.gpg
        touch /tmp/apt-key-gpghome.1MLaiqdlSQ/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.1MLaiqdlSQ/pubring.gpg /tmp/apt-key-gpghome.1MLaiqdlSQ/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        gpgv --homedir /tmp/apt-key-gpghome.1MLaiqdlSQ --keyring /tmp/apt-key-gpghome.1MLaiqdlSQ/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.sAIeUm /tmp/apt.data.PsjoMG
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.1MLaiqdlSQ
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.aJcsrfSX9e
        readlink -f /tmp/apt-key-gpghome.aJcsrfSX9e
        rm -f /tmp/apt-key-gpghome.aJcsrfSX9e/pubring.gpg
        touch /tmp/apt-key-gpghome.aJcsrfSX9e/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.aJcsrfSX9e/pubring.gpg /tmp/apt-key-gpghome.aJcsrfSX9e/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        gpgv --homedir /tmp/apt-key-gpghome.aJcsrfSX9e --keyring /tmp/apt-key-gpghome.aJcsrfSX9e/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.tUS2yl /tmp/apt.data.nk1cEv
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.aJcsrfSX9e
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.qADNXdT7qv
        readlink -f /tmp/apt-key-gpghome.qADNXdT7qv
        rm -f /tmp/apt-key-gpghome.qADNXdT7qv/pubring.gpg
        touch /tmp/apt-key-gpghome.qADNXdT7qv/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.qADNXdT7qv/pubring.gpg /tmp/apt-key-gpghome.qADNXdT7qv/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        gpgv --homedir /tmp/apt-key-gpghome.qADNXdT7qv --keyring /tmp/apt-key-gpghome.qADNXdT7qv/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.s9k5PA /tmp/apt.data.bW6hSw
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.qADNXdT7qv
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.l7ExHvLUXx
        readlink -f /tmp/apt-key-gpghome.l7ExHvLUXx
        rm -f /tmp/apt-key-gpghome.l7ExHvLUXx/pubring.gpg
        touch /tmp/apt-key-gpghome.l7ExHvLUXx/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.l7ExHvLUXx/pubring.gpg /tmp/apt-key-gpghome.l7ExHvLUXx/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        gpgv --homedir /tmp/apt-key-gpghome.l7ExHvLUXx --keyring /tmp/apt-key-gpghome.l7ExHvLUXx/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.7kNisP /tmp/apt.data.FwGDbn
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.l7ExHvLUXx
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.FEPviXBYqn
        readlink -f /tmp/apt-key-gpghome.FEPviXBYqn
        rm -f /tmp/apt-key-gpghome.FEPviXBYqn/pubring.gpg
        touch /tmp/apt-key-gpghome.FEPviXBYqn/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.FEPviXBYqn/pubring.gpg /tmp/apt-key-gpghome.FEPviXBYqn/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        gpgv --homedir /tmp/apt-key-gpghome.FEPviXBYqn --keyring /tmp/apt-key-gpghome.FEPviXBYqn/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.mCaWKB /tmp/apt.data.MDcHut
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.FEPviXBYqn
      apt-get update
        touch /var/lib/apt/periodic/update-success-stamp
        /usr/bin/test -e /usr/share/dbus-1/system-services/org.freedesktop.PackageKit.service
        /usr/bin/test -S /var/run/dbus/system_bus_socket
        /usr/bin/gdbus call --system --dest org.freedesktop.PackageKit --object-path /org/freedesktop/PackageKit --timeout 4 --method org.freedesktop.PackageKit.StateHasChanged cache-update
        /bin/echo
        /usr/bin/test -w /var/lib/command-not-found/ -a -e /usr/lib/cnf-update-db
        /usr/lib/cnf-update-db
        /usr/lib/update-notifier/update-motd-updates-available
          /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
          dirname /var/lib/update-notifier/updates-available
      sh -c touch /var/lib/apt/periodic/update-success-stamp 2>/dev/null || true
      sh -c /usr/bin/test -e /usr/share/dbus-1/system-services/org.freedesktop.PackageKit.service && /usr/bin/test -S /var/run/dbus/system_bus_socket && /usr/bin/gdbus call --system --dest org.freedesktop.PackageKit --object-path /org/freedesktop/PackageKit --timeout 4 --method org.freedesktop.PackageKit.StateHasChanged cache-update > /dev/null; /bin/echo > /dev/null
        /usr/bin/gdbus call --system --dest org.freedesktop.PackageKit --object-path /org/freedesktop/PackageKit --timeout 4 --method org.freedesktop.PackageKit.StateHasChanged cache-update
        /usr/bin/gdbus call --system --dest org.freedesktop.PackageKit --object-path /org/freedesktop/PackageKit --timeout 4 --method org.freedesktop.PackageKit.StateHasChanged cache-update
      sh -c if /usr/bin/test -w /var/lib/command-not-found/ -a -e /usr/lib/cnf-update-db; then /usr/lib/cnf-update-db > /dev/null; fi
        /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
      sh -c /usr/lib/update-notifier/update-motd-updates-available 2>/dev/null || true
        apt-config shell StateDir Dir::State
        apt-config shell ListDir Dir::State::Lists
        apt-config shell DpkgStatus Dir::State::status
        apt-config shell EtcDir Dir::Etc
        apt-config shell SourceList Dir::Etc::sourcelist
        find /var/lib/apt/lists/ /etc/apt/sources.list //var/lib/dpkg/status -type f -newer /var/lib/update-notifier/updates-available -print -quit
        mktemp -p /var/lib/update-notifier
        rm -f /var/lib/update-notifier/tmp.fn0w03podp
      /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
      /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
```
## Full Trace
```
```
