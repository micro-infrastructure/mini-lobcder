.PHONY: all

clean:
	vagrant destroy -f

build: clean
	vagrant up

