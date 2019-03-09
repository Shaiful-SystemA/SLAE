#!/usr/bin/python

import sys

input = sys.argv[1]
print '\nString' + ' : '+input	
print 'String length : ' +str(len(input))+'\n'
stringList = [input[i:i+4] for i in range(0, len(input), 4)]

for item in stringList[::-1] :


	print 'Reverse' +' : '+item[::-1] 
	print 'Hex' + ' : '+str(item[::-1].encode('hex'))
 
