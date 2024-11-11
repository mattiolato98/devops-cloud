###########
# BUILDER #
###########

# pull official base image
FROM python:3.13.0-alpine AS builder

# set work directory
WORKDIR /usr/src/app

# set environment variables 
ENV PIP_DISABLE_VERSION_CHECK=1
ENV PYTHONWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install mysql dependencies
RUN apk update \
     && apk add --no-cache gcc musl-dev mariadb-connector-c-dev

# lint
RUN pip install --upgrade pip
RUN pip install flake8
RUN flake8 --ignore=E501,F401 .

# install python dependencies
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt


########
# BASE #
########
# pull official image
FROM python:3.13.0-alpine AS base

# install dependencies
RUN apk update && apk add mariadb-connector-c-dev
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache /wheels/*


#######
# DEV #
#######
FROM base AS dev

# set work directory
WORKDIR /usr/src/app

# copy entrypoint.dev.sh
COPY ./entrypoint.dev.sh .
RUN sed -i 's/\r$//g' /usr/src/app/entrypoint.dev.sh
RUN chmod +x /usr/src/app/entrypoint.dev.sh

# copy project
COPY . .

# run entrypoint.dev.sh
ENTRYPOINT ["/usr/src/app/entrypoint.dev.sh"]


########
# PROD #
########
FROM base AS prod

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup -S app && adduser -S app -G app

# set environment variables
ENV HOME=/home/app
ENV APP_HOME=/home/app/web

# create appropriate directories
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles

# set work directory
WORKDIR $APP_HOME

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' $APP_HOME/entrypoint.sh
RUN chmod +x $APP_HOME/entrypoint.sh

# copy project
COPY . $APP_HOME

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

# run entrypoint.sh
ENTRYPOINT ["/home/app/web/entrypoint.sh"]