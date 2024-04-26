FROM registry.access.redhat.com/ubi9:9.3-1610
RUN dnf install -y \
    ghostscript \
    perl 
RUN curl -O https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/enscript-1.6.6-28.el9.x86_64.rpm
RUN rpm -ivh https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/enscript-1.6.6-28.el9.x86_64.rpm

RUN mkdir /opt/incoming
RUN mkdir /opt/outgoing
RUN echo "while true"  >> /usr/local/bin/ascii2pdf
RUN echo "do"  >> /usr/local/bin/ascii2pdf
RUN echo "CURRENT_DIR='/opt/incoming'"  >> /usr/local/bin/ascii2pdf
RUN echo "#app=#(ls -Art1 datas | tail -n 1)"  >> /usr/local/bin/ascii2pdf
RUN echo "text1 "  >> /usr/local/bin/ascii2pdf
RUN echo "enscript /opt/incoming/-o - | ps2pdf - /opt/outgoing/.txt"  >> /usr/local/bin/ascii2pdf
RUN echo "done"  >> /usr/local/bin/ascii2pdf
RUN sed -i 's/text1/echo $FILE/g' /usr/local/bin/ascii2pdf
RUN sed -i 's/-o/$FILE  -o/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/.txt/$FILE/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/#app=#/FILE=$/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/datas/${CURRENT_DIR}/g'  /usr/local/bin/ascii2pdf
RUN chmod 777 /usr/local/bin/ascii2pdf
CMD [ "/bin/bash", "-c", "/usr/local/bin/ascii2pdf" ]
