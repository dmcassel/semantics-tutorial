#Semantics Tutorial Project

This project contains data, queries, and a demo application to use during a
MarkLogic semantics tutorial.

It is a super quick-and-dirty MarkLogic application.

It uses a single HTML file, tutorial.html, and a MarkLogic REST server
on port 8010. Data will be loaded into a semantics-tutorial-content database,
built by the setup script.

#requires

* java
* curl  (provided for Windows)
* scripting ( sh or .bat )
* MarkLogic 8.0-2 or newer installed, running

#Quickstart

```
sh setup.sh
```

OR, on Windows

```
setup.bat
```

After this, you can look at the application at

http://localhost:8010/tutorial.html

# Query Console

The queries directory holds a group of Query Console workspaces for working
with the data. Point your browser to http://localhost:8000/qconsole to see
Query Console. To load a workspace, click the drop-down list in the upper
right, then click Import Workspace. Select one of the XML files in the queries
directory and click Import. Start with mlw-sw-explore-triples.xml for semantic
queries that help understand the dataset that has been loaded.

#Contents

The HTML page at tutorial.html, invokes SPARQL queries or an extension
depending on which form is used.  The setup will have been installed by the
setup script.  Since MarkLogic serves this page directly from the filesystem,
you can edit it, save it and refresh your browser to see changes in the app.

Dring setup, the MLCP utility loads data from data/  There is JSON, and XML
data in this directory.  Some of the XML files are dumps of the internal
triples format of MarkLogic managed triples.

The `queries` directory contains qconsole workspaces, which can be imported from [QConsole|http://localhost:8000/qconsole].

