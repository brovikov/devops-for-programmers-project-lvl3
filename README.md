### Hexlet tests and linter status:
[![Actions Status](https://github.com/brovikov/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/brovikov/devops-for-programmers-project-lvl3/actions)
   
# Requirements  
  
**Host requirements:**  
OS: Linux / MacOS  
Ansible v. 2.11.4  
Python 3.9.7  
jinja 3.0.1  
  
**Servers:**  
powered by Ubuntu 20.04 and Docker
by DigitalOcean Version 19.03.12 (Docker CE 20.10.7, Docker Compose 1.27.0)  
Ansible [core 2.11.4]  
Terraform v1.0.11  

# Project structure  
![project_structure](https://user-images.githubusercontent.com/4372434/144742260-f3492f87-347c-43d4-bc21-34f2a7ece6c5.jpeg)

# Setup infrastructure
  
Login into terraform cloud using `terraform login`

`make init` - initialize terraform   
`make plan` - run terraform plan   
`make apply` - apply terraform changes   
`make destroy` - destroy infrastructure

# Server provisioning and app deploy
  
`make install` - install ansible roles  
`make deploy` - provision servers and deploy application  
  
  
App: https://project.hexlet-task.pp.ua/
