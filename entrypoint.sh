#!/bin/sh

SQUID_CACHE_DIR="/var/cache/squid"
SQUID_USER="squid"

create_cache_dir() {
  mkdir -p ${SQUID_CACHE_DIR}
  chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CACHE_DIR}
}

echo "Creating the cache directory..."
mkdir -p ${SQUID_CACHE_DIR}

# Launch Squid3
if [[ ! -d ${SQUID_CACHE_DIR}/00 ]]; then
  echo "Initializing squid3  cache directory..."
  /usr/sbin/squid -N -f /etc/squid/squid.conf -z
fi
echo "Starting squid3..."
exec /usr/sbin/squid -NYCd1
