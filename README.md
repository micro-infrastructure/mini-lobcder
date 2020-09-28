# Mini-LOBCDER

Mini-LOBCDER is a VM of LOBCDER to deploy micro-infrastructures locally. The setup includes a VM which is provisioned with Kubernetes, core containers for LOBCDER and a user micro-infrastructure containers. 

## Installation
- Install Vagrant, VirtualBox,  GIT for Ubuntu:

`apt-get install vagrant virtualbox git ansible`
- Clone the mini-lobcder

`git clone --branch 0.1.0 https://github.com/micro-infrastructure/mini-lobcder.git`
- Create a mini-lobcder/k8s-setup/user-infra.json file. This is the description of a micro-infrastructure. 

`cd mini-lobcder`
`cp k8s-setup/user-infra.json.template k8s-setup/user-infra.json`
- Edit and fill the user-infra.json. The storageAdaptorContainers list are used to access your remote data using ssh. The logicConatiners are service container that can access your data such as a Jupyter notebook. The template container 3 default services; Jupyter, Webdav server and LOBCDER copy service.
- Build a VM with LOBCDER and you micro-infrastructure from file user-infra.json

`make build`
- This will take a while....
- Once up the 3 default services can be accessed from your local browser.
http://192.168.50.10:31003 for Jupyter
http://192.168.50.10:31002 for Webdav
http://192.168.50.10:31001 for LOBCDER copy
- You can suspend and resume the VM using

`make pause`
`make resume`

- To destroy the VM

`make clean`

## LOBCDER Copy
The copy service is used to do 3rd party copies between your storage nodes. For more information how to use the service visit [lobcder-copy](https://github.com/micro-infrastructure/service-scp2scp)

## User-infra description file
This file describes the micro-infrastructure for the user or application. For more information how to build the file visit [lobcder-core-infra](https://github.com/micro-infrastructure/core-infra)

## Services with callback
Some services require a public interface to receive callbacks. For local deployments [ngrok](https://ngrok.com) can be used to create these.

For `lofar-download`, create a tunnel to the Vagrant VM from the host machine and specify the port of the service:

```shell
$ ngrok http 192.168.50.10:31005
```

Then set the `LOFARDOWNLOAD_SERVICE` environment variable in the `user-infra.json` file (see `k8s-setup/user-infra.json.template-lofar`) to the forwarding URL ngrok provides.

