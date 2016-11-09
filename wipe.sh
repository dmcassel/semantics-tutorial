#!/bin/bash

USERNAME=admin
PASSWORD=admin
CURL="curl --digest --user $USERNAME:$PASSWORD"

echo "Removing appserver and databases"
$CURL -X DELETE -i "http://localhost:8002/v1/rest-apis/semantics-tutorial?include=content&include=modules"
