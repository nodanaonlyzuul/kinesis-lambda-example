# Kinesis Lambda Example

A demo of deploying a kinesis stream + lambda to AWS, using the
[serverless framework](https://serverless.com).

## Requirements

1.  npm (tested with v12.18.4)
2.  docker
3.  serverless framework (`npm install -g serverless`)
4.  AWS CLI

## Installing

1.  Pull this repository.
2.  `npm install`
3.  `bundle install --standalone --path vendor/bundle` (required by serverless-ruby-package plugin)

## Deploying and Running

### 1: Create the Kinesis Stream

```shell
export REGION=<REGION NAME>
export PROFILE=<AWS PROFILE>

aws cloudformation create-stack \
--stack-name kinesis-lambda-example-stream \
--template-body file://cloud-formation-templates/kinesis-stream.yml \
--region $REGION \
--profile $PROFILE
```

_This can take a minute to create the stream. View progress in AWS management console._

### 2: Deploy The Lambda

```shell
serverless deploy --region $REGION --aws-profile $PROFILE
```

## Publishing Data to the stream

```shell
aws kinesis put-record \
    --stream-name kinesis-lambda-example-stream\
    --data $(echo '{"first_name": "Mister", "last_name": "Whiskers"}' | base64 ) \
    --partition-key foo \
    --region $REGION \
    --profile $PROFILE
```

## Cleaning up After Yourself

### Remove the Lambda

```shell
serverless remove --region $REGION --aws-profile $PROFILE
```

### Remove the Stream

```shell
aws cloudformation delete-stack \
--stack-name kinesis-lambda-example-stream \
--region $REGION \
--profile $PROFILE
```

## Running Locally

### On Local Host (FAST!)

    serverless invoke local --function hello --path ./resources/fake-lambda-message.json

### In a Container (Still pretty fast!)

This will package dependencies the same way it would for a release.

    serverless invoke local --docker --function hello --path ./resources/fake-lambda-message.json

This will hang if it throws an exception. The container will stay alive.
That's good! It allows you to do:

    docker logs -f <container SHA>
