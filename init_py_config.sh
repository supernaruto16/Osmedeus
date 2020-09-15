install_banner() {
    name=$1
    echo -e "\033[1;32m[+] Installing $name \033[1;37m"
}

install_banner "Initial config for Osmedeus"
chmod +x osmedeus.py
mkdir -p ~/.osmedeus 2>/dev/null
python3 server/manage.py makemigrations
python3 server/manage.py migrate
python3 server/manage.py makemigrations api
python3 server/manage.py migrate api
python3 scripts/init.py
python3 scripts/reload.py