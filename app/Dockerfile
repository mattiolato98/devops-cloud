# pull official base image
FROM python:3.13.0-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables 
ENV PIP_DISABLE_VERSION_CHECK=1
ENV PYTHONWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install mysql dependencies
RUN apk update \
     && apk add --no-cache gcc musl-dev mariadb-connector-c-dev

# copy requirements
COPY ./requirements.txt .

# install dependencies
RUN pip install --upgrade pip \
     && pip install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
