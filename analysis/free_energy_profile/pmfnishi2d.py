# *
# * pmfnishi2d.py for the number of helical residues
# *
# calculate and make 2D PMF figure
# v5.0

#*** Parameters

## file name of figure
fn_fig1="pic_pmfnishi.png"

Graph_title=""
X_label="Length of N-terminal helix"
Y_label="Length of C-terminal helix"
FONTSIZE=30

#Graph_x_low=0
#Graph_x_high=18
#Graph_y_low=0.8
#Graph_y_high=2.2

## number of bins of each axis
nbin_x=28
nbin_y=26 #28 

## bin width of each axis
bw_x=1.0 
bw_y=1

## minimum value of bins
min_x=0
#max_x=28.0
min_y=0 
#max_y=2.0

Temperature=300.0 #K
Gas_const=8.3144598 # J K^-1 mol^-1
J_per_cal=4.184 #J/cal


#*** Code
import matplotlib.pyplot as plt
from matplotlib import cm
import numpy as np
import sys
import math
import matplotlib

np.set_printoptions(formatter={'float': '{: 0.3f}'.format})

def read_data(filename,data_type):
  f = open(filename)
  data = np.array(f.read().split(),dtype=data_type)
  f.close()
  return data

x = read_data(sys.argv[1], float)
y = read_data(sys.argv[2], float)

#bin_x=(max_x-min_x)/float(nbins)
#bin_y=(max(y)-min(y))/float(nbins)
#bin_y=(max_y-min_y)/float(nbins)
bin_x=bw_x
bin_y=bw_y

z = np.zeros((nbin_y,nbin_x),dtype=np.float64)

for i in range(len(x)):
  for j in range(0,nbin_x):
    if x[i] >= min_x+j*bin_x and x[i] < min_x+(j+1)*bin_x:
      for k in range(0,nbin_y):
        if y[i] >= min_y+k*bin_y and y[i] < min_y+(k+1)*bin_y:
	  z[k][j] = z[k][j]+1

bottom = -1*Gas_const/1000.0/J_per_cal*Temperature*math.log(np.amax(z)/float(len(x))) 

for i in range(nbin_y):
  for j in range(nbin_x):
    z[i][j]=-1*Gas_const/1000.0/J_per_cal*Temperature*math.log(z[i][j]/float(len(x)) ) -bottom if z[i][j]>0 else -1


### ****** Output matrix data
for j in range(nbin_x):
  if j%10 == 0:
    print ",",min_x+j*bin_x,
  else:
    print ",",
print ''

for i in range(nbin_y):
  print min_y+i*bin_y,
  for j in range(nbin_x):
    if z[i][j] == -1:
      z[i][j] = 999999 #np.amax(z) 
    # 20170710 modified for skipping 1 and 2, the number of helical residues
#    if i == 1 or i == 2 or j == 1 or j == 2:
#      continue
        #z[i][j] = np.amax(z) 
      #print min_x+j*bin_x, min_y+i*bin_y, z[i][j]
    print ",", z[i][j],  
#  if i == 1 or i == 2:
#    continue
  print ''


#print z
#print np.amax(z), np.amin(z), (np.amax(z)-np.amin(z))/2.0


# *** make figure
fig, axis = plt.subplots()
#fig, axis = plt.subplots(figsize=(10,10))

plt.xlabel(X_label,fontsize=FONTSIZE)
plt.ylabel(Y_label,fontsize=FONTSIZE)

#cax = axis.imshow(z, interpolation='nearest', cmap=cm.coolwarm,extent=[0,28,0,28],vmin=0,vmax=3.7)
#cax = axis.imshow(z, interpolation='nearest', cmap=cm.coolwarm,vmin=0,vmax=3.7)
my_aspect = float(nbin_x) / float(nbin_y)
#print my_aspect
cax = axis.imshow(z, interpolation='nearest', cmap=cm.coolwarm,vmin=0,vmax=3.7,aspect=my_aspect)
axis.invert_yaxis()
#axis.set_xlim(0,19)
#axis.set_ylim(Graph_y_low,Graph_y_high)
#axis.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(int(2)))

axis.set_title(Graph_title)
#*** Add colorbar, make sure to specify tick locations to match desired ticklabels
#cbar = fig.colorbar(cax, ticks=[np.amin(z),(np.amax(z)-np.amin(z))/2.0,np.amax(z)])
cbar = fig.colorbar(cax)
cbar.set_label('kcal/mol',fontsize=FONTSIZE)
cbar.ax.tick_params(labelsize=FONTSIZE)

xtics_label, ytics_label = [], []
for i in range(nbin_x):
  #xtics_label.append(0+i*bin_x) 
  #xtics_label.append(0+i*5) 
  xtics_label.append("%i" % (min_x+i*5.0*bin_x))
for i in range(nbin_y):
  #xtics_label.append('') 
  #ytics_label.append(min_y+i*bin_y)
  #ytics_label.append("%.2f" % (min_y+i*5.0*bin_y))
  ytics_label.append("%i" % (min_y+i*5.0*bin_y))
plt.grid(False)
axis.set_xticklabels(['']+xtics_label,rotation=90)
axis.set_yticklabels(['']+ytics_label)

axis.tick_params(axis='both', which='major', labelsize=FONTSIZE)
axis.tick_params(axis='both', which='minor', labelsize=20)

#plt.axes().set_aspect('equal','datalim')
#plt.axes().set_aspect('scaled')
#ax = plt.axes() 
#axisEqual3D(ax)
#ax.pbaspect = [1.0, 1.0, 0.25]

# Now check everything with the defaults:
DPI = fig.get_dpi()
#print "DPI:", DPI
DefaultSize = fig.get_size_inches()
#print "Default size in Inches", DefaultSize
#print "Which should result in a %i x %i Image"%(DPI*DefaultSize[0], DPI*DefaultSize[1])

fig.savefig(fn_fig1,dpi=300)
#plt.show()




