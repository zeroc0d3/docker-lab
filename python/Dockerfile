FROM zeroc0d3lab/centos-base-workspace-lite:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

#-----------------------------------------------------------------------------
# Set Environment
#-----------------------------------------------------------------------------
ENV PATH_HOME=/home/docker \
    PATH_WORKSPACE=/home/docker/workspace

#-----------------------------------------------------------------------------
# Install Python 3.5
#-----------------------------------------------------------------------------
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y update \
    && yum -y install python35u python35u-libs python35u-devel python35u-pip 

#-----------------------------------------------------------------------------
# Install Python 2.7
#-----------------------------------------------------------------------------
# RUN yum -y rpm-build \
#         redhat-rpm-config \
#         yum-utils \
#     && yum -y groupinstall "Development Tools" \
#     && sudo yum-builddep -y python-2.7.11-4.fc24.src.rpm \
#     && mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} \
#     && cd ~/rpmbuild/SRPMS \
#     && curl -O https://kojipkgs.fedoraproject.org//packages/python/2.7.11/4.fc24/src/python-2.7.11-4.fc24.src.rpm \
#     && cd ~/rpmbuild/SRPMS \
#     && rpmbuild --rebuild python-2.7.11-4.fc24.src.rpm \
#     && cd ~/rpmbuild/SPECS/ \
#     && sed -i -e "s/^%global run_selftest_suite 1/%global run_selftest_suite 0/g" python.spec  # OPTIONAL \
#     && rpmbuild -ba python.spec \
#     && cd ~/rpmbuild/SRPMS/ \
#     && rpmbuild --rebuild python2711-2.7.11-4.el7.centos.src.rpm \
#     && cd ~/rpmbuild/RPMS/ \
#     && sudo yum localinstall --nogpgcheck python-libs-2.7.11-4.el7.centos.x86_64.rpm python-2.7.11-4.el7.centos.x86_64.rpm

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN yum clean all

#-----------------------------------------------------------------------------
# Set Configuration
#-----------------------------------------------------------------------------
COPY rootfs/ /

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
# Create Workspace Application Folder
#-----------------------------------------------------------------------------
RUN mkdir -p ${PATH_WORKSPACE} \
    mkdir -p /var/run/s6

#-----------------------------------------------------------------------------
# Fixing ownership for 'docker' user
#-----------------------------------------------------------------------------
RUN chown -R docker:docker ${PATH_HOME}

#-----------------------------------------------------------------------------
# Set PORT Docker Container
#-----------------------------------------------------------------------------
EXPOSE 22

#-----------------------------------------------------------------------------
# Set Volume Application
#-----------------------------------------------------------------------------
VOLUME [${PATH_WORKSPACE}]

#-----------------------------------------------------------------------------
# Run Init Docker Container
#-----------------------------------------------------------------------------
ENTRYPOINT ["/init"]
CMD []
