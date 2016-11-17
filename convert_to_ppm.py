import numpy as np
import re,pdb
import sys
import scipy.misc as misc
import os
'''
Load a PFM file into a Numpy array. Note that it will have
a shape of H x W, not W x H. Returns a tuple containing the
loaded image and the scale factor from the file.
'''
"""
def load_pfm(file):
  color = None
  width = None
  height = None
  scale = None
  endian = None

  header = file.readline().rstrip()
  if header == 'PF':
    color = True    
  elif header == 'Pf':
    color = False
  else:
    raise Exception('Not a PFM file.')

  dim_match = re.match(r'^(\d+)\s(\d+)\s$', file.readline())
  if dim_match:
    width, height = map(int, dim_match.groups())
  else:
    raise Exception('Malformed PFM header.')

  scale = float(file.readline().rstrip())
  if scale < 0: # little-endian
    endian = '<'
    scale = -scale
  else:
    endian = '>' # big-endian

  data = np.fromfile(file, endian + 'f')
  shape = (height, width, 3) if color else (height, width)
  return np.reshape(data, shape), scale
"""
'''
Save a Numpy array to a PFM file.
'''

def write_ppm(file_,imagepath,savepath,xval):
    count =0
    while True:
	fline = file_.readline()
	fpath = imagepath.readline()
	if not fline: break
	pdb.set_trace()
	im = misc.imread(os.path.join(fpath[:-1].rstrip(),'stereo/left',fline[:-1].rstrip()),'RGB')   
    	height, width, nc = im.shape
    	assert nc == 3
        if np.mod(count,10000)==0:
	    savepath2 = os.path.join(savepath,'03d%' %np.mod(count,10000))
            os.makedirs(savepath2)
	ppm_name  = os.path.join(savepath2,'left_%08d.ppm' %count)
        count +=1	
        f = open(ppm_name, 'w')
	f.write('P3\n')
        f.write(str(width)+' '+str(height)+'\n')
        f.write(str(xval)+'\n')
	# interleave image channels before streaming    
        c1 = np.reshape(im[:, :, 0], (width*height, 1))
        c2 = np.reshape(im[:, :, 1], (width*height, 1))
        c3 = np.reshape(im[:, :, 2], (width*height, 1))
     
        im1 = np.hstack([c1, c2, c3])
        im2 = im1.reshape(width*height*3)
 
        f.write('\n'.join(im2.astype('str')))
        f.write('\n')
        f.close()


    file_.close()
    imagepath.close()



if __name__=='__main__':
  if len(sys.argv) is not 4:
      print('please insert filelist file, image filepath and save imagepath \n')
  else:
      #filelist ='left_stereo.txt' # image list
      filelist =sys.argv[1] # image list
      f= open(filelist,'r')
      imgpath = sys.argv[2]
      fi = open(imgpath,'r')
      savepath = sys.argv[3]
      write_ppm(f,fi,savepath,255)
      #image = misc.imread('cat2.jpg')
      #f = open('test.ppm','w')	
      #save_pfm(f,image)	
