export OTEL_SHELL_CONFIG_INJECT_DEEP=TRUE
. otel.sh
python3 -m venv venv
. venv/bin/activate
pip install requests
python script.py
deactivate
rm -rf venv
