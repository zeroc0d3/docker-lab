FROM zeroc0d3lab/centos-application-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace \
    PATH_APPLICATION=/home/docker/workspace
		
USER root
#-----------------------------------------------------------------------------
# Set Configuration
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Change 'root' & 'docker' user Password
#-----------------------------------------------------------------------------
# RUN echo 'root:'${SSH_ROOT_PASSWORD} | chpasswd
RUN echo 'root:docker' | chpasswd \
    && echo 'docker:docker' | chpasswd

#-----------------------------------------------------------------------------
# Generate Public Key
#-----------------------------------------------------------------------------
# Create new public key
RUN /usr/bin/ssh-keygen -t rsa -b 4096 -C "zeroc0d3.team@gmail.com" -f $HOME/.ssh/id_rsa -q -N ""; sync

RUN mkdir -p $HOME/.ssh \
    && touch $HOME/.ssh/authorized_keys \
    && chmod 700 $HOME/.ssh \
    && chmod go-w $HOME $HOME/.ssh \
    && chmod 600 $HOME/.ssh/authorized_keys \
    && chown `whoami` $HOME/.ssh/authorized_keys \
    && cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# Create new pem file from public key
RUN /usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa.pub -e -m pem > $HOME/.ssh/id_rsa.pem

# Create new public key for host
RUN /usr/bin/ssh-keygen -A

RUN mkdir -p /home/docker/.ssh \
    && touch /home/docker/.ssh/authorized_keys \
    && cat $HOME/.ssh/id_rsa.pub > /home/docker/.ssh/authorized_keys \
    && /usr/bin/ssh-keygen -f $HOME/.ssh/id_rsa.pub -e -m pem > /home/docker/.ssh/id_rsa.pem \
    && chmod 700 /home/docker/.ssh \
    && chmod 600 /home/docker/.ssh/authorized_keys \
    && chmod 600 /home/docker/.ssh/id_rsa*

#-----------------------------------------------------------------------------
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_WORKSPACE}

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${PATH_HOME}

#-----------------------------------------------------------------------------
# Cleanup 'root', 'opt' & 'tmp' folder
#-----------------------------------------------------------------------------
RUN rm -f /root/*.tar.gz \
    && rm -f /root/*.zip \
    && rm -f /opt/*.tar.gz \
    && rm -f /opt/*.zip \
    && rm -f /tmp/*.tar.gz \
    && rm -f /tmp/*.zip 

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Docker Workspace
#-----------------------------------------------------------------------------
VOLUME [${PATH_WORKSPACE}]

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
