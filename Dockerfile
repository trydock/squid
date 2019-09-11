FROM alpine

RUN echo "Installing Squid3"
RUN apk add --no-cache squid bash vim
RUN echo "Copying entrypoint.sh"
COPY entrypoint.sh /entrypoint.sh
RUN echo "Adding entrypoint.sh"
RUN chmod 755 /entrypoint.sh

EXPOSE 3128 3129 3130

ENTRYPOINT ["/entrypoint.sh"]
