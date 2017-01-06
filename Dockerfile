FROM fedora:21

MAINTAINER Mikulas Dite <mikulas@mangoweb.cz>

ENV shellcheckTag v0.4.4

RUN useradd shellcheck \
    && yum install --setopt=tsflags=nodocs --nogpgcheck --assumeyes --quiet \
		cabal-install \
		tar \
    && yum clean all \
    && rm -rf /var/cache/yum

USER shellcheck

RUN cabal update \
    && curl -Lso /tmp/shellcheck-$shellcheckTag.tar.gz https://github.com/koalaman/shellcheck/archive/$shellcheckTag.tar.gz \
    && tar zxf /tmp/shellcheck-$shellcheckTag.tar.gz -C /tmp/ \
    && rm /tmp/shellcheck-$shellcheckTag.tar.gz \
    && cabal install /tmp/shellcheck-$shellcheckTag

ENTRYPOINT ["/home/shellcheck/.cabal/bin/shellcheck"]
CMD ["-s", "bash", "*.sh"]
