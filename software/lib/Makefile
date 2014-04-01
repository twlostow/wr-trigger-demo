OBJS = ttd_lib.o ttd_test.o
FDLIB_OBJS = simple-eb.o fdelay/lib/fdelay_bus.o fdelay/lib/fdelay_lib.o fdelay/lib/i2c_master.o fdelay/lib/onewire.o
CFLAGS = -Ietherbone -I../include -Ifdelay/include -I. -g -fPIC
LDFLAGS = -letherbone  -g

all:	$(OBJS) $(FDLIB_OBJS)
	gcc -o ttd_test $(OBJS) $(FDLIB_OBJS) $(LDFLAGS)

shared: $(FDLIB_OBJS)
	gcc -shared $(CFLAGS) -o libfd.so $(FDLIB_OBJS)
	

clean:	
			rm -f $(OBJS) ttd_test