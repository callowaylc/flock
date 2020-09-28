export SHELL := /bin/sh
export NOW := $(shell date +%s)

.PHONY:
.DELETE_ON_ERROR:
goal: run

run:
	./main.sh $(NOW)
