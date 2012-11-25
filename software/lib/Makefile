OBJS = simple-eb.o ttd_lib.o ttd_test.o fdelay/lib/fdelay_bus.o fdelay/lib/fdelay_lib.o fdelay/lib/i2c_master.o fdelay/lib/onewire.o
CFLAGS = -Ietherbone -I../include -Ifdelay/include -I. -g
LDFLAGS = -letherbone  -g

all:	$(OBJS)
			gcc -o ttd_test $(OBJS) $(LDFLAGS)

clean:	
			rm -f $(OBJS) ttd_test