FROM ubuntu:16.04
MAINTAINER Natalia Savytska

#Environmental Variables/Paths
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/opt/kraken2:${PATH}"
ENV PATH="/opt/bracken/:${PATH}"
ENV TERM=xterm

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y wget 
RUN apt-get install -y zip
RUN apt-get install -y bash
RUN apt-get install -y python
RUN apt-get install -y make
RUN apt-get install -y nano
RUN apt-get install -y ncbi-blast+


RUN cd tmp ; wget https://github.com/savytskanatalia/Kraken2.0.7-beta/raw/master/kraken2-2.0.7-beta.tar.gz
RUN cd tmp ; tar xf kraken2-2.0.7-beta.tar.gz  
RUN mkdir -p /opt/kraken2 
RUN cd tmp/kraken2-2.0.7-beta ; ./install_kraken2.sh /opt/kraken2 
RUN ln -s /opt/kraken2/kraken2 /usr/local/bin/kraken2 
RUN ln -s /opt/kraken2/kraken2-build /usr/local/bin/kraken2-build 
RUN ln -s /opt/kraken2/kraken2-inspect /usr/local/bin/kraken2-inspect  
RUN cd tmp ; wget https://github.com/savytskanatalia/Kraken-Bracken/raw/master/Bracken-master.zip 
RUN cd tmp ; unzip Bracken-master.zip  
RUN mkdir -p /opt/bracken 
RUN cd tmp/Bracken-master ; cp bracken /opt/bracken/ ; cp bracken-build /opt/bracken/ ; cp -R src/ /opt/bracken/ 
RUN cd /opt/bracken/src/ ; make 
WORKDIR /data
 

