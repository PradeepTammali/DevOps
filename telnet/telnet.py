#!/usr/bin/python
# -*- coding: utf-8 -*-

#from kubernetes import config
#print "sample"
import telnetlib
import sys

def run(host, port):
    try:
        print('Trying to authenticate to the telnet server')
        tn = telnetlib.Telnet(host, port, timeout=10)
        print('Connected to {}:{}'.format(host, port))
        tn.close()
    except Exception:
        print('Connection error: {}:{}'.format(host, port))

if __name__ == "__main__":
    run(str(sys.argv[1]), str(sys.argv[2]))
