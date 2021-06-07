FROM fedora:34
ARG USERNAME=hop
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# password is `hop`
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -p1nwAnqk8LEzUo -G wheel

RUN dnf update -y
RUN dnf install -y fontconfig unzip which

USER ${USERNAME}
WORKDIR /home/${USERNAME}/
RUN pip install ansible

ENTRYPOINT [ "bash" ]
CMD [ ]
