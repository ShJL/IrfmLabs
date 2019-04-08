#!/bin/bash

export FLASK_DEBUG=0
export FLASK_APP=flask_server.py
if [[ "$1" == "-d" || "$1" == "--debug" ]]; then
    export FLASK_DEBUG=1
fi

python -m flask run --host=0.0.0.0