FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/kamatama41/tfenv.git /usr/share/.tfenv \
    && ln -s /usr/share/.tfenv/bin/* /usr/local/bin/

RUN tfenv install 1.10.5 && tfenv use 1.10.5

RUN apt-get update && apt-get install -y pre-commit \
    && curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

WORKDIR /workspace

RUN useradd -m github && mkdir -p /workspace && chown github:github /workspace

USER github

CMD ["bash"]