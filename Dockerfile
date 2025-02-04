FROM ubuntu:22.04

ENV TARGETARCH="linux-x64"
# Also can be "linux-arm", "linux-arm64".

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl git jq libicu70

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
# ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ["./start.sh"]



# FROM ubuntu:20.04
# RUN DEBIAN_FRONTEND=noninteractive apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
#     apt-transport-https \
#     apt-utils \
#     ca-certificates \
#     curl \
#     git \
#     iputils-ping \
#     jq \
#     lsb-release \
#     software-properties-common

# RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# # Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
# ENV TARGETARCH=linux-x64

# WORKDIR /azp

# COPY ./start.sh .
# RUN chmod +x start.sh

# ENTRYPOINT [ "./start.sh" ]