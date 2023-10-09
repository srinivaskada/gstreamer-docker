#!/bin/bash
docker-compose down

docker build -t app-gstreamer .

docker-compose up