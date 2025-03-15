export GRADLE_HOME=/opt/gradle/latest
export PATH="$GRADLE_HOME"/bin:"$PATH"
export OTEL_SHELL_CONFIG_INJECT_DEEP=TRUE
. otel.sh
gradle init <<< /dev/null
