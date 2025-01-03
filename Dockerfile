# environment for a BinderHub deployment that hosts
# the Getting Started jupyer notebook

FROM python:3.13-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN pip install --user "delb[https-loader]>=0.5rc2"

# copy notebook files
COPY *.ipynb ${HOME}/
