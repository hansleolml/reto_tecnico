FROM nginxdemos/hello

COPY edithtml.sh /edithtml.sh
RUN chmod +x /edithtml.sh

CMD ["/edithtml.sh"]