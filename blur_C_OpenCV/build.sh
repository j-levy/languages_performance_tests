#!/bin/bash

g++ main.cpp -o main $(pkg-config --cflags opencv; for x in $(ls /usr/local/lib/libopencv*.a; ls /usr/local/lib/libopencv*.a); do echo -n "$x "; done) $(for x in $(ls /usr/local/share/OpenCV/3rdparty/lib/lib*.a); do echo -n "$x "; done) libpng16.a -ldl -lm -lpthread -lrt -lstdc++ -Bstatic -lpng -lz -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo  -lpango-1.0 -lfreetype -lfontconfig -lgobject-2.0 -lgmodule-2.0 -lgthread-2.0 -lglib-2.0 -lrt
