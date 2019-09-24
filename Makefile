.PHONY: deps clean build

deps:
	go get -u ./...

clean: 
	rm -rf ./build/hello-world
	
build:
	GOOS=linux GOARCH=amd64 go build -o build/hello-world ./hello-world
