FROM i686/ubuntu
MAINTAINER Manuel <m.kern@iphos.com>
ADD VERSION .

EXPOSE 22 2500-2550
VOLUME ["/data", "/config"]

ARG ROOT_PASSWORD="we_all_love_default_credentials"
ENV ROOT_PASSWORD=${ROOT_PASSWORD}

RUN apt-get update
RUN apt-get -y install perl build-essential cpanminus openssh-server
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cpanm constant Carp Cwd Data::Dumper Encode Encode::Alias Encode::Config Encode::Encoding Encode::MIME::Name Exporter Exporter::Heavy File::Path File::Spec File::Spec::Unix File::Temp List::Util Scalar::Util Socket Storable threads

RUN echo "root:${ROOT_PASSWORD}" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY image-utils/run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
