FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY src/VulnerabilityTracker.Domain/VulnerabilityTracker.Domain.csproj src/VulnerabilityTracker.Domain/
COPY src/VulnerabilityTracker.Application/VulnerabilityTracker.Application.csproj src/VulnerabilityTracker.Application/
COPY src/VulnerabilityTracker.Infrastructure/VulnerabilityTracker.Infrastructure.csproj src/VulnerabilityTracker.Infrastructure/
COPY src/VulnerabilityTracker.API/VulnerabilityTracker.API.csproj src/VulnerabilityTracker.API/
RUN dotnet restore src/VulnerabilityTracker.API/VulnerabilityTracker.API.csproj

COPY src/ src/
RUN dotnet publish src/VulnerabilityTracker.API/VulnerabilityTracker.API.csproj \
    --configuration Release --no-restore --output /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "VulnerabilityTracker.API.dll"]
