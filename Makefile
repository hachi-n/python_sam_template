.PHONY: build

# sam validate bug. https://github.com/aws/aws-sam-cli #1932
export AWS_DEFAULT_REGION=ap-northeast-1

build-layer: 
	./script/build.sh
build:
	sam build
test:
	sam local invoke
validate:
	sam validate --profile ${ProfileName}

package: 
	sam package \
	    --template-file template.yaml \
	    --s3-bucket ${S3_BucketName} \
	    --output-template-file packaged.yaml \
	    --profile ${ProfileName}

deploy: 
	sam deploy \
	    --profile ${ProfileName} \
	    --region ap-northeast-1  \
	    --template-file ./packaged.yaml \
	    --stack-name ${CloudFormationStackName} \
	    --capabilities CAPABILITY_IAM \
	    --parameter-overrides IdentityNameParameter=${IdentityParameter}
all: 
	$(MAKE) build
	$(MAKE) validate
	$(MAKE) package
	$(MAKE) deploy

dev_tools_install:
	 pip install pipenv
	 pipenv --python 3.7

