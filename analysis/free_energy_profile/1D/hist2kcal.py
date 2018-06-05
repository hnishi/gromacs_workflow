# v1.1

#*** Code
Gas_const=8.3144598 # J K^-1 mol^-1
J_per_cal=4.184 #J/cal
Temperature=300.0 #K

import numpy as np
import sys
import math

def read_data(filename,data_type):
  f = open(filename)
  data = np.array(f.read().split(),dtype=data_type)
  f.close()
  return data

#x = read_data(sys.argv[1], float)

def read_xvg(filename,data_type):
  f = open(filename)
  x = f.read().split('\n')
  vec = []
  for i in x:
    if len(i) != 0:
      if i[0] != '#' and i[0] != '@' :
        for j in i.split():
          vec.append(j)
  f.close()
  return np.array(vec,dtype=float)

sum=0
x = read_xvg(sys.argv[1], float)
#print x, type(x[0])
vec = []
for i in range(0,len(x),2):
  sum += x[i+1] 
  vec.append(x[i+1])
vec = np.array(vec)
#print sum
#print len(vec), type(vec[0])
bottom = np.amax(vec)/sum
for i in range(0,len(vec)):
  if vec[i] == 0:
    vec[i] = 999999 
  else:
    vec[i] = vec[i]/sum

top = np.amin(vec)
#print vec
#print np.amax(vec)
#print top, bottom

bottom = -1*Gas_const/1000.0/J_per_cal*Temperature*math.log(bottom) 
#print bottom

for i in range(0,len(vec)):
  if vec[i] == 999999:
    #print  x[i*2], -1*Gas_const/1000.0/J_per_cal*Temperature*math.log(top) -bottom
    pass
  else:
    print  x[i*2], -1*Gas_const/1000.0/J_per_cal*Temperature*math.log(vec[i]) -bottom




