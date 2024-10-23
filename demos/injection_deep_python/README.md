# Demo "Deep injection into a Python app"
This script uses a python app and configures opentelemetry to inject into the app and continue tracing.
## Script
```sh
export OTEL_SHELL_CONFIG_INJECT_DEEP=TRUE
. otel.sh
python3 -m venv venv
. venv/bin/activate
pip install requests
python script.py
deactivate
rm -rf venv
```
## Trace Structure Overview
```
bash -e demo.sh
  python3 -m venv venv
  [ -n  ]
  [ -n  ]
  [ -n /usr/bin/bash -o -n  ]
  [ -n  ]
  [ ! nondestructive = nondestructive ]
  [ -n  ]
  [ -z  ]
  [ -n /usr/bin/bash -o -n  ]
  /home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_python/venv/bin/python3 /home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_python/venv/bin/pip install requests
  python script.py
    GET
  [ -n /snap/bin:/home/runner/.local/bin:/opt/pipx_bin:/home/runner/.cargo/bin:/home/runner/.config/composer/vendor/bin:/usr/local/.ghcup/bin:/home/runner/.dotnet/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin ]
  [ -n  ]
  [ -n /usr/bin/bash -o -n  ]
  [ -n  ]
  [ !  = nondestructive ]
  rm -rf venv
```
## Full Trace
```
```
