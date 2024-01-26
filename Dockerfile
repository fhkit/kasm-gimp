# Custom Image for Coder
# https://kasmweb.com/docs/latest/guide/custom_images.html
FROM kasmweb/gimp:1.14.0-rolling

USER root

COPY kasmvnc.yaml /etc/kasmvnc/kasmvnc.yaml
COPY vnc_startup.sh /dockerstartup/vnc_startup.sh
COPY kasm_default_profile.sh /dockerstartup/kasm_default_profile.sh
RUN cp -r /home/kasm-user /tmp/kasm-user
RUN apt-get update && apt-get install sudo
RUN echo "kasm-user ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd
RUN DEBIAN_FRONTEND=noninteractive make-ssl-cert generate-default-snakeoil --force-overwrite
RUN adduser kasm-user ssl-cert

# Install baseline packages
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
      bash \
      curl \
      htop \
      locales \
      man \
      python3 \
      python3-pip \
      software-properties-common \
      sudo \
      vim \
      wget \
      rsync

USER 1000