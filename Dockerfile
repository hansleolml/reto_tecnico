FROM nginxdemos/hello

COPY edithtml.sh /edithtml.sh
CMD ["/edithtml.sh"]