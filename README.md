# ☁️ Amazon Connect Infrastructure Setup with Metrics and Dynamic Routing using Lambda function.

This repository contains Infrastructure-as-Code (IaC) for deploying and managing an **Amazon Connect** instance and its related AWS resources using **Terraform**.  

This is build on top of connect-setup project to add **event logging (CTR, Agent Events and Contact Events)** to cloud watch log groups using Kinesis streams, Event Bridge and Lamba(python) functions.

---

## 📁 Project Structure
    connect-metrics/
    ├── terraform/ # All Terraform IaC code
    │ ├── 1_instance.tf # Instance configuration
    │ ├── 1a_phone_number.tf # Phone number provisioning
    │ ├── 2_users.tf # Users setup
    │ ├── 3_hours_of_operation.tf # Hours of Operation setup
    │ ├── 4_queues.tf # Queues setup
    │ ├── 5_routing_profiles.tf # Routing profiles setup
    │ ├── 6_contact_flows.tf # Contact flows setup
    │ ├── storage.tf # Connect storage setup
    │ ├── main.tf # Main configuration for Connect resources
    │ ├── variables.tf # Input variables
    │ ├── output.tf # Terraform outputs
    │ ├── data.tf # Terraform data load
    │ ├── kms.tf # Terraform kms
    │ ├── provider.tf # Terraform provider setup
    │ ├── lambda.tf # Terraform lambda setup
    │ ├── log-groups.tf # Terraform CW log groups setup
    ├ |── lambda/ #Lambda functions for logging events in Cloudwatch log groups
    |   |-- ce_handler.py # logs contact events 
    |   |-- kds_handler.py # logs ctr and agent events 
    |   |-- dynamic_router.py # return queue arn and queue name based on the caller selection
    ├── json/ # Contact flows (exported as json), prompts, etc.
    │ ├── contact_flows/
    │ ├── prompts/
    └── README.md

---

## 🚀 Prerequisites

- **AWS Account** with required IAM permissions
- **Terraform** ≥ 1.5.0
- **AWS CLI** configured locally (`aws configure`)
- Optional: **VS Code** with Terraform extension

---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://gitlab.com/sr0626/connect-metrics.git
   cd connect-metrics/terraform

2. **Comment some code**
    1. Comment all the code in 1a_phone_number.tf file
    2. Comment all the code in 6_contact_flows.tf file

3. **Run terraform commands from the terminal**
    ```bash
    terraform init
    terraform validate
    terraform plan
    terraform apply
    
    Make a copy of the queue arn (printed in the terminal as my_queue_arn) 

4. **Update code**
    1. Uncomment all the code in 1a_phone_number.tf file
    2. Unomment all the code in 6_contact_flows.tf file
    3. Open MyInboundFlow.json (under json/contact_flows folder)
    4. Replace <<MY_QUEUE_ID>> with the arn copied above  
    5. Rerun terraform apply command

5. **Validation**
    1. Call the phone number provisioned  (output prited as did_number)
    2. Confirm the call is answered
    3. Select the options provided
    4. Wait for the call to be queued for an agent
    5. Login to Agent Workspace or CCP (as an agent or admin)
    6. Change the status to Available
    7. Call is auto-accepted
    8. Hangup the call
    9. Select Close Contact
    10. Check your s3 bucket for call recordings
    11. Check CW logs group for the call trace

6. **Log groups**
    The below logs groups are created for CTRs, Agent Events and Contact Events respectively.  These logs can be used to build real-time and historical dashboards.  
    ```bash
    /aws/lambda/<instance-name>-ctr
    /aws/lambda/<instance-name>-ae
    /aws/lambda/<instance-name>-ce

7. **Connect Replication**
    Run the below commnads to setup Amazon Connect Global Resiliency  (ACGR).  This assumes your instance is already allow listed for resiliancy.  If not, please contact AWS support first.

    1. aws connect replicate-instance --instance-id INSTANCE_ID --replicate-region us-east-1 --replica-alias connect-gr-east-test
    2. aws connect create-traffic-distribution-group --name Prod --instance-id INSTANCE_ID
    3. aws connect describe-traffic-distribution-group --traffic-distribution-group-id TDG_ID  (wait for status ACTIVE)
    4. aws connect get-traffic-distribution --id TDG_ID (to see current traffic distribution)
    5a. aws connect update-phone-number --phone-number-id PHONE_ID --target-arn TDG_ARN (assign phone number to TDG from Instance)
    5b. aws connect search-available-phone-numbers --target-arn TDG_ARN --phone-number-country-code US --phone-number-type DID --max-results 5 (to search a new phone number those can be claimed for the TDG)
    6. aws connect claim-phone-number --target-arn TDG_ARN --phone-number PHONE_NUMBER 
    7. aws connect update-traffic-distribution --id TDG_ID --cli-input-json '{"TelephonyConfig" : {"Distributions": [{"Percentage": 100, "Region": "us-east-1"}, {"Percentage": 0, "Region": "us-west-2"}] }}'  (to move 100% traffic from west to east, the replica region)
    8. 

    TODO: 
    1. agent distribution 
    2. ALGR for Lex resiliency

    Helpful links:
    https://docs.aws.amazon.com/connect/latest/adminguide/connect-global-resiliency-requirements.html
    https://docs.aws.amazon.com/connect/latest/adminguide/get-started-connect-global-resiliency.html#howto-setup-gr
    https://catalog.workshops.aws/amazon-connect-global-resiliency/en-US
    https://catalog.workshops.aws/amazon-connect-global-resiliency/en-US/connectbestpractices
    https://catalog.workshops.aws/amazon-connect-global-resiliency/en-US/awsservicesbestpractices

    
