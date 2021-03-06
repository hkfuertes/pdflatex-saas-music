FROM       ubuntu:16.04
MAINTAINER Miguel Fuertes

ENV DEBIAN_FRONTEND "noninteractive"

WORKDIR /opt/pdflatex

COPY index.js .
COPY package.json .

RUN set -xe && \

    # install texlive
    apt-get update -qqy && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        texlive-latex-base \
        texlive-latex-extra \
        texlive-music \
        texlive-lang-spanish \
    && \

    # install nodejs v6
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y \
        nodejs \
        # Optional: install build tools
        # To compile and install native addons from npm you may also need to install build tools:
        build-essential \
    && \

    # update npm packages
    npm -g update npm && \

    # install forever
    npm install -g forever && \

    # install app files
    npm install

EXPOSE 5050

CMD ["forever", "/opt/pdflatex/index.js"]
