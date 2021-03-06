FROM ubuntu:14.04
MAINTAINER wagnerpinheiro
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y python python-babel trac subversion ca-certificates
# RUN update-ca-certificates
RUN easy_install Babel Trac

# Plugins:
# http://trac-hacks.org/wiki/HackIndex
RUN easy_install http://trac-hacks.org/svn/ticketimportplugin/0.11
RUN easy_install http://trac-hacks.org/svn/visualizationplugin/
RUN easy_install http://trac-hacks.org/svn/awesomeattachmentsplugin/
# http://trac-hacks.org/wiki/TracSqlPlugin
RUN easy_install tracsql
# http://trac-hacks.org/wiki/GanttCalendarPlugin
# não funciona adequadamente com o Agilo, tem um bug para o ano a ser apresentado
# RUN easy_install https://github.com/recurser/trac-gantt-calendar/tarball/master
# http://trac-hacks.org/wiki/JqChartMacro
RUN easy_install http://trac-hacks.org/svn/jqchartmacro/
# http://trac-hacks.org/wiki/StatusHistoryChartMacro
RUN easy_install http://trac-hacks.org/svn/statushistorychartmacro/
# http://trac-hacks.org/wiki/TicketChartsMacro
RUN easy_install http://trac-hacks.org/svn/ticketchartsmacro/
# http://trac-hacks.org/wiki/VotePlugin
RUN easy_install http://trac-hacks.org/svn/voteplugin/tags/0.1.5

ADD ./vendor/agilo_source.tar.gz /agilo
RUN cd /agilo/agilo* && python setup.py install

ADD run.sh /tracd/run.sh
RUN chmod +x /tracd/run.sh

EXPOSE 8080
CMD ["/tracd/run.sh"]