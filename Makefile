exec:
	mvn clean
	mvn compile exec:java

build: todo
	mvn clean
	mvn install

run:
	java -jar target/extruder-1.0.jar server

todo:
	echo "# Generated automatically at" `date` > TODO.txt
	echo "" >> TODO.txt
	grep -n -r -e TODO ./src >> TODO.txt
	grep -n -r -e TO\ DO ./src >> TODO.txt
