#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Start Hoymiles service
# ==============================================================================
ALPINE_VERSION=$(cat /etc/alpine-release)
PYTHON_VERION=$(python3 --version)

set +u

bashio::log.green "Starting add-on container..."
date

CONFIG_PATH=/data/options.json
SYSTEM_USER=/data/system_user.json

ls -la

pwd

mkdir -p /data/templates

mkdir -p /data/jsons
cp /*.json /data/jsons
cp /micro_* /data/jsons

if [ -e "secrets.ini" ]; then
    bashio::log.info "secrets.ini exists!"
fi

if [ -e "/data/secrets.ini" ]; then
    bashio::log.info "/data/secrets.ini exists!"
else
    bashio::log.info "/data/secrets.ini not exists!"
    if [ -e "/secrets.ini" ]; then
        bashio::log.info "Copying..."
        cp /secrets.ini /data
    fi
fi

bashio::log.blue "Getting mqtt data..."
export MQTT_HOST_HA=$(bashio::services mqtt "host")
export MQTT_USER_HA=$(bashio::services mqtt "username")
export MQTT_PASSWORD_HA=$(bashio::services mqtt "password")

export HASS_USERNAME=$(bashio::config 'username')
bashio::log.info "${HASS_USERNAME}"
export HASS_TIMEZONE=$(bashio::info 'timezone')
bashio::log.info "${HASS_TIMEZONE}"

export HASS_TIMEZONE_2=$(bashio::info "timezone")
bashio::log.info "${HASS_TIMEZONE_2}"

bashio::log.info "OS Alpine Linux ${ALPINE_VERSION}"
bashio::log.info "${PYTHON_VERION}"

bashio::log.blue "dmslabs - Home Assistant HoyMiles Solar Data Gateway Add-on"

python3 /hoymiles.py