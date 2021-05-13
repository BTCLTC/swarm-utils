
function getRuntimeConfigFiles() {
    configs="$(ps -ef | grep 'bee start --config' | grep -v SCREEN | egrep -o '\-\-config=.*\.yaml' | grep -v grep | sed s/\-\-config=//g | sort | uniq)"
    configs="$(ps -ef | grep 'bee start --config' | grep -v SCREEN | egrep -o '\-\-config=.*\.yaml' | grep -v grep | sed s/\-\-config=//g | sort | uniq)"
    echo "$configs"
}

function getDebugApiPort() {
    config="$1"
    debug_api_port="$(cat $c | grep 'debug-api-addr' | sed s/debug\-api\-addr://g | egrep -o '\:[0-9]+' | egrep -o '[0-9]+')" 
    echo $debug_api_port
}

function getDebugApi() {
    config="$1"
    echo http://localhost:$(getDebugApiPort "$config")
}