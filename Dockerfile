FROM mcr.microsoft.com/mssql/server:2019-CTP3.1-ubuntu
ENV SA_PASSWORD DiddleDoo2019
ENV TMP_BAK /tmp/AdventureWorks2017.bak


RUN apt-get update -qq && apt-get install -qqy apt-utils curl wget
# RUN curl https://packages.microsoft.com/keys/microsoft.asc |  apt-key add -
# RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get install -qqy  mssql-tools unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
# RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && source ~/.bashrc

RUN curl https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak \
	--location --output $TMP_BAK

WORKDIR /var/opt/mssql/data
RUN chmod -R +w ./

WORKDIR /var
COPY startup.sh ./
COPY startup.sql ./
RUN chmod +x startup.sh

ENTRYPOINT [ "/bin/bash", "-c", "/var/startup.sh" ];
