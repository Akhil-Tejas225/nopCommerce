FROM mcr.microsoft.com/dotnet/sdk:9.0 AS builder
LABEL "image"="NopCommerce"
LABEL "author"="Akhil"
RUN mkdir project
WORKDIR  /project
COPY /nopCommerce .
RUN mkdir published && dotnet publish -c Release ./src/Presentation/Nop.Web/Nop.Web.csproj -o published/

FROM mcr.microsoft.com/dotnet/aspnet:9.0
LABEL "image"="NopCommerce"
LABEL "author"="Akhil"
RUN useradd -U akhilgc009 -m -d /home/nop -s /bin/bash
WORKDIR /nop
COPY --from=builder --chown=akhilgc009:akhilgc009 project/published/ .
CMD [ "dotnet","Nop.Web.dll","--urls","http://0.0.0.0:5000" ]
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "ping","-c","1","https://0.0.0.0:5000" ]