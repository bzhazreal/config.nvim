FROM fedora:34

ARG _GROUP=ansible-group
ARG _USER=ansible-user
ARG _UID=1000
ARG _GID=1000

RUN groupadd -g "${_GID}" "${_GROUP}" \
    && adduser -m --uid "${_UID}" -g "${_GROUP}" "${_USER}"

USER "${_USER}"

WORKDIR /home/"${_USER}"