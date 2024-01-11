ARG PYTHON_VERSION=3.12

FROM alpine as clone

RUN apk add git

ARG GIT_REPO="TempProgram"
ARG GIT_OWNER=PythonCoderAS
ARG GIT_CLONE_URL="https://github.com/${GIT_OWNER}/${GIT_REPO}.git"
ARG GIT_BRANCH=master

RUN git clone --depth 1 --branch ${GIT_BRANCH} ${GIT_CLONE_URL} /app
RUN rm -rf /app/.git

FROM python:${PYTHON_VERSION}-slim as final
COPY --from=clone /app /app
WORKDIR /app
RUN apt update && apt install gcc libc-dev bash zsh openjdk8-jdk
ENTRYPOINT [ "python3", "/app/main.py" ]
