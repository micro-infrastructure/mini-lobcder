.PHONY: all

clean:
	vagrant destroy -f

build: clean
	vagrant up

pause:
	vagrant suspend

resume:
	vagrant resume
	sleep 5
	scripts/reDeployUserInfra.sh

deploy:
	scripts/reDeployUserInfra.sh

