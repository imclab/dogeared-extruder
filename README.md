dogeared-extruder
==

This is a meant to be a simple HTTP Pony to wrap the `boilerpipe` and `Tika` and
clones of the `readability` text extraction libraries using the `dropwizard`
framework.

To start the server:
   
	$> cd dogeared-extruder
	$> make build
	... JAVA STUFF ...
	$> java -jar target/extruder-1.0.jar server
	... MOAR JAVA STUFF ...
	INFO  [2013-08-30 12:49:12,184] org.eclipse.jetty.server.AbstractConnector: Started InstrumentedBlockingChannelConnector@0.0.0.0:8080
	INFO  [2013-08-30 12:49:12,189] org.eclipse.jetty.server.AbstractConnector: Started SocketConnector@0.0.0.0:8081

And then you can pass it URLs as `GET` parameters:
  
	$> curl 'http://localhost:8080/boilerpipe?url=SOME_URL'

	$> curl 'http://localhost:8080/java-readability?url=SOME_URL'

	$> curl 'http://localhost:8080/tika?url=SOME_URL_DOT_PDF'

It also supports local files via `POST` uploads:

	$> curl -X POST -F "file=@SOME_FILE.html" http://localhost:8080/boilerpipe

	$> curl -X POST -F "file=@SOME_FILE.html" http://localhost:8080/java-readability

	$> curl -X POST -F "file=@SOME_FILE.pdf" http://localhost:8080/tika 

By default the server will return HTML but if you pass an `Accept:
application/json` header you'll get a big old blob of JSON instead.

	$> curl -H 'Accept:application/json' 'http://localhost:8080/boilerpipe?url=SOME_URL'

Notes
--

* It works but I am not a Java person so I am still fumbling my way around this foreign land.

* The text/content extraction is pretty heavy-handed and relies on the
  underlying libraries to do the right thing. Currently everything returns
  blocks of plain text so things like lists and code samples will probably be
  mangled. This is not ideal but that stuff is meant to be handled going forward.

* If you look carefully at the URLs above and the actual classes that define the
  functionality they all look basically the same save for the names of the
  extraction tools. For the time being I think the classes (and URLs) should
  remain separate if only to keep things simple(r) while everything else is
  sorted out.

* There is also a [separate
branch](https://github.com/straup/dogeared-extruder/tree/snacktory) that uses
the `snacktory` readability clone but it has not been merged in to master yet. I
can't remember why except that I was having trouble getting it to work and
decided to try the `java-readability` library instead.

* You can also type `make exec` to recompile the code and launch the server in
  foreground mode, which is useful for debugging things.

Dependencies
--

* You will need to have [maven](https://maven.apache.org/what-is-maven.html) installed to manage the build process.

To do
--

Aside from stuff listed in the [TODO.txt](TODO.txt) file:

* Try to be smarter about extracting or generating a page title for HTML
 output. Currently the code does not try to parse HTML input for title and
 simply parrots the basename of the input URL and/or relies on Tika's internal
 metadata parser.
* A resource endpoint that calls the `readability.com` API

See also
--

* http://code.google.com/p/boilerpipe/
* https://tika.apache.org/
* https://github.com/basis-technology-corp/Java-readability
* https://github.com/karussell/snacktory
