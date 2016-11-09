#!/bin/bash

MLCP="./mlcp-8.0-5/bin/mlcp.sh"
USERNAME=admin
PASSWORD=admin
CURL="curl --digest --user $USERNAME:$PASSWORD"
PWD=`pwd`
PORT=8010

## setup the database and appserver.
echo "Setting up appserver and databases"
$CURL -X POST -Hcontent-type:application/json -d@rest/appserver-properties.json "http://localhost:8002/v1/rest-apis"

# these two steps enable the triples index and can set the inference
# Really only needs to be done once
echo "Configuring database"
$CURL -X PUT -Hcontent-type:application/json -d@rest/database-properties.json "http://localhost:8002/manage/v2/databases/semantics-tutorial-content/properties"

echo "Installing the semantic extensions"
$CURL -X PUT -Hcontent-type:application/javascript -d@rest/inferringQuery.sjs http://localhost:$PORT/v1/config/resources/inferringQuery
$CURL -X PUT -Hcontent-type:application/javascript -d@rest/semanticExtension.sjs http://localhost:$PORT/v1/config/resources/semanticExtension

echo "Installing HTML"
$CURL -X PUT -Hcontent-type:text/html --data-binary "@src/tutorial.html" \
  "http://localhost:$PORT/v1/documents?uri=/tutorial.html&database=semantics-tutorial-modules"
$CURL -X PUT -Hcontent-type:text/html --data-binary "@src/test-scratch.html" \
  "http://localhost:$PORT/v1/documents?uri=/test-scratch.html&database=semantics-tutorial-modules"

echo "Loading Data..."
$MLCP IMPORT -input_file_path data -username $USERNAME -password $PASSWORD -host localhost -port $PORT -output_uri_replace "$PWD/data/json,'',$PWD/data/xml,'',$PWD/data/xml/triples,''" -output_collections "http://marklogic.com/semantics#default-graph","mlw16"
