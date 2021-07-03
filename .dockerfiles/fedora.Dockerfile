FROM fedora:34
ARG USERNAME=hop
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV USER ${USERNAME}

# password is `hop`
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -p1nwAnqk8LEzUo -G wheel

RUN dnf update -y
RUN dnf install -y fontconfig git python-ansible-runner unzip which

USER ${USERNAME}
WORKDIR /home/${USERNAME}/

ENTRYPOINT [ "bash" ]
CMD [ ]
