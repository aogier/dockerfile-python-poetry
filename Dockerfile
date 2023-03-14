ARG PYTHON_VERSION=3.10
FROM python:${PYTHON_VERSION}-slim-bullseye

ARG EXTRA_PACKAGES
ARG POETRY_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008,DL3015
RUN set -x;\
    apt-get update \
    && apt-get install -y \
        curl \
        $EXTRA_PACKAGES \
    && curl \
        -sSL https://install.python-poetry.org \
        | python - --version=$POETRY_VERSION \
    && apt-get remove -y curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/root/.local/bin:$PATH
