#! /bin/sh

# This script is mostly idempotent.
# It only installs dnsmasq if it is not already installed (via brew)
# It only appends lines to dnsmasq conf files if they don't exist in the file.
# It WILL overwrite resolver files
# It WILL restart dnsmasq

DNS_CONF="/usr/local/etc/dnsmasq.conf"
GG_DNS_CONF="/usr/local/etc/dnsmasq.d/gg.conf"

# Dnsmasq is a lightweight dns that will make it easier to resolve local domains
maybe_install_dnsmasq() {
  if ! brew ls --versions dnsmasq > /dev/null; then
    brew install dnsmasq
  fi
}

# on most unix-y systems, the /etc/resolv.conf determins how DNS queries are made.
# on macos, the /etc/resolv.conf file is generated (and can be regenerated)
# by the macos system. We shouldn't edit it directly, but we can create a
# resolver in the /etc/resolver/ directory. The name corresponds to the top
# level domain that will be resolved.
setup_resolver() {
  sudo mkdir -p /etc/resolver
  sudo tee "/etc/resolver/$1" > /dev/null <<EOF
nameserver 127.0.0.1
domain $1
EOF
}

# The main dnsmasq configuration is at /usr/local/etc/dnsmasq.conf
# but we can tell it to read other configuration files.
# This lets us separate the gg specific stuff in it's own file and preserve any
# local setup you may have.
# We also don't want to end up with duplicate lines or overwrite configuration,
# so we check if the line we want to add already exists before adding.
maybe_setup_dnsmasq_conf() {
  if ! grep -q "^conf-dir=/usr/local/etc/dnsmasq\.d/,\*\.conf" $DNS_CONF; then
    sudo tee -a $DNS_CONF > /dev/null <<EOF
conf-dir=/usr/local/etc/dnsmasq.d/,*.conf
EOF
  fi

  if ! grep -qF "address=/$1/127.0.0.1" $GG_DNS_CONF; then
    sudo mkdir -p /usr/local/etc/dnsmasq.d
    sudo tee -a $GG_DNS_CONF > /dev/null <<EOF
address=/$1/127.0.0.1
EOF
  fi
}

maybe_install_dnsmasq
setup_resolver "test.greenlight.guru"
maybe_setup_dnsmasq_conf "test.greenlight.guru"
# need to start/restart dnsmasq for changes to take effect
sudo brew services start dnsmasq
sudo brew services restart dnsmasq

