@echo off
echo ========================================
echo    MONITORAMENTO API SPRING BOOT
echo ========================================
echo.

echo [1/4] Verificando se o Docker esta rodando...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Docker nao esta rodando!
    echo Por favor, inicie o Docker Desktop e tente novamente.
    pause
    exit /b 1
)
echo ✓ Docker esta rodando

echo.
echo [2/4] Verificando se a API Spring Boot esta rodando...
curl -s http://localhost:8080/actuator/health >nul 2>&1
if %errorlevel% neq 0 (
    echo AVISO: API Spring Boot nao esta respondendo em localhost:8080
    echo Certifique-se de que a API esta rodando antes de continuar.
    echo.
    set /p continue="Deseja continuar mesmo assim? (s/n): "
    if /i not "%continue%"=="s" (
        echo Operacao cancelada.
        pause
        exit /b 1
    )
) else (
    echo ✓ API Spring Boot esta respondendo
)

echo.
echo [3/4] Iniciando Prometheus e Grafana...
docker-compose up -d
if %errorlevel% neq 0 (
    echo ERRO: Falha ao iniciar os servicos!
    pause
    exit /b 1
)
echo ✓ Servicos iniciados com sucesso

echo.
echo [4/4] Aguardando servicos ficarem prontos...
timeout /t 10 /nobreak >nul

echo.
echo ========================================
echo    AMBIENTE DE MONITORAMENTO ATIVO
echo ========================================
echo.
echo 📊 Prometheus: http://localhost:9090
echo 📈 Grafana:    http://localhost:3000
echo                Usuario: admin
echo                Senha:   admin123
echo.
echo 🔍 Para verificar o status dos servicos:
echo    docker-compose ps
echo.
echo 📋 Para ver os logs:
echo    docker-compose logs -f
echo.
echo 🛑 Para parar os servicos:
echo    docker-compose down
echo.
echo Pressione qualquer tecla para abrir o Grafana...
pause >nul
start http://localhost:3000

echo.
echo Ambiente de monitoramento configurado com sucesso! 🎉
pause 