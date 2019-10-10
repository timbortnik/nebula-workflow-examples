# Custom Step Tutorial

This workflow provides a Tutorial of writing your own steps in Nebula. Use it to familiarize yourself 
with the features built-in to Nebula to get access to things like parameters, secrets, and outputs. 

The workflow should appear on the **Workflows** page in your Nebula web interface. If you don't see it there, add the workflow from our [examples repo](https://github.com/puppetlabs/nebula-workflow-examples/tree/master/example-workflows/sample-workflow) on GitHub.

## Running the Workflow 
Follow these steps to run the workflow:
1. Add your sample "secret" to the workflow as a secret.
   1. Click **Edit** > **Secrets**.
   2. Click **Define new secret** and use the following values:
      - **KEY**: `secret`
      - **VALUE**: `this is a fake secret`
2. Configure your workflow parameters.
   1. Click **Run** and enter the following parameters:
      - **name**: Enter your name.

## Using the Tutorial 
You can access the following information from the sample workflow run page:
-  Click **Graph** to view a visualization of the workflow and a description of each step.
-  Click **Code and data** to view the YAML and see how to use different Nebula features.
-  Click **Logs** and select a step to view the log output for that step. 


