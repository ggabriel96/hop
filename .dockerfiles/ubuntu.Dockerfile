FROM ubuntu:20.04
ARG USERNAME=hop
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# password is `hop`
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -p1nwAnqk8LEzUo -G sudo

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y fontconfig python3 python3-pip sudo unzip

USER ${USERNAME}
WORKDIR /home/${USERNAME}/
RUN pip install ansible

ENTRYPOINT [ "bash" ]
CMD [ ]