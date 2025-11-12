# Script para configurar JAVA_HOME no Windows
# Execute como Administrador para configurar para todos os usuários
# Ou execute normalmente para configurar apenas para o usuário atual

param(
    [string]$JavaPath = ""
)

Write-Host "=== Configurador de JAVA_HOME ===" -ForegroundColor Cyan
Write-Host ""

if ([string]::IsNullOrEmpty($JavaPath)) {
    Write-Host "Por favor, informe o caminho do Java (JDK)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Exemplos:" -ForegroundColor Cyan
    Write-Host "  C:\Program Files\Java\jdk-17"
    Write-Host "  C:\Program Files\Eclipse Adoptium\jdk-17.0.9+9"
    Write-Host ""
    
    $JavaPath = Read-Host "Digite o caminho completo do Java"
}

# Verificar se o caminho existe
if (-not (Test-Path $JavaPath)) {
    Write-Host "✗ Erro: O caminho '$JavaPath' não existe!" -ForegroundColor Red
    exit 1
}

# Verificar se existe java.exe
$javaExe = Join-Path $JavaPath "bin\java.exe"
if (-not (Test-Path $javaExe)) {
    Write-Host "✗ Erro: Não foi encontrado java.exe em '$JavaPath\bin\'" -ForegroundColor Red
    Write-Host "Certifique-se de que o caminho aponta para a pasta do JDK (não para bin)" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Java encontrado em: $JavaPath" -ForegroundColor Green
Write-Host ""

# Verificar se está executando como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "Configurando JAVA_HOME para TODOS os usuários (modo Administrador)" -ForegroundColor Yellow
    [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $JavaPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "✓ JAVA_HOME configurado no sistema" -ForegroundColor Green
} else {
    Write-Host "Configurando JAVA_HOME apenas para o usuário atual" -ForegroundColor Yellow
    [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $JavaPath, [System.EnvironmentVariableTarget]::User)
    Write-Host "✓ JAVA_HOME configurado para o usuário" -ForegroundColor Green
    Write-Host ""
    Write-Host "Nota: Para configurar para todos os usuários, execute este script como Administrador" -ForegroundColor Yellow
}

# Atualizar PATH se necessário
$binPath = Join-Path $JavaPath "bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
if ($currentPath -notlike "*$binPath*") {
    $newPath = "$binPath;$currentPath"
    if ($isAdmin) {
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    } else {
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
    }
    Write-Host "✓ Adicionado ao PATH: $binPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Configuração Concluída! ===" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE:" -ForegroundColor Yellow
Write-Host "1. Feche e reabra o terminal/PowerShell" -ForegroundColor Cyan
Write-Host "2. Execute: java -version" -ForegroundColor Cyan
Write-Host "3. Execute: echo `$env:JAVA_HOME" -ForegroundColor Cyan
Write-Host ""
Write-Host "Se ainda não funcionar, reinicie o computador." -ForegroundColor Yellow

