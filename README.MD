This Docker File is of CentOS7 with Python 3.9 and SSH Enabled Container run the following Command to build and deploy the container (Need Pyhon 3.9++ To Work With Ansible)

Step 1:
chmod +x red.sh\n
Step 2:
docker build -t "Image Name" .\n
Step 3:
docker container run -it --name=ssh -p 2222:22 "Image Name" bash
