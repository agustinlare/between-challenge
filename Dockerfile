FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    swig

COPY . /app/

WORKDIR /app

RUN g++ -c -fPIC one.cpp -o one.o && \
    g++ -shared -Wl,-soname,one.so -o one.so one.o

RUN swig -python -c++ -I. one.i

RUN g++ -shared -fPIC -I/usr/include/python3.9 -I. one_wrap.cxx one.o -o _one.so $(python3-config --cflags --ldflags)

RUN python3 setup.py sdist bdist_wheel && \
    pip install $(find /app/dist -name "*.whl")

CMD [ "python3", "/app/main.py"]