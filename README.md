# docker-aws-cdk
setup portable / non-polluting  execution enviornment for aws cdk projects STRICTLY for DEV purposes.
The issue we are trying to solve here is to have a docker container have all the correct node packages and config in order to execute AWS cdk commands

## Steps
Edit the included Dockerfile file as required (versions etc)

## build
```
docker build -t <name> .  e.g docker build -t randhawp/cdk .
```
## run the docker image
This is a DinD config, docker in docker, as docker is required by the cdk deploy command to make the image
```
docker run -it --privileged  -v ~/projects:/home/puneet/projects/ -p 3000:3000 randhawp/cdk  dockerd  
```
## find the container id
```
docker ps
```

## security access to aws
certain cdk actions like bootstrap . deploy etc require access to IAM with cli access permissions
IF docker IS NOT being saved the credential files can be copied across from host to docker 
These can be added to Dockerfile but it better be a manual action
```
puneet@x-01:~/projects/cdk$ docker cp  /home/puneet/.aws/config 003dfea83fb5:/root/ 
Successfully copied 2.05kB to 003dfea83fb5:/root/
puneet@x-01:~/projects/cdk$ docker cp  /home/puneet/.aws/credentials 003dfea83fb5:/root/ 
Successfully copied 2.05kB to 003dfea83fb5:/root/

```
If config is not provided then it will be executed in the default region us-east-1

## creating a cdk project
go to the dir where the cdk project is to be built and run
```
docker exec -w /home/puneet/projects/cdk/hello-cdk <running cdk docker container id> cdk init app --language typescript  (-w does the trick of changing to empty folder for cdk init)
```


## example command and output of bootstrap without config 
```
docker exec -w /home/puneet/projects/cdk/hello-cdk 472b cdk bootstrap --region us-east-2 

 ⏳  Bootstrapping environment aws://<accountid>/us-east-1...
Using default execution policy of 'arn:aws:iam::aws:policy/AdministratorAccess'. Pass '--cloudformation-execution-policies' to customize.
Trusted accounts for deployment: (none)
Trusted accounts for lookup: (none)
CDKToolkit: creating CloudFormation changeset...
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_COMPLETE      | AWS::ECR::Repository    | ContainerAssetsRepository 
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::S3::Bucket         | StagingBucket Resource creation Initiated
CDKToolkit |  1/12 | 8:49:58 PM | REVIEW_IN_PROGRESS   | AWS::CloudFormation::Stack | CDKToolkit User Initiated
CDKToolkit |  1/12 | 8:50:04 PM | CREATE_IN_PROGRESS   | AWS::CloudFormation::Stack | CDKToolkit User Initiated
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::ECR::Repository    | ContainerAssetsRepository 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | LookupRole 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::SSM::Parameter     | CdkBootstrapVersion 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | FilePublishingRole 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::S3::Bucket         | StagingBucket 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | CloudFormationExecutionRole 
CDKToolkit |  1/12 | 8:50:08 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | ImagePublishingRole 
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | FilePublishingRole Resource creation Initiated
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::SSM::Parameter     | CdkBootstrapVersion Resource creation Initiated
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::ECR::Repository    | ContainerAssetsRepository Resource creation Initiated
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | CloudFormationExecutionRole Resource creation Initiated
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | LookupRole Resource creation Initiated
CDKToolkit |  1/12 | 8:50:09 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | ImagePublishingRole Resource creation Initiated
CDKToolkit |  2/12 | 8:50:09 PM | CREATE_COMPLETE      | AWS::SSM::Parameter     | CdkBootstrapVersion 
CDKToolkit |  2/12 | 8:50:19 PM | CREATE_IN_PROGRESS   | AWS::S3::Bucket         | StagingBucket Eventual consistency check initiated
CDKToolkit |  2/12 | 8:50:20 PM | CREATE_IN_PROGRESS   | AWS::S3::BucketPolicy   | StagingBucketPolicy 
CDKToolkit |  2/12 | 8:50:21 PM | CREATE_IN_PROGRESS   | AWS::S3::BucketPolicy   | StagingBucketPolicy Resource creation Initiated
CDKToolkit |  3/12 | 8:50:21 PM | CREATE_COMPLETE      | AWS::S3::BucketPolicy   | StagingBucketPolicy 
CDKToolkit |  4/12 | 8:50:26 PM | CREATE_COMPLETE      | AWS::IAM::Role          | FilePublishingRole 
CDKToolkit |  5/12 | 8:50:26 PM | CREATE_COMPLETE      | AWS::IAM::Role          | CloudFormationExecutionRole 
CDKToolkit |  6/12 | 8:50:27 PM | CREATE_COMPLETE      | AWS::IAM::Role          | ImagePublishingRole 
CDKToolkit |  7/12 | 8:50:27 PM | CREATE_COMPLETE      | AWS::IAM::Role          | LookupRole 
CDKToolkit |  7/12 | 8:50:27 PM | CREATE_IN_PROGRESS   | AWS::IAM::Policy        | FilePublishingRoleDefaultPolicy 
CDKToolkit |  7/12 | 8:50:27 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | DeploymentActionRole 
CDKToolkit |  7/12 | 8:50:28 PM | CREATE_IN_PROGRESS   | AWS::IAM::Policy        | ImagePublishingRoleDefaultPolicy 
CDKToolkit |  7/12 | 8:50:28 PM | CREATE_IN_PROGRESS   | AWS::IAM::Policy        | FilePublishingRoleDefaultPolicy Resource creation Initiated
CDKToolkit |  7/12 | 8:50:28 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | DeploymentActionRole Resource creation Initiated
CDKToolkit |  7/12 | 8:50:29 PM | CREATE_IN_PROGRESS   | AWS::IAM::Policy        | ImagePublishingRoleDefaultPolicy Resource creation Initiated
CDKToolkit |  8/12 | 8:50:32 PM | CREATE_COMPLETE      | AWS::S3::Bucket         | StagingBucket 
CDKToolkit |  9/12 | 8:50:44 PM | CREATE_COMPLETE      | AWS::IAM::Policy        | FilePublishingRoleDefaultPolicy 
CDKToolkit | 10/12 | 8:50:45 PM | CREATE_COMPLETE      | AWS::IAM::Policy        | ImagePublishingRoleDefaultPolicy 
CDKToolkit | 11/12 | 8:50:46 PM | CREATE_COMPLETE      | AWS::IAM::Role          | DeploymentActionRole 
CDKToolkit | 12/12 | 8:50:48 PM | CREATE_COMPLETE      | AWS::CloudFormation::Stack | CDKToolkit 
 ✅  Environment aws://<accoutid>/us-east-1 bootstrapped.

```
## deploy the code

```
docker exec -w /home/puneet/projects/cdk/hello-cdk <id of the randhawp/cdk docker> cdk deploy --require-approval never

```
### ouput

```
lap-01:~/projects/cdk/hello-cdk$ docker exec -w /home/puneet/projects/cdk/hello-cdk c2046b0c0c9f  cdk  deploy --require-approval never

✨  Synthesis time: 2s

HelloCdkStack: deploying... [1/1]
HelloCdkStack: creating CloudFormation changeset...
HelloCdkStack | 0/6 | 9:19:28 PM | REVIEW_IN_PROGRESS   | AWS::CloudFormation::Stack | HelloCdkStack User Initiated
HelloCdkStack | 0/6 | 9:19:34 PM | CREATE_IN_PROGRESS   | AWS::CloudFormation::Stack | HelloCdkStack User Initiated
HelloCdkStack | 0/6 | 9:19:36 PM | CREATE_IN_PROGRESS   | AWS::CDK::Metadata      | CDKMetadata/Default (CDKMetadata) 
HelloCdkStack | 0/6 | 9:19:36 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | DockerFunc/ServiceRole (DockerFuncServiceRole8031C1C5) 
HelloCdkStack | 0/6 | 9:19:37 PM | CREATE_IN_PROGRESS   | AWS::IAM::Role          | DockerFunc/ServiceRole (DockerFuncServiceRole8031C1C5) Resource creation Initiated
HelloCdkStack | 0/6 | 9:19:37 PM | CREATE_IN_PROGRESS   | AWS::CDK::Metadata      | CDKMetadata/Default (CDKMetadata) Resource creation Initiated
HelloCdkStack | 1/6 | 9:19:37 PM | CREATE_COMPLETE      | AWS::CDK::Metadata      | CDKMetadata/Default (CDKMetadata) 
HelloCdkStack | 2/6 | 9:19:53 PM | CREATE_COMPLETE      | AWS::IAM::Role          | DockerFunc/ServiceRole (DockerFuncServiceRole8031C1C5) 
HelloCdkStack | 2/6 | 9:19:54 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Function   | DockerFunc (DockerFuncF47DA747) 
HelloCdkStack | 2/6 | 9:19:55 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Function   | DockerFunc (DockerFuncF47DA747) Resource creation Initiated
HelloCdkStack | 2/6 | 9:19:56 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Function   | DockerFunc (DockerFuncF47DA747) Eventual consistency check initiated
HelloCdkStack | 2/6 | 9:19:56 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Permission | DockerFunc/invoke-function-url (DockerFuncinvokefunctionurlB084CBAE) 
HelloCdkStack | 2/6 | 9:19:56 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Url        | DockerFunc/FunctionUrl (DockerFuncFunctionUrlFE69B12B) 
HelloCdkStack | 2/6 | 9:19:57 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Permission | DockerFunc/invoke-function-url (DockerFuncinvokefunctionurlB084CBAE) Resource creation Initiated
HelloCdkStack | 2/6 | 9:19:57 PM | CREATE_IN_PROGRESS   | AWS::Lambda::Url        | DockerFunc/FunctionUrl (DockerFuncFunctionUrlFE69B12B) Resource creation Initiated
HelloCdkStack | 3/6 | 9:19:57 PM | CREATE_COMPLETE      | AWS::Lambda::Permission | DockerFunc/invoke-function-url (DockerFuncinvokefunctionurlB084CBAE) 
HelloCdkStack | 4/6 | 9:19:57 PM | CREATE_COMPLETE      | AWS::Lambda::Url        | DockerFunc/FunctionUrl (DockerFuncFunctionUrlFE69B12B) 
arn:aws:cloudformation:us-east-2:901844595673:stack/HelloCdkStack/294ebd10-066e-11ef-8765-0a67550feeaf
HelloCdkStack | 5/6 | 9:20:12 PM | CREATE_COMPLETE      | AWS::Lambda::Function   | DockerFunc (DockerFuncF47DA747) 
HelloCdkStack | 6/6 | 9:20:13 PM | CREATE_COMPLETE      | AWS::CloudFormation::Stack | HelloCdkStack 

 ✅  HelloCdkStack

✨  Deployment time: 48.31s

Outputs:
HelloCdkStack.FunctionUrlValue = https://odzgtiuj7ckbyeasupkya6ke2q0trudb.lambda-url.us-east-2.on.aws/
Stack ARN:

## making changes etc
After making changes to the cdk app e.g the docker container holding the app , just call the cdk deploy command again and it will build the docker image and publish it to the lambda / ecr

✨  Total time: 50.31s


```
