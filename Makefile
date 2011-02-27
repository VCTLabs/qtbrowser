CROSS_COMPILE	:= /opt/freescale/usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi/bin/arm-fsl-linux-gnueabi-
CC		:= ${CROSS_COMPILE}gcc
CXX		:= ${CROSS_COMPILE}g++
LD		:= ${CROSS_COMPILE}g++
AR		:= ${CROSS_COMPILE}ar
STRIP		:= ${CROSS_COMPILE}strip

LTIB=/home/ericn/ltib/rootfs
QT=${LTIB}/usr/local/Trolltech/Qt-4.7.1
QTINC=${QT}/include
QTLIB=${QT}/lib

CXXFLAGS=-I${LTIB}usr/include -I${QTINC} -I${QTINC}/QtGui -I${QTINC}/QtCore -I${QTINC}/QtWebKit
LDFLAGS=-L${QTLIB} -lQtWebKit -lQtGui -Wl,-rpath-link,${QTLIB} -Wl,-rpath-link,${LTIB}/lib -Wl,-rpath-link,${LTIB}/usr/lib

moc_%.cpp: %.h
	moc $< -o $@

%.o : %.cpp
	@echo "=== compiling:" $@ ${OPT} ${CXXFLAGS} 
	@${CXX} -c ${CXXFLAGS} ${INCS} ${DEFS} $< -o $@

qtbrowser: main.o kbdInput.o moc_kbdInput.o bcInput.o moc_bcInput.o moc_mainwindow.o mainwindow.o
	@echo "=== linking:" $@
	${CXX} ${LDFLAGS} $^ -o $@

clean:
	rm -f *.o qtbrowser
