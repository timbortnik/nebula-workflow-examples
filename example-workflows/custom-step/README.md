# Custom step tutorial

This workflow provides a brief tutorial on writing your own steps in Nebula. Use
it to gain an understanding of built-in features like parameters,
secrets, and outputs.

The workflow should appear on the **Workflows** page in your Nebula web interface. If you don't see it there, add the workflow from our [examples repo](https://github.com/puppetlabs/nebula-workflow-examples/tree/master/example-workflows/sample-workflow) on GitHub.

## Running the workflow 
Follow these steps to run the workflow:
1. Add your sample "secret" to the workflow as a secret.
   1. Click **Edit** > **Secrets**.
   2. Click **Define new secret** and use the following values:
      - **KEY**: `secret`
      - **VALUE**: `this is a fake secret`
2. Configure your workflow parameters.
   1. Click **Run** and enter the following parameters:
      - **name**: Enter your name.

## Using the tutorial 
After you run the workflow, take a look at the logs for each step to read about
what happened.

You can access the following information from the sample workflow run page:
-  Click **Graph** to view a visualization of the workflow and a description of each step.
-  Click **Code and data** to view the YAML and see how to use different Nebula features.
-  Click **Logs** and select a step to view the log output for that step. 

For reference, here is a copy of the workflow:
```yaml
version: v1
description: Custom step tutorial 

parameters:
  name:
    description: what's your name?
  
steps:
- name: introduction
  image: projectnebula/core
  input: 
  -  echo "-------------- INTRODUCTION --------------"
  -  echo "Nebula provides the ability to create custom steps"
  -  echo ""
  -  echo "Ni is a tool in the projectnebula/core image that gives you access to things"
  -  echo "like spec parameters, outputs, and secrets."
  -  echo ""
  -  echo "Let's see what we can do with them."

- name: parameters
  image: projectnebula/core
  dependsOn: introduction
  input: 
  -  echo "-------------- PARAMETERS --------------"
  -  echo "First, let's start with getting your name."
  -  NAME=$(ni get -p {.name})
  -  echo ""
  -  echo "Your name is ${NAME}" 
  -  echo ""
  -  echo "We got this from passing the parameter from the Workflow to the Step through the spec parameter."
  spec: 
    name:
      $type: Parameter
      name: name

- name: secrets 
  image: projectnebula/core
  dependsOn: parameters
  input:
  -  echo "-------------- SECRETS --------------"
  -  echo "Next, let's get a secret"
  -  SECRET=$(ni get -p {.secret})
  -  echo ""
  -  echo "Your secret is ${SECRET}"
  -  echo ""
  -  echo "You can define a secret by declaring the parameter as \$type Secret which must be defined in the Workflow Secrets"
  -  echo "Within the Step, both plaintext parameters and secrets are accessed the same way"
  spec:
    secret:
      $type: Secret
      name: secret

- name: outputs
  image: projectnebula/core
  dependsOn: secrets
  input: 
  -  echo "-------------- OUTPUTS --------------"
  -  echo "Next, let's define an output."
  -  echo "An output can be defined in one step and consumed in a subsequent step."
  -  echo ""
  -  echo "Setting value..."
  -  echo "KEY = key"
  -  echo "VALUE = You are awesome!"
  -  ni output set --key "key" --value "You are awesome"

- name: end 
  image: projectnebula/core
  dependsOn: outputs
  input: 
  -  echo "-------------- OUTPUTS --------------"
  -  echo "Here's where we can use the output of the previous step"
  -  echo "You pass in the output value through the input spec parameters and reference it like any other parameter."
  -  OUTPUT=$(ni get -p {.output})
  -  echo ""
  -  echo "Echoing output from previous step..."
  -  echo "${OUTPUT}"
  -  echo ""
  -  echo "Thanks for trying this workflow!" 
  spec: 
    output:
      $type: Output
      name: key
      taskName: outputs
    confetti: true
```   