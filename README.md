

# Jenkins Master and Slave Setup

1. Add credentials 
2. Add node
   
### Add Credentials 
1. Manage Jenkins --> Manage Credentials --> System --> Global credentials --> Add credentials
2. Provide the below info to add credentials   
   kind: `ssh username with private key`  
   Scope: `Global`     
   ID: `maven_slave`    
   Username: `ec2-user`  
   private key: `dpo.pem key content`  

### Add node 
   Follow the below setups to add a new slave node to the jenkins 
1. Goto Manage Jenkins --> Manage nodes and clouds --> New node --> Permanent Agent    
2. Provide the below info to add the node   
   Number of executors: `3`   
   Remote root directory: `/home/ec2-user/jenkins`  
   Labels: `maven`  
   Usage: `Use this node as much as possible`  
   Launch method: `Launch agents via SSH`  
        Host: `<Private_IP_of_Slave>`  
        Credentials: `<Jenkins_Slave_Credentials>`     
        Host Key Verification Strategy: `Non verifying Verification Strategy`     
   Availability: `Keep this agent online as much as possible`

   # Enable Webhook
1. Install "multibranch scan webhook trigger" plugin  
    From dashboard --> manage jenkins --> manage plugins --> Available Plugins  
    Search for "Multibranch Scan webhook Trigger" plugin and install it. 

2. Go to multibranch pipeline job
     job --> configure --> Scan Multibranch Pipeline Triggers --> Scan Multibranch Pipeline Triggers  --> Scan by webhook   
     Trigger token: `<token_name>`

3. Add webhook to GitHub repository
   Github repo --> settings --> webhooks --> Add webhook  
   Payload URl: `<jenkins_IP>:8080/multibranch-webhook-trigger/invoke?token=<token_name>`  
   Content type: `application/json`  
   Which event would you like to trigger this webhook: `just the push event` 


## SonarQube Configuration 

1. Create Sonar cloud account on https://sonarcloud.io
2. Generate an Authentication token on SonarQube
    Account --> my account --> Security --> Generate Tokens 

3. On Jenkins create credentials 
   Manage Jenkins --> manage credentials --> system --> Global credentials --> add credentials
 - Credentials type: `Secret text`
 - ID: `sonarqube-key`

4. Install SonarQube plugin
    Manage Jenkins --> Available plugins 
    Search for `sonarqube scanner`

5. Configure sonarqube server 
   Manage Jenkins --> Configure System --> sonarqube server 
   Add Sonarqube server 
   - Name: `sonar-server`
   - Server URL: `https://sonarcloud.io/`
   - Server authentication token: `sonarqube-key`

6. Configure sonarqube scanner 
   Manage Jenkins --> Global Tool configuration --> Sonarqube scanner 
   Add sonarqube scanner 
   - Sonarqube scanner: `sonar-scanner`


