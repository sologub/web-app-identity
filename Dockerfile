FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

COPY WebAppIdentity.csproj ./
RUN dotnet restore

COPY . ./

RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish ./
ENV ASPNETCORE_URLS="http://*:80"

EXPOSE 80

ENTRYPOINT ["dotnet", "WebAppIdentity.dll"]