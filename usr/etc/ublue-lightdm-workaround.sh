#!/bin/bash

if [ ! -d /var/cache/lightdm ]; then mkdir /var/cache/lightdm; fi
if [ ! -d /var/log/lightdm ]; then mkdir /var/log/lightdm; fi
if [ ! -d /var/lib/lightdm ]; then mkdir /var/lib/lightdm; fi
if [ ! -d /var/lib/lightdm-data ]; then mkdir /var/lib/lightdm-data; fi