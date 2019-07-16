#!/bin/bash

export EXTERNAL_IP=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)

python3 manage.py makemigrations
python3 manage.py migrate


gunicorn right_move.wsgi:application -b 0.0.0.0:80
