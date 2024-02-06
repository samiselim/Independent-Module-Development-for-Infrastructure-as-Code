# aws_terraform_project

This project is creating an infrastructure at AWS cloud using terraform tool 
* creating my own modules [webServer module - subnet module] and using those to create nginx server  
  and accessing this server using web browser 

- creating vpc 
- creating subnet 
- creating route-table 
- creating internet gateway
- creating security group with ingress and egress rules 
- creating instance using t2.micro type and amazon linux os
- creating subnet module
- creating webserver module
- in main file i used the two modules to create a nginx server using base image of nginx using docker  
- init the terraform and apply the cnofigurations
- connect to teh server using the browser by the ip and port number of the ingress rule inside the created security group
