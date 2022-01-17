FROM fedora:35

ARG _GROUP=test-group
ARG _USER=test-user
ARG _UID=1000
ARG _GID=1000

RUN groupadd -g "${_GID}" "${_GROUP}" \
    && adduser -m --uid "${_UID}" -g "${_GROUP}" "${_USER}" \
    && echo "${_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER "${_USER}"

WORKDIR /home/"${_USER}"

COPY --chown="${_USER}":"${_GROUP}" install.sh ./install.sh
COPY --chown="${_USER}":"${_GROUP}" src/ ./src

RUN bash install.sh
