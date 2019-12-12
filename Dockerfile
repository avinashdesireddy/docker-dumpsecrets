FROM python:latest
EXPOSE 7000
COPY dumpsecrets.sh /
CMD [ "/dumpsecrets.sh" ]
