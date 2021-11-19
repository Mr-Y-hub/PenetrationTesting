#!bin/python3
import sys
import socket
target=0
from datetime import datetime as dt #In this statement we can use simpli dt in program
if len(sys.argv)==2:  # 2 arguments one is file name and another is host
	target = socket.gethostbyname(sys.argv[1]) #taking host from user and save it to target 
else:
	print("Invalid Arguments Write in correct form ")
#preety Banner
print("-"*50)
print("Checking {} on every port".format(target))
print("-"*50)
try:
	for port in range (1,40000):
		s = socket.socket(socket.AF_INET,socket.SOCK_STREAM) # s contains all information 
		socket.setdefaulttimeout(1) #  its set default time out for checking as 1 second
		result = s.connect_ex((target,port)) #checking that port is open or not, result==0 if port is open 
		if result == 0:
			print(" Port {} is open ".format(port))
		s.close() #closing the scan

except KeyboardInterrupt: #key interruption while running program
	print("\nExiting Program")
	sys.exit() #exit to program
	
except socket.gaierror: #if there is no host name resolution
	print("Hostname could not be resolved")
	sys.exit()

except socket.error: # if we can't connect to ip address we specify
	print("Could not connet to server:")
	sys.exit() 		
