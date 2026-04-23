#!/bin/bash

SCRIPT_LANG=""
CUSTOM_DNS="94.26.248.162"

function select_language {
    echo -e "\n\e[1;35m╭─────────────────────────────────────╮"
    echo -e "│      \e[1;36m  W A R P - N A T I V E        \e[1;35m│"
    echo -e "│     \e[2;37m       by distillium            \e[1;35m│"
    echo -e "\e[1;35m╰─────────────────────────────────────╯\e[0m"
    echo ""
    echo -e "\e[1;34mSelect language / Выберите язык:\e[0m"
    echo -e "\e[1;32m1)\e[0m English"
    echo -e "\e[1;32m2)\e[0m Русский"
    echo ""
    
    while true; do
        read -p "Choice / Выбор [1-2]: " choice
        case $choice in
            1) SCRIPT_LANG="en"; break ;;
            2) SCRIPT_LANG="ru"; break ;;
            *) echo -e "\e[1;31mInvalid choice / Неверный выбор\e[0m" ;;
        esac
    done
    
    clear
    echo -e "\n\e[1;35m╭─────────────────────────────────────╮"
    echo -e "│      \e[1;36m  W A R P - N A T I V E        \e[1;35m│"
    echo -e "│     \e[2;37m       by distillium            \e[1;35m│"
    echo -e "\e[1;35m╰─────────────────────────────────────╯\e[0m"
    sleep 1
}

function msg {
    local key="$1"
    case "$SCRIPT_LANG" in
        "ru")
            case "$key" in
                "root_required") echo "Этот скрипт должен быть запущен от имени root" ;;
                "start_install") echo "Начинаем установку и настройку Cloudflare WARP" ;;
                "install_wireguard") echo "1. Установка WireGuard..." ;;
                "update_failed") echo "Не удалось обновить список пакетов." ;;
                "wireguard_failed") echo "Не удалось установить WireGuard." ;;
                "wireguard_ok") echo "WireGuard установлен." ;;
                "temp_dns") echo "2. Подготовка DNS (${CUSTOM_DNS}) для интерфейса WARP..." ;;
                "dns_failed") echo "Не удалось прописать DNS ${CUSTOM_DNS} в конфигурацию интерфейса WARP." ;;
                "dns_ok") echo "DNS ${CUSTOM_DNS} прописан в конфигурации интерфейса WARP." ;;
                "download_wgcf") echo "3. Скачивание и установка wgcf..." ;;
                "wgcf_version_failed") echo "Не удалось получить последнюю версию wgcf" ;;
                "wgcf_download_failed") echo "Не удалось скачать wgcf." ;;
                "wgcf_chmod_failed") echo "Не удалось сделать wgcf исполняемым." ;;
                "wgcf_move_failed") echo "Не удалось переместить wgcf в /usr/local/bin." ;;
                "wgcf_installed") echo "установлен в /usr/local/bin/wgcf." ;;
                "arch_detected") echo "Определена архитектура:" ;;
                "register_wgcf") echo "4. Регистрация и генерация конфигурации wgcf..." ;;
                "account_exists") echo "Файл wgcf-account.toml уже существует. Пропускаем регистрацию." ;;
                "registering") echo "Выполняем регистрацию wgcf..." ;;
                "register_error") echo "wgcf register завершился с кодом" ;;
                "cf_error_500") echo "Возможна ошибка 500 от Cloudflare." ;;
                "known_behavior") echo "Это известное поведение: продолжаем попытку регистрации." ;;
                "registration_failed") echo "Регистрация не удалась: файл wgcf-account.toml не создан." ;;
                "account_created") echo "Файл wgcf-account.toml успешно создан. Продолжаем установку." ;;
                "wgcf_binary_check") echo "Проверяем бинарный файл wgcf..." ;;
                "wgcf_not_executable") echo "Бинарный файл wgcf не исполняется или имеет неправильную архитектуру." ;;
                "trying_alternative") echo "Пробуем альтернативный метод регистрации..." ;;
                "cf_500_detected") echo "Cloudflare вернул ошибку 500 Internal Server Error." ;;
                "cf_rate_limited") echo "Превышен лимит запросов к Cloudflare. Подождите и попробуйте позже." ;;
                "cf_forbidden") echo "Доступ запрещен Cloudflare." ;;
                "network_issue") echo "Проблемы с сетевым подключением." ;;
                "unknown_error") echo "Произошла неизвестная ошибка:" ;;
                "config_generated") echo "Конфигурация wgcf успешно сгенерирована." ;;
                "config_gen_failed") echo "Ошибка при генерации конфигурации wgcf." ;;
                "warp_plus_prompt") echo "Если у вас есть WARP+ ключ, вы можете его применить." ;;
                "enter_license") echo "Введите лицензионный ключ WARP+ (Enter - пропустить): " ;;
                "applying_license") echo "Применение WARP+ лицензии..." ;;
                "license_applied") echo "WARP+ лицензия успешно применена!" ;;
                "license_failed") echo "Не удалось применить лицензию. Проверьте ключ." ;;
                "continuing_free") echo "Продолжаем с бесплатной версией WARP." ;;
                "skipping_license") echo "Пропускаем применение WARP+ лицензии." ;;
                "config_regenerated") echo "Конфигурация перегенерирована с WARP+." ;;
                "edit_config") echo "5. Редактирование конфигурации WARP..." ;;
                "config_not_found") echo "не найден." ;;
                "dns_removed") echo "Не удалось удалить строку DNS из конфигурации." ;;
                "table_off_failed") echo "Не удалось добавить Table = off." ;;
                "keepalive_failed") echo "Не удалось добавить PersistentKeepalive = 25." ;;
                "wireguard_dir_failed") echo "Не удалось создать директорию /etc/wireguard." ;;
                "config_move_failed") echo "Не удалось переместить конфигурацию." ;;
                "config_saved") echo "Конфигурация сохранена в /etc/wireguard/warp.conf." ;;
                "check_ipv6") echo "6. Проверка включён ли IPv6 и настройка конфигурации WARP..." ;;
                "ipv6_enabled") echo "IPv6 включён на сервере — оставляем IPv6-адрес в конфигурации WARP." ;;
                "ipv6_disabled") echo "IPv6 отключён или не настроен на сервере — удаляем IPv6-адрес из конфигурации WARP." ;;
                "ipv6_removed") echo "IPv6-адрес удалён из конфигурации." ;;
                "connect_warp") echo "7. Подключение интерфейса WARP..." ;;
                "connect_failed") echo "Не удалось подключить интерфейс." ;;
                "warp_connected") echo "Интерфейс WARP успешно подключен." ;;
                "check_status") echo "8. Проверка статуса подключения WARP..." ;;
                "warp_not_found") echo "Интерфейс WARP не найден — туннель не работает." ;;
                "handshake_received") echo "Получен handshake →" ;;
                "warp_active") echo "WARP подключён и активно обменивается трафиком." ;;
                "handshake_failed") echo "Не удалось получить handshake в течении 10 секунд. Возможны проблемы с подключением." ;;
                "cf_response") echo "Ответ от Cloudflare: warp=on" ;;
                "cf_not_confirmed") echo "Cloudflare не подтвердил warp=on, но интерфейс работает. Это нормально." ;;
                "warp_plus_active") echo "WARP+ активирован" ;;
                "warp_free_active") echo "Используется бесплатная версия WARP" ;;
                "enable_autostart") echo "9. Включение автозапуска WARP при старте..." ;;
                "autostart_failed") echo "Не удалось настроить автозапуск." ;;
                "autostart_enabled") echo "Автозапуск включен." ;;
                "installation_complete") echo "Установка и настройка Cloudflare WARP завершены!" ;;
                "check_service") echo "Проверить статус службы:" ;;
                "show_info") echo "Посмотреть информацию (WG):" ;;
                "stop_interface") echo "Остановить интерфейс:" ;;
                "start_interface") echo "Запустить интерфейс:" ;;
                "restart_interface") echo "Перезапустить интерфейс:" ;;
                "disable_autostart") echo "Отключить автозапуск:" ;;
                "enable_autostart_cmd") echo "Включить автозапуск:" ;;
                "cf_response_plus") echo "Ответ от Cloudflare: warp=plus — WARP+ работает!" ;;
                "recreating_account") echo "Обнаружен старый аккаунт. Для активации WARP+ пересоздаём аккаунт..." ;;
                "old_account_removed") echo "Старый аккаунт удалён." ;;
                *) echo "$key" ;;
            esac
            ;;
        *)
            case "$key" in
                "root_required") echo "This script must be run as root" ;;
                "start_install") echo "Starting Cloudflare WARP installation and configuration" ;;
                "install_wireguard") echo "1. Installing WireGuard..." ;;
                "update_failed") echo "Failed to update package list." ;;
                "wireguard_failed") echo "Failed to install WireGuard." ;;
                "wireguard_ok") echo "WireGuard installed." ;;
                "temp_dns") echo "2. Preparing DNS (${CUSTOM_DNS}) for WARP interface configuration..." ;;
                "dns_failed") echo "Failed to write DNS ${CUSTOM_DNS} into WARP interface configuration." ;;
                "dns_ok") echo "DNS ${CUSTOM_DNS} written to WARP interface configuration." ;;
                "download_wgcf") echo "3. Downloading and installing wgcf..." ;;
                "wgcf_version_failed") echo "Failed to get latest wgcf version" ;;
                "wgcf_download_failed") echo "Failed to download wgcf." ;;
                "wgcf_chmod_failed") echo "Failed to make wgcf executable." ;;
                "wgcf_move_failed") echo "Failed to move wgcf to /usr/local/bin." ;;
                "wgcf_installed") echo "installed to /usr/local/bin/wgcf." ;;
                "arch_detected") echo "Detected architecture:" ;;
                "register_wgcf") echo "4. Registering and generating wgcf configuration..." ;;
                "account_exists") echo "wgcf-account.toml file already exists. Skipping registration." ;;
                "registering") echo "Performing wgcf registration..." ;;
                "register_error") echo "wgcf register exited with code" ;;
                "cf_error_500") echo "Possible 500 error from Cloudflare." ;;
                "known_behavior") echo "This is known behavior: continuing registration attempt." ;;
                "registration_failed") echo "Registration failed: wgcf-account.toml file not created." ;;
                "account_created") echo "wgcf-account.toml file successfully created. Continuing installation." ;;
                "wgcf_binary_check") echo "Checking wgcf binary..." ;;
                "wgcf_not_executable") echo "wgcf binary is not executable or has wrong architecture." ;;
                "trying_alternative") echo "Trying alternative registration method..." ;;
                "cf_500_detected") echo "Cloudflare returned 500 Internal Server Error." ;;
                "cf_rate_limited") echo "Rate limited by Cloudflare. Please wait and try again later." ;;
                "cf_forbidden") echo "Access forbidden by Cloudflare." ;;
                "network_issue") echo "Network connection issue." ;;
                "unknown_error") echo "Unknown error occurred:" ;;
                "config_generated") echo "wgcf configuration successfully generated." ;;
                "config_gen_failed") echo "Error generating wgcf configuration." ;;
                "warp_plus_prompt") echo "If you have a WARP+ key, you can apply it now." ;;
                "enter_license") echo "Enter WARP+ license key (Enter to skip): " ;;
                "applying_license") echo "Applying WARP+ license..." ;;
                "license_applied") echo "WARP+ license successfully applied!" ;;
                "license_failed") echo "Failed to apply license. Check your key." ;;
                "continuing_free") echo "Continuing with free WARP version." ;;
                "skipping_license") echo "Skipping WARP+ license application." ;;
                "config_regenerated") echo "Configuration regenerated with WARP+." ;;
                "edit_config") echo "5. Editing WARP configuration..." ;;
                "config_not_found") echo "not found." ;;
                "dns_removed") echo "Failed to remove DNS line from configuration." ;;
                "table_off_failed") echo "Failed to add Table = off." ;;
                "keepalive_failed") echo "Failed to add PersistentKeepalive = 25." ;;
                "wireguard_dir_failed") echo "Failed to create /etc/wireguard directory." ;;
                "config_move_failed") echo "Failed to move configuration." ;;
                "config_saved") echo "Configuration saved to /etc/wireguard/warp.conf." ;;
                "check_ipv6") echo "6. Checking if IPv6 is enabled and configuring WARP..." ;;
                "ipv6_enabled") echo "IPv6 is enabled on server — keeping IPv6 address in WARP configuration." ;;
                "ipv6_disabled") echo "IPv6 is disabled or not configured on server — removing IPv6 address from WARP configuration." ;;
                "ipv6_removed") echo "IPv6 address removed from configuration." ;;
                "connect_warp") echo "7. Connecting WARP interface..." ;;
                "connect_failed") echo "Failed to connect interface." ;;
                "warp_connected") echo "WARP interface successfully connected." ;;
                "check_status") echo "8. Checking WARP connection status..." ;;
                "warp_not_found") echo "WARP interface not found — tunnel is not working." ;;
                "handshake_received") echo "Handshake received →" ;;
                "warp_active") echo "WARP is connected and actively exchanging traffic." ;;
                "handshake_failed") echo "Failed to get handshake within 10 seconds. Connection problems possible." ;;
                "cf_response") echo "Cloudflare response: warp=on" ;;
                "cf_not_confirmed") echo "Cloudflare did not confirm warp=on, but interface is working. This is normal." ;;
                "warp_plus_active") echo "WARP+ activated" ;;
                "warp_free_active") echo "Using free WARP version" ;;
                "enable_autostart") echo "9. Enabling WARP autostart on boot..." ;;
                "autostart_failed") echo "Failed to configure autostart." ;;
                "autostart_enabled") echo "Autostart enabled." ;;
                "installation_complete") echo "Cloudflare WARP installation and configuration completed!" ;;
                "check_service") echo "Check service status:" ;;
                "show_info") echo "Show information (WG):" ;;
                "stop_interface") echo "Stop interface:" ;;
                "start_interface") echo "Start interface:" ;;
                "restart_interface") echo "Restart interface:" ;;
                "disable_autostart") echo "Disable autostart:" ;;
                "enable_autostart_cmd") echo "Enable autostart:" ;;
                "cf_response_plus") echo "Cloudflare response: warp=plus — WARP+ is working!" ;;
                "recreating_account") echo "Old account detected. Recreating account to activate WARP+..." ;;
                "old_account_removed") echo "Old account removed." ;;
                *) echo "$key" ;;
            esac
            ;;
    esac
}

function ok {
    echo -e "\e[1;32m[OK]\e[0m $1"
}

function warn {
    echo -e "\e[1;33m[WARN]\e[0m $1"
}

function fail {
    echo -e "\e[1;31m[FAIL]\e[0m $1"
}

function info {
    echo -e "\e[1;34m[INFO]\e[0m $1"
}

function error_exit {
    fail "$1"
    exit 1
}

function l10n {
    local ru="$1"
    local en="$2"
    if [[ "$SCRIPT_LANG" == "ru" ]]; then
        echo "$ru"
    else
        echo "$en"
    fi
}

function curl_error_hint {
    local code="$1"
    case "$code" in
        6) l10n "DNS не смог разрешить имя хоста." "DNS could not resolve the hostname." ;;
        7) l10n "Не удалось подключиться к удалённому хосту." "Failed to connect to the remote host." ;;
        28) l10n "Таймаут запроса." "Request timed out." ;;
        35) l10n "Ошибка TLS/SSL рукопожатия." "TLS/SSL handshake error." ;;
        52) l10n "Пустой ответ от сервера." "Empty reply from server." ;;
        56) l10n "Соединение было сброшено во время передачи данных." "Connection was reset during data transfer." ;;
        *) l10n "Неизвестная ошибка curl." "Unknown curl error." ;;
    esac
}

if [[ $EUID -ne 0 ]]; then
    fail "This script must be run as root / Этот скрипт должен быть запущен от имени root"
    exit 1
fi

select_language

cd $HOME

info "$(msg "start_install")"
echo ""

info "$(msg "install_wireguard")"
apt update -qq &>/dev/null || error_exit "$(msg "update_failed")"
apt install wireguard -y &>/dev/null || error_exit "$(msg "wireguard_failed")"
ok "$(msg "wireguard_ok")"
echo ""

info "$(msg "temp_dns")"
echo ""

info "$(msg "download_wgcf")"
WGCF_RELEASE_URL="https://api.github.com/repos/ViRb3/wgcf/releases/latest"
WGCF_VERSION=$(curl -s "$WGCF_RELEASE_URL" | grep tag_name | cut -d '"' -f 4)

if [ -z "$WGCF_VERSION" ]; then
    error_exit "$(msg "wgcf_version_failed")"
fi

ARCH=$(uname -m)
case $ARCH in
    x86_64) WGCF_ARCH="amd64" ;;
    aarch64|arm64) WGCF_ARCH="arm64" ;;
    armv7l) WGCF_ARCH="armv7" ;;
    *) WGCF_ARCH="amd64" ;;
esac

info "$(msg "arch_detected") $ARCH -> $WGCF_ARCH"

WGCF_DOWNLOAD_URL="https://github.com/ViRb3/wgcf/releases/download/${WGCF_VERSION}/wgcf_${WGCF_VERSION#v}_linux_${WGCF_ARCH}"
WGCF_BINARY_NAME="wgcf_${WGCF_VERSION#v}_linux_${WGCF_ARCH}"

wget -q "$WGCF_DOWNLOAD_URL" -O "$WGCF_BINARY_NAME" || error_exit "$(msg "wgcf_download_failed")"
chmod +x "$WGCF_BINARY_NAME" || error_exit "$(msg "wgcf_chmod_failed")"
mv "$WGCF_BINARY_NAME" /usr/local/bin/wgcf || error_exit "$(msg "wgcf_move_failed")"
ok "wgcf $WGCF_VERSION $(msg "wgcf_installed")"
echo ""

info "$(msg "register_wgcf")"

echo ""
info "$(msg "warp_plus_prompt")"
read -p "$(msg "enter_license")" WARP_LICENSE

if [[ -n "$WARP_LICENSE" && -f wgcf-account.toml ]]; then
    warn "$(msg "recreating_account")"
    rm -f wgcf-account.toml wgcf-profile.conf
    ok "$(msg "old_account_removed")"
fi

if [[ -f wgcf-account.toml ]]; then
    info "$(msg "account_exists")"
else
    info "$(msg "registering")"
    info "$(msg "wgcf_binary_check")"
    
    if ! wgcf --help &>/dev/null; then
        warn "$(msg "wgcf_not_executable")"
        chmod +x /usr/local/bin/wgcf
        if ! wgcf --help &>/dev/null; then
            error_exit "$(msg "wgcf_not_executable")"
        fi
    fi
    
    output=$(timeout 60 bash -c 'yes | wgcf register' 2>&1)
    ret=$?
    
    if [[ $ret -ne 0 ]]; then
        warn "$(msg "register_error") $ret."
        
        if [[ $ret -eq 126 ]]; then
            warn "$(msg "wgcf_not_executable")"
        elif [[ $ret -eq 124 ]]; then
            warn "Registration timed out after 60 seconds."
        elif [[ "$output" == *"500 Internal Server Error"* ]]; then
            warn "$(msg "cf_500_detected")"
            info "$(msg "known_behavior")"
        elif [[ "$output" == *"429"* || "$output" == *"Too Many Requests"* ]]; then
            warn "$(msg "cf_rate_limited")"
        elif [[ "$output" == *"403"* || "$output" == *"Forbidden"* ]]; then
            warn "$(msg "cf_forbidden")"
        elif [[ "$output" == *"network"* || "$output" == *"connection"* ]]; then
            warn "$(msg "network_issue")"
        else
            warn "$(msg "unknown_error")"
            echo "$output"
        fi
        
        info "$(msg "trying_alternative")"
        echo | wgcf register &>/dev/null || true
        sleep 2
    fi
    
    if [[ ! -f wgcf-account.toml ]]; then
        error_exit "$(msg "registration_failed")"
    fi
    
    info "$(msg "account_created")"
fi

wgcf generate &>/dev/null || error_exit "$(msg "config_gen_failed")"
ok "$(msg "config_generated")"
echo ""

if [[ -n "$WARP_LICENSE" ]]; then
    info "$(msg "applying_license")"
    wgcf update --license-key "$WARP_LICENSE" &>/dev/null
    if [[ $? -eq 0 ]]; then
        ok "$(msg "license_applied")"
        wgcf generate &>/dev/null || error_exit "$(msg "config_gen_failed")"
        ok "$(msg "config_regenerated")"
    else
        warn "$(msg "license_failed")"
        info "$(msg "continuing_free")"
    fi
else
    info "$(msg "skipping_license")"
fi
echo ""

info "$(msg "edit_config")"
WGCF_CONF_FILE="wgcf-profile.conf"

if [ ! -f "$WGCF_CONF_FILE" ]; then
    error_exit "$(msg "config_not_found" | sed "s/не найден/Файл $WGCF_CONF_FILE не найден/" | sed "s/not found/File $WGCF_CONF_FILE not found/")"
fi

sed -i '/^DNS =/d' "$WGCF_CONF_FILE" || error_exit "$(msg "dns_failed")"

if grep -q '^MTU =' "$WGCF_CONF_FILE"; then
    sed -i "/^MTU =/aDNS = ${CUSTOM_DNS}" "$WGCF_CONF_FILE" || error_exit "$(msg "dns_failed")"
elif grep -q '^\[Interface\]' "$WGCF_CONF_FILE"; then
    sed -i "/^\[Interface\]/aDNS = ${CUSTOM_DNS}" "$WGCF_CONF_FILE" || error_exit "$(msg "dns_failed")"
else
    error_exit "$(msg "dns_failed")"
fi
ok "$(msg "dns_ok")"

if ! grep -q "Table = off" "$WGCF_CONF_FILE"; then
    sed -i '/^MTU =/aTable = off' "$WGCF_CONF_FILE" || error_exit "$(msg "table_off_failed")"
fi

if ! grep -q "PersistentKeepalive = 25" "$WGCF_CONF_FILE"; then
    sed -i '/^Endpoint =/aPersistentKeepalive = 25' "$WGCF_CONF_FILE" || error_exit "$(msg "keepalive_failed")"
fi

mkdir -p /etc/wireguard || error_exit "$(msg "wireguard_dir_failed")"
mv "$WGCF_CONF_FILE" /etc/wireguard/warp.conf || error_exit "$(msg "config_move_failed")"
ok "$(msg "config_saved")"
echo ""

info "$(msg "check_ipv6")"

is_ipv6_enabled() {
    sysctl net.ipv6.conf.all.disable_ipv6 2>/dev/null | grep -q ' = 0' || return 1
    sysctl net.ipv6.conf.default.disable_ipv6 2>/dev/null | grep -q ' = 0' || return 1
    ip -6 addr show scope global | grep -qv 'inet6 .*fe80::' || return 1
    return 0
}

if is_ipv6_enabled; then
    ok "$(msg "ipv6_enabled")"
else
    warn "$(msg "ipv6_disabled")"
    sed -i 's/,\s*[0-9a-fA-F:]\+\/128//' /etc/wireguard/warp.conf
    sed -i '/Address = [0-9a-fA-F:]\+\/128/d' /etc/wireguard/warp.conf
    ok "$(msg "ipv6_removed")"
fi
echo ""

info "$(msg "connect_warp")"
systemctl start wg-quick@warp &>/dev/null || error_exit "$(msg "connect_failed")"
ok "$(msg "warp_connected")"
echo ""

info "$(msg "check_status")"

if ! wg show warp &>/dev/null; then
    fail "$(msg "warp_not_found")"
    exit 1
fi
ok "$(l10n "Интерфейс warp найден." "WARP interface found.")"

if ip link show warp 2>/dev/null | grep -q "state UP"; then
    ok "$(l10n "Состояние интерфейса: UP." "Interface state: UP.")"
else
    warn "$(l10n "Состояние интерфейса не UP, продолжаем диагностику." "Interface state is not UP, continuing diagnostics.")"
fi

configured_dns=$(awk -F' *= *' '/^DNS *=/ {print $2; exit}' /etc/wireguard/warp.conf 2>/dev/null | xargs)
if [[ -n "$configured_dns" ]]; then
    info "$(l10n "DNS в warp.conf: ${configured_dns}" "DNS in warp.conf: ${configured_dns}")"
    if [[ "$configured_dns" == "$CUSTOM_DNS" ]]; then
        ok "$(l10n "DNS в конфиге совпадает с ${CUSTOM_DNS}." "Config DNS matches ${CUSTOM_DNS}.")"
    else
        warn "$(l10n "DNS в конфиге отличается от ${CUSTOM_DNS}." "Config DNS differs from ${CUSTOM_DNS}.")"
    fi
else
    warn "$(l10n "Параметр DNS в warp.conf не найден." "DNS parameter not found in warp.conf.")"
fi

peer_endpoint=$(wg show warp endpoints 2>/dev/null | awk 'NR==1 {print $2}')
if [[ -n "$peer_endpoint" && "$peer_endpoint" != "(none)" ]]; then
    info "$(l10n "Endpoint пира: ${peer_endpoint}" "Peer endpoint: ${peer_endpoint}")"
else
    warn "$(l10n "Endpoint пира не определён." "Peer endpoint is not defined.")"
fi

info "$(l10n "Проверяем handshake (до 20 секунд)..." "Checking handshake (up to 20 seconds)...")"
for i in {1..20}; do
    handshake_ts=$(wg show warp latest-handshakes 2>/dev/null | awk 'NR==1 {print $2}')
    if [[ "$handshake_ts" =~ ^[0-9]+$ ]] && (( handshake_ts > 0 )); then
        now_ts=$(date +%s)
        handshake_age=$((now_ts - handshake_ts))
        if (( handshake_age < 0 )); then
            handshake_age=0
        fi
        ok "$(msg "handshake_received") ~${handshake_age}s"
        ok "$(msg "warp_active")"
        break
    fi
    sleep 1
done

if [[ ! "$handshake_ts" =~ ^[0-9]+$ ]] || (( handshake_ts == 0 )); then
    warn "$(msg "handshake_failed")"
fi

trace_tmp_file=$(mktemp /tmp/warp-trace.XXXXXX)
trace_url="https://www.cloudflare.com/cdn-cgi/trace"
dns_http_ok=false

info "$(l10n "Тест 1/2: DNS + HTTP через hostname..." "Test 1/2: DNS + HTTP via hostname...")"
http_code=$(curl --interface warp -sS --max-time 15 -o "$trace_tmp_file" -w "%{http_code}" "$trace_url")
curl_rc=$?
if [[ $curl_rc -eq 0 ]]; then
    dns_http_ok=true
    ok "$(l10n "DNS работает: домен успешно разрешён." "DNS works: hostname resolved.")"
    if [[ "$http_code" == "200" ]]; then
        ok "$(l10n "HTTP через WARP работает (код ${http_code})." "HTTP via WARP works (code ${http_code}).")"
    else
        warn "$(l10n "HTTP через WARP вернул код ${http_code} (ожидали 200)." "HTTP via WARP returned code ${http_code} (expected 200).")"
    fi
else
    curl_hint=$(curl_error_hint "$curl_rc")
    warn "$(l10n "curl завершился с кодом ${curl_rc}: ${curl_hint}" "curl exited with code ${curl_rc}: ${curl_hint}")"
fi

info "$(l10n "Тест 2/2: HTTP в обход DNS (--resolve)." "Test 2/2: HTTP bypassing DNS (--resolve).")"
bypass_http_code=$(curl --interface warp -sS --max-time 15 --resolve www.cloudflare.com:443:1.1.1.1 -o /dev/null -w "%{http_code}" "$trace_url")
bypass_rc=$?
if [[ $bypass_rc -eq 0 ]]; then
    if [[ "$bypass_http_code" == "200" ]]; then
        ok "$(l10n "HTTP в обход DNS работает (код ${bypass_http_code})." "HTTP bypassing DNS works (code ${bypass_http_code}).")"
    else
        warn "$(l10n "HTTP в обход DNS вернул код ${bypass_http_code}." "HTTP bypassing DNS returned code ${bypass_http_code}.")"
    fi
else
    bypass_hint=$(curl_error_hint "$bypass_rc")
    warn "$(l10n "Тест в обход DNS провалился, curl код ${bypass_rc}: ${bypass_hint}" "Bypass DNS test failed, curl code ${bypass_rc}: ${bypass_hint}")"
fi

if [[ "$dns_http_ok" == false && $bypass_rc -eq 0 ]]; then
    warn "$(l10n "Похоже, проблема именно в DNS/резолве." "It looks like the issue is DNS resolution.")"
fi

if [[ $curl_rc -eq 0 ]]; then
    curl_result=$(grep "^warp=" "$trace_tmp_file" | head -n1 | cut -d= -f2 | tr -d '\r')
    if [[ "$curl_result" == "plus" ]]; then
        ok "$(msg "cf_response_plus")"
    elif [[ "$curl_result" == "on" ]]; then
        ok "$(msg "cf_response")"
    elif [[ -n "$curl_result" ]]; then
        warn "$(l10n "Cloudflare trace вернул warp=${curl_result}." "Cloudflare trace returned warp=${curl_result}.")"
    else
        warn "$(l10n "Cloudflare trace не содержит поля warp=." "Cloudflare trace does not contain warp= field.")"
    fi
else
    warn "$(msg "cf_not_confirmed")"
fi
rm -f "$trace_tmp_file"

wgcf_account_type=$(wgcf status 2>/dev/null | grep -i "Account type" | awk -F': ' '{print $2}' | xargs)
if [[ "$wgcf_account_type" == "unlimited" ]]; then
    ok "$(msg "warp_plus_active")"
elif [[ -n "$wgcf_account_type" ]]; then
    info "$(msg "warp_free_active")"
fi
echo ""

info "$(msg "enable_autostart")"
systemctl enable wg-quick@warp &>/dev/null || error_exit "$(msg "autostart_failed")"
ok "$(msg "autostart_enabled")"
echo ""

ok "$(msg "installation_complete")"
echo ""
echo -e "\e[1;36m➤ $(msg "check_service"): \e[0msystemctl status wg-quick@warp"
echo -e "\e[1;36m➤ $(msg "show_info"): \e[0mwg show warp"
echo -e "\e[1;36m➤ $(msg "stop_interface"): \e[0msystemctl stop wg-quick@warp"
echo -e "\e[1;36m➤ $(msg "start_interface"): \e[0msystemctl start wg-quick@warp"
echo -e "\e[1;36m➤ $(msg "restart_interface"): \e[0msystemctl restart wg-quick@warp"
echo -e "\e[1;36m➤ $(msg "disable_autostart"): \e[0msystemctl disable wg-quick@warp"
echo -e "\e[1;36m➤ $(msg "enable_autostart_cmd"): \e[0msystemctl enable wg-quick@warp"
echo ""
