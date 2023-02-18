#!/bin/bash

# Instructions available here: https://pytorch.org/torchx/latest/schedulers/kubernetes.html

pip uninstall -y torchx[kubernetes]

kubectl delete -f https://raw.githubusercontent.com/volcano-sh/volcano/v1.6.0/installer/volcano-development.yaml

