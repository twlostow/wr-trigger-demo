OBJS = simple-eb.o ttd_lib.o ttd_test.o
CFLAGS = -Ietherbone -I../include
LDFLAGS = -letherbone

all:	$(OBJS)
			gcc -o ttd_test $(OBJS) $(LDFLAGS)