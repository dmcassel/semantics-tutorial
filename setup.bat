set MLCP=.\mlcp-8.0-5\bin\mlcp.bat
set USERNAME=admin
set PASSWORD=admin
set CURL=.\curl\curl.exe --digest --user %USERNAME%:%PASSWORD%
set PWD=%~dp0
set PWD=%PWD:\=/%
PORT=8010

echo off

rem setup the database and apperserver.
echo "Setting up appserver and databases"
%CURL% -X POST -Hcontent-type:application/json -d@rest/appserver-properties.json "http://localhost:8002/v1/rest-apis"

echo "Configuring database"
%CURL% -X PUT -Hcontent-type:application/json -d@rest/database-properties.json "http://localhost:8002/manage/v2/databases/semantics-tutorial-content/properties"

echo "Installing the semantic extensions"
%CURL% -X PUT -Hcontent-type:application/javascript -d@rest/inferringQuery.sjs http://localhost:%PORT%/v1/config/resources/inferringQuery
%CURL% -X PUT -Hcontent-type:application/javascript -d@rest/semanticExtension.sjs http://localhost:%PORT%/v1/config/resources/semanticExtension

echo "Installing HTML"
%CURL% -X PUT -Hcontent-type:text/html --data-binary "@src/tutorial.html" ^
  "http://localhost:%PORT%/v1/documents?uri=/tutorial.html&database=semantics-tutorial-modules"
%CURL% -X PUT -Hcontent-type:text/html --data-binary "@src/test-scratch.html" ^
  "http://localhost:%PORT%/v1/documents?uri=/test-scratch.html&database=semantics-tutorial-modules"

echo "loading data..."
%MLCP% IMPORT -input_file_path data -username %USERNAME% -password %PASSWORD% -host localhost -port %PORT% -output_uri_replace "/%PWD%data/json,'',/%PWD%data/xml,'',/%PWD%data/xml/triples,''" -output_collections "http://marklogic.com/semantics#default-graph","mlw16"

echo "Finished loading data"
pause
