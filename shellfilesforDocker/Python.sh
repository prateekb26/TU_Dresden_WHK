



SCONE_HEAP=256M SCONE_VERSION=1 python

export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=268435456
export SCONE_STACK=4194304
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_ESPINS=10000
export SCONE_MODE=hw
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=yes (unprotected)
export SCONE_MPROTECT=no
Revision: d0afc0f23819476cbc7d944a20e91d79fcb6f9ab (Thu Aug 16 16:45:05 2018 +0200)
Branch: master (dirty)
Configure options: --enable-shared --enable-debug --prefix=/mnt/ssd/franz/subtree-scone/built/cross-compiler/x86_64-linux-musl

Enclave hash: f129bbd19627367c03e2980c0f04a32809a7aae1d795a75220d9054daf537b30
Python 2.7.13 (default, Jun  1 2018, 13:20:58)
[GCC 7.3.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>>


export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
...


apk add --no-cache bats libbsd openssl musl-dev build-base

pip install numpy==1.14.5

Collecting numpy==1.14.5
  Downloading https://files.pythonhosted.org/packages/d5/6e/f00492653d0fdf6497a181a1c1d46bbea5a2383e7faf4c8ca6d6f3d2581d/numpy-1.14.5.zip (4.9MB)
    100% |████████████████████████████████| 4.9MB 375kB/s
Installing collected packages: numpy
  Running setup.py install for numpy ... done
Successfully installed numpy-1.14.5

SCONE_HEAP=256M SCONE_VERSION=1 python

export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=10000000000
export SCONE_STACK=0
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=hw
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=yes
export SCONE_ALLOW_DLOPEN2=yes
Revision: 7950fbd1a699ba15f9382ebaefc3ce0d4090801f
Branch: master (dirty)
Configure options: --enable-shared --enable-debug --prefix=/scone/src/built/cross-compiler/x86_64-linux-musl

Python 2.7.14 (default, Dec 19 2017, 22:29:22) 
[GCC 6.4.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> 

>>> import numpy as np
>>> a = np.arange(15).reshape(3, 5)
>>> a
array([[ 0,  1,  2,  3,  4],
       [ 5,  6,  7,  8,  9],
       [10, 11, 12, 13, 14]])
>>> a.shape
(3, 5)
>>> a.ndim
2
>>> a.dtype.name
'int64'
>>> a.itemsize
8
>>> type(a)
<type 'numpy.ndarray'>
>>> 

apk add --no-cache  cairo-dev cairo 

fetch http://dl-cdn.alpinelinux.org/alpine/v3.7/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.7/community/x86_64/APKINDEX.tar.gz
(1/55) Installing expat-dev (2.2.5-r0)
...
(55/55) Installing cairo-dev (1.14.10-r0)
Executing busybox-1.27.2-r6.trigger
Executing glib-2.54.2-r0.trigger
No schema files found: doing nothing.
OK: 297 MiB in 112 packages
$ 

pip install pycairo

Collecting pycairo
  Downloading pycairo-1.15.4.tar.gz (178kB)
    100% |████████████████████████████████| 184kB 1.7MB/s 
Building wheels for collected packages: pycairo
  Running setup.py bdist_wheel for pycairo ... done
  Stored in directory: /root/.cache/pip/wheels/99/a6/16/79c5186b0ead4be059ce3102496b1ff776776b31da8e51af8f
Successfully built pycairo
Installing collected packages: pycairo
Successfully installed pycairo-1.15.4

SCONE_HEAP=256M SCONE_VERSION=1 python

>>> import cairo
>>> import math
>>> WIDTH, HEIGHT = 256, 256
>>> 
>>> surface = cairo.ImageSurface (cairo.FORMAT_ARGB32, WIDTH, HEIGHT)
>>> ctx = cairo.Context (surface)
>>> ctx.scale (WIDTH, HEIGHT) # Normalizing the canvas
>>> 
>>> pat = cairo.LinearGradient (0.0, 0.0, 0.0, 1.0)
>>> pat.add_color_stop_rgba (1, 0.7, 0, 0, 0.5) # First stop, 50% opacity
>>> pat.add_color_stop_rgba (0, 0.9, 0.7, 0.2, 1) # Last stop, 100% opacity
>>> 
>>> ctx.rectangle (0, 0, 1, 1) # Rectangle(x0, y0, x1, y1)
>>> ctx.set_source (pat)
>>> ctx.fill ()
>>> ctx.translate (0.1, 0.1) # Changing the current transformation matrix
>>> 
>>> ctx.move_to (0, 0)
>>> # Arc(cx, cy, radius, start_angle, stop_angle)
... ctx.arc (0.2, 0.1, 0.1, -math.pi/2, 0)
>>> ctx.line_to (0.5, 0.1) # Line to (x,y)
>>> # Curve(x1, y1, x2, y2, x3, y3)
... ctx.curve_to (0.5, 0.2, 0.5, 0.4, 0.2, 0.8)
>>> ctx.close_path ()
>>> 
>>> ctx.set_source_rgb (0.3, 0.2, 0.5) # Solid color
>>> ctx.set_line_width (0.02)
>>> ctx.stroke ()
>>> surface.write_to_png ("example.png") # Output to PNG
>>> exit()
