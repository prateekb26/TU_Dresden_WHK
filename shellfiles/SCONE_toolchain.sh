
echo next
$ ldd web-srv-go 
	linux-vdso.so.1 =>  (0x00007ffe423fd000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007effa344f000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007effa3085000)
	/lib64/ld-linux-x86-64.so.2 (0x00007effa366c000)
echo next
echo next
echo next
echo next
> ldd a.out 
	/lib/ld-musl-x86_64.so.1 (0x7fb0379f9000)
	libc.musl-x86_64.so.1 => /lib/ld-musl-x86_64.so.1 (0x7fb0379f9000)
echo next
