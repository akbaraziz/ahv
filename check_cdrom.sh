#!/bin/bash

set -ex

# Lists VM's that currently have a mounted CD-ROM disk - execute from CVM
for i in `acli vm.list |cut -d " " -f 1`; do if [ -n "`acli vm.get $i | grep -A1 cdrom | grep container`" ] ; then echo $i ; fi ; done