# Deploy a serverless application with Stackery 

This workflow demonstrates how to deploy a multi-component serverless application to AWS using Stackery.

Stackery helps teams quickly build and manage serverless infrastructure. It features a set of development and operations tools for engineers building production serverless applications. It consists of a web-based  [Dashboard](https://docs.stackery.io/docs/using-stackery/dashboard)  and a  [command line](https://docs.stackery.io/docs/using-stackery/cli)  (CLI) tool as well as the  [Stackery Role](https://docs.stackery.io/docs/using-stackery/security-permissions-and-controls) , which is a group of resources allowing it to be linked with a user’s AWS account(s). These tools are used to manage production serverless applications throughout their lifecycle, particularly in the case of a team workflow where different developers have different permissions sets, environments, and other configurations.

For more information on Stackery, check out the [introduction to Stackery](https://docs.stackery.io/docs/using-stackery/introduction/). 

Project Nebula supports Stackery applications by coordinating the deployment of multiple serverless components, along with notification and change management tools such as Slack.

In this workflow, you will:
* Deploy a serverless API application with Stackery 
* Deploy a frontend static website to S3 
* Notify your team with Slack

