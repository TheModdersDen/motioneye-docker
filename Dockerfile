#! Copyright (c) 2024 TheModdersDen | https://themoddersden.com/ | All Rights Reserved.

FROM debian:bookworm-slim

LABEL maintainer="TheModdersDen <site-admin@themoddersden.com>"
LABEL description="motioneye-docker - A Repository for a 'template' MotionEye docker setup (with a few extra features)"

# Set the timezone
ENV TZ=UTC

# Set the default user password
ENV motioneye_usr_password="1CANHAZPASSWORD!"

# Set the data directory
ENV motioneye_data_dir="/opt/motioneye"

# Set the place to put downloaded files
ENV motioneye_tmp_dir="/tmp/downloads"

# Set the place to put extracted files
ENV motioneye_extracted_dir="/tmp/extracted"

# Set the place to put the config files
ENV motioneye_config_dir="/opt/motioneye/.config"

# Set the default shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Change to the root user temporarily to set some options, run some commands, and install some packages
USER root

RUN mkdir -p /tmp/docker

WORKDIR /tmp/docker

# Set the default apt-get options
RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/99-recommends \
    && echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf.d/99-suggests \
    && echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/99-assume-yes \
    && echo 'APT::Get::force-yes "true";' > /etc/apt/apt.conf.d/99-force-yes \
    && echo 'APT::Get::allow-downgrades "true";' > /etc/apt/apt.conf.d/99-allow-downgrades \
    && echo 'APT::Get::allow-remove-essential "true";' > /etc/apt/apt.conf.d/99-allow-remove-essential \
    && echo 'APT::Get::allow-remove-recommended "true";' > /etc/apt/apt.conf.d/99-allow-remove-recommended \
    && echo 'APT::Get::force-yes "true";' > /etc/apt/apt.conf.d/99-force-yes \
    && echo 'APT::Get::purge "true";' > /etc/apt/apt.conf.d/99-purge \
    && echo 'APT::Get::reinstall "true";' > /etc/apt/apt.conf.d/99-reinstall \
    && echo 'APT::Get::trivial-only "false";' > /etc/apt/apt.conf.d/99-trivial-only \
    && echo 'APT::Get::no-download "false";' > /etc/apt/apt.conf.d/99-no-download \
    && echo 'APT::Get::ignore-missing "false";' > /etc/apt/apt.conf.d/99-ignore-missing \
    && echo 'APT::Get::fix-missing "false";' > /etc/apt/apt.conf.d/99-fix-missing \
    && echo 'APT::Get::show-upgraded "false";' > /etc/apt/apt.conf.d/99-show-upgraded \
    && echo 'APT::Get::show-versions "false";' > /etc/apt/apt.conf.d/99-show-versions \
    && echo 'APT::Get::update "true";' > /etc/apt/apt.conf.d/99-update \
    && echo 'APT::Get::upgrade "true";' > /etc/apt/apt.conf.d/99-upgrade \
    && echo 'APT::Get::list-cleanup "true";' > /etc/apt/apt.conf.d/99-list-cleanup \
    && echo 'APT::Get::autoclean "true";' > /etc/apt/apt.conf.d/99-autoclean \
    && echo 'APT::Get::clean "true";' > /etc/apt/apt.conf.d/99-clean \
    && echo 'APT::Get::download-only "false";' > /etc/apt/apt.conf.d/99-download-only \
    && echo 'APT::Get::show-upgraded "false";' > /etc/apt/apt.conf.d/99-show-upgraded \
    && echo 'APT::Get::show-versions "false";' > /etc/apt/apt.conf.d/99-show-versions \
    && echo 'APT::Get::allow-downgrades "true";' > /etc/apt/apt.conf.d/99-allow-downgrades \
    && echo 'APT::Get::allow-remove-essential "true";' > /etc/apt/apt.conf.d/99-allow-remove-essential \
    && echo 'APT::Get::allow-remove-recommended "true";' > /etc/apt/apt.conf.d/99-allow-remove-recommended \
    && echo 'APT::Get::force-yes "true";' > /etc/apt/apt.conf.d/99-force-yes \
    && echo 'APT::Get::purge "true";' > /etc/apt/apt.conf.d/99-purge \
    && echo 'APT::Get::reinstall "true";' > /etc/apt/apt.conf.d/99-reinstall \
    && echo 'APT::Get::trivial-only "false";' > /etc/apt/apt.conf.d/99-trivial-only \
    && echo 'APT::Get::no-download "false";' > /etc/apt/apt.conf.d/99-no-download \
    && echo 'APT::Get::ignore-missing "false";' > /etc/apt/apt.conf.d/99-ignore-missing \
    && echo 'APT::Get::fix-missing "false";' > /etc/apt/apt.conf.d/99-fix-missing \
    && echo 'APT::Get::show-upgraded "false";' > /etc/apt/apt.conf.d/99-show-upgraded \
    && echo 'APT::Get::show-versions "false";' > /etc/apt/apt.conf.d/99-show-versions \
    && echo 'APT::Get::update "true";' > /etc/apt/apt.conf.d/99-update \
    && echo 'APT::Get::upgrade "true";' > /etc/apt/apt.conf.d/99-upgrade \
    && echo 'APT::Get::list-cleanup "true";' > /etc/apt/apt.conf.d/99-list-cleanup \
    && echo 'APT::Get::autoclean "true";' > /etc/apt/apt.conf.d/99-autoclean \
    && echo 'APT::Get::clean "true";' > /etc/apt/apt.conf.d/99-clean \
    && echo 'APT::Get::download-only "false";' > /etc/apt/apt.conf.d/99-download-only

# Update the system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y


# Install the required packages
RUN apt-get -qq --option Dpkg::Options::="--znfnew" --no-install-recommends install -y \
    apt-transport-https \
    ca-certificates \
    fdisk \
    gcc \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    wget \
    python3 \
    python3-dev \
    openssl \
    libssl-dev \
    libcurl4-openssl-dev \
    wget \
    libjpeg62-turbo-dev \
    git \
    unzip \
    zip \
    p7zip-full \
    p7zip-rar \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y

RUN curl -sSfO 'https://bootstrap.pypa.io/get-pip.py' && python3 get-pip.py && rm get-pip.py && python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel

RUN printf '%b' '[global]\nbreak-system-packages=true\n' > /etc/pip.conf; && \
    printf '%b' 'extra-index-url=https://www.piwheels.org/simple/\n' >> /etc/pip.conf;

# Create the motioneye user with the password set in the 'motioneye_usr_password' environment variable
RUN useradd -ms /bin/bash motioneye_usr -p $(openssl passwd -1 ${motioneye_usr_password}) \
    && usermod -aG sudo motioneye_usr \
    && usermod -aG motion motioneye_usr \
    && usermod -aG root motioneye_usr

RUN echo "motioneye_usr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create the default directories (and set permissions)
RUN mkdir -p ${motioneye_data_dir} \ 
    mkdir -p ${motioneye_tmp_dir} \
    mkdir -p ${motioneye_extracted_dir} \
    mkdir -p ${motioneye_config_dir}

# Set the default working directory
WORKDIR /opt/motioneye

# Download the latest pre-release of MotionEye:
RUN wget https://github.com/motioneye-project/motioneye/archive/refs/tags/0.43.1b1.zip -O ${motioneye_tmp_dir}/motioneye.zip && \
    unzip ${motioneye_tmp_dir}/motioneye.zip -d ${motioneye_extracted_dir} && \
    mkdir -p /var/log/motioneye && \
    mkdir -p /var/lib/motioneye && \
    python3 -m pip install --no-cache-dir --upgrade ${motioneye_extracted_dir}/motioneye-0.43.1b1/ && \
    rm -rf ${motioneye_extracted_dir} && \
    rm -rf ${motioneye_tmp_dir}

# Set permissions
RUN chown -R motioneye_usr ${motioneye_data_dir} \
    && chown -R motion:motion ${motioneye_tmp_dir} \
    && chown -R motion:motion ${motioneye_extracted_dir}} \
    && chown -R motion:motion ${motioneye_config_dir} \
    && chown -R motion:motion /var/lib/motioneye \
    && chown -R motion:motion /var/log/motioneye

# Set the default environment variables (and clear the motioneye password)
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=${TZ} \
    motioneye_usr_password="" \
    motioneye_data_dir=${motioneye_data_dir} \
    motioneye_tmp_dir=${motioneye_tmp_dir} \
    motioneye_extracted_dir=${motioneye_extracted_dir} \
    motioneye_config_dir=${motioneye_config_dir}

# Cleanup
RUN apt-get -qq autopurge uninstall 

# Motioneye data
VOLUME /opt/motioneye

# Videos and images
VOLUME /var/lib/motioneye

# Expose the default port
EXPOSE 8765

ENTRYPOINT ["/start_motioneye.sh"]