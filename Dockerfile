FROM fedora:21

MAINTAINER Mikulas Dite <mikulas@mangoweb.cz>

ENV shellcheckVersion 0.4.5

# Install dependencies
RUN useradd shellcheck \
    && yum install --setopt=tsflags=nodocs --nogpgcheck --assumeyes --quiet \
		tar \
		zlib-devel \
	&& yum clean all \
    && rm -rf /var/cache/yum

# Install Cabal
RUN curl -Lso /tmp/cabal.tar.gz \
		https://github.com/haskell/cabal/archive/cabal-install-v1.24.0.2.tar.gz \
	&& tar zxf /tmp/cabal.tar.gz -C /tmp/ \
	&& rm /tmp/cabal.tar.gz \
	&& (cd Cabal; cabal install) \
	&& (cd cabal-install; cabal install)

USER shellcheck

# Install ShellCheck
RUN curl -Lso /tmp/shellcheck-$shellcheckVersion.tar.gz \
		https://github.com/koalaman/shellcheck/archive/v$shellcheckVersion.tar.gz \
    && tar zxf /tmp/shellcheck-$shellcheckVersion.tar.gz -C /tmp/ \
    && rm /tmp/shellcheck-$shellcheckVersion.tar.gz \
    && cabal install /tmp/shellcheck-$shellcheckVersion

ENTRYPOINT ["/home/shellcheck/.cabal/bin/shellcheck"]
CMD ["-s", "bash", "*.sh"]
