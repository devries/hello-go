.PHONY: deps clean build package deploy destroy

deps:
	go get -u ./...

clean: 
	rm -rf ./build/hello-world
	
build/hello-world: hello-world/main.go go.mod go.sum
	GOOS=linux GOARCH=amd64 go build -o build/hello-world ./hello-world

build: build/hello-world

package: packaged.yaml

packaged.yaml: build/hello-world template.yaml
	sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket devries-sam-learning

deploy: packaged.yaml
	sam deploy --template-file packaged.yaml --stack-name hello-go --capabilities CAPABILITY_IAM

destroy:
	aws cloudformation delete-stack --stack-name hello-go
