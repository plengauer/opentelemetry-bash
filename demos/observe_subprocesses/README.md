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
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/dpkg --force-confdef --force-confold --force-confdef --force-confold --print-foreign-architectures
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
          sort
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
          sed -e s#'#'\"'\"'#g
          /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
          sed -e s#'#'\"'\"'#g
          gpg-connect-agent --no-autostart --dirmngr KILLDIRMNGR
          gpg-connect-agent -s --no-autostart GETINFO scd_running /if ${! $?} scd killscd /end
          gpg-connect-agent --no-autostart KILLAGENT
      /usr/lib/apt/methods/http
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.XfQ6KasLX7
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        /usr/bin/apt-key --quiet --readonly --keyring /etc/apt/keyrings/microsoft.gpg verify --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        gpgv --homedir /tmp/apt-key-gpghome.XfQ6KasLX7 --keyring /etc/apt/keyrings/microsoft.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.k7TOgx /tmp/apt.data.HrZSHT
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.XfQ6KasLX7
      /usr/lib/apt/methods/http
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.SCYxmni3h4
        readlink -f /tmp/apt-key-gpghome.SCYxmni3h4
        rm -f /tmp/apt-key-gpghome.SCYxmni3h4/pubring.gpg
        touch /tmp/apt-key-gpghome.SCYxmni3h4/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.SCYxmni3h4/pubring.gpg /tmp/apt-key-gpghome.SCYxmni3h4/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        gpgv --homedir /tmp/apt-key-gpghome.SCYxmni3h4 --keyring /tmp/apt-key-gpghome.SCYxmni3h4/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.esG6tt /tmp/apt.data.tucNRL
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.SCYxmni3h4
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.xe9TjXfoUR
        readlink -f /tmp/apt-key-gpghome.xe9TjXfoUR
        rm -f /tmp/apt-key-gpghome.xe9TjXfoUR/pubring.gpg
        touch /tmp/apt-key-gpghome.xe9TjXfoUR/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.xe9TjXfoUR/pubring.gpg /tmp/apt-key-gpghome.xe9TjXfoUR/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        gpgv --homedir /tmp/apt-key-gpghome.xe9TjXfoUR --keyring /tmp/apt-key-gpghome.xe9TjXfoUR/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.Y3fgZE /tmp/apt.data.zWeckE
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.xe9TjXfoUR
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.ad6e4pfLAj
        readlink -f /tmp/apt-key-gpghome.ad6e4pfLAj
        rm -f /tmp/apt-key-gpghome.ad6e4pfLAj/pubring.gpg
        touch /tmp/apt-key-gpghome.ad6e4pfLAj/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.ad6e4pfLAj/pubring.gpg /tmp/apt-key-gpghome.ad6e4pfLAj/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        gpgv --homedir /tmp/apt-key-gpghome.ad6e4pfLAj --keyring /tmp/apt-key-gpghome.ad6e4pfLAj/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.Iez2qj /tmp/apt.data.bImS6S
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.ad6e4pfLAj
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.fmP5UtNpXC
        readlink -f /tmp/apt-key-gpghome.fmP5UtNpXC
        rm -f /tmp/apt-key-gpghome.fmP5UtNpXC/pubring.gpg
        touch /tmp/apt-key-gpghome.fmP5UtNpXC/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.fmP5UtNpXC/pubring.gpg /tmp/apt-key-gpghome.fmP5UtNpXC/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        gpgv --homedir /tmp/apt-key-gpghome.fmP5UtNpXC --keyring /tmp/apt-key-gpghome.fmP5UtNpXC/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.YAaC1X /tmp/apt.data.KDA1t4
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.fmP5UtNpXC
      /usr/lib/apt/methods/gpgv
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        apt-config shell MASTER_KEYRING APT::Key::MasterKeyring
        apt-config shell ARCHIVE_KEYRING APT::Key::ArchiveKeyring
        apt-config shell REMOVED_KEYS APT::Key::RemovedKeys
        apt-config shell ARCHIVE_KEYRING_URI APT::Key::ArchiveKeyringURI
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        apt-config shell TRUSTEDFILE Apt::GPGV::TrustedKeyring
        apt-config shell TRUSTEDFILE Dir::Etc::Trusted/f
        apt-config shell GPGV Apt::Key::gpgvcommand
        mktemp --directory --tmpdir apt-key-gpghome.XXXXXXXXXX
        chmod 700 /tmp/apt-key-gpghome.3Lmxatca1u
        readlink -f /tmp/apt-key-gpghome.3Lmxatca1u
        rm -f /tmp/apt-key-gpghome.3Lmxatca1u/pubring.gpg
        touch /tmp/apt-key-gpghome.3Lmxatca1u/pubring.gpg
        apt-config shell TRUSTEDPARTS Dir::Etc::TrustedParts/d
        readlink -f /etc/apt/trusted.gpg.d/
        find /etc/apt/trusted.gpg.d -mindepth 1 -maxdepth 1 ( -name *.gpg -o -name *.asc )
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/git-core-ubuntu-ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/google-chrome.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/microsoft-edge.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/microsoft-prod.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/mozillateam_ubuntu_ppa.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cmp -s -n 1 - /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        cat /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
        cp -a /tmp/apt-key-gpghome.3Lmxatca1u/pubring.gpg /tmp/apt-key-gpghome.3Lmxatca1u/pubring.orig.gpg
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        /usr/bin/apt-key --quiet --readonly verify --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        gpgv --homedir /tmp/apt-key-gpghome.3Lmxatca1u --keyring /tmp/apt-key-gpghome.3Lmxatca1u/pubring.gpg --ignore-time-conflict --status-fd 3 /tmp/apt.sig.0akwsH /tmp/apt.data.ICfKd6
        gpgconf --kill all
        rm -rf /tmp/apt-key-gpghome.3Lmxatca1u
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
        rm -f /var/lib/update-notifier/tmp.Mpo1fKiupl
      /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
      /usr/bin/dpkg --force-confdef --force-confold --print-foreign-architectures
```
## Full Trace
```
```
