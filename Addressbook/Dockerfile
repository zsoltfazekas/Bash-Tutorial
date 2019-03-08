FROM alpine:3.7
COPY . /code
WORKDIR /code/
RUN touch database/addressbook.db
RUN chmod +x src/*.sh src/module/*.sh
