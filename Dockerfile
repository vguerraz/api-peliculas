FROM python:3.11-slim-buster

#Create app directory
RUN mkdir /api-peliculas
#setup wprking directory
WORKDIR /api-peliculas
#install dependencies ubuntu & Curl
RUN apt-get update
RUN apt-get install -y curl 
#Copy application
COPY . /api-peliculas/
#Install application dependencies
RUN pip3 install -r /api-peliculas/requirements.txt
#Define enviroments variable
ENV FLASK_APP "entrypoint:app"
ENV FLASK_ENV "development"
ENV APP_SETTINGS_MODULE "config.default"
ENV DUMMY "config.default"
ENV PORT 5432
#init db and create schemas
RUN flask db init
#RUN flask db revision --rev-id
RUN flask db migrate
RUN flask db upgrade

EXPOSE ${PORT}
#init flask with map any ip outside from container
CMD ["flask", "run", "--host", "0.0.0.0"]