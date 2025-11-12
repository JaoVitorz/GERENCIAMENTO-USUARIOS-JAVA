# Script rapido para configurar JAVA_HOME apos instalar o JDK

Write-Host "=== Configuracao Rapida do JAVA_HOME ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se java esta funcionando
Write-Host "1. Verificando Java..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1
    Write-Host "[OK] Java encontrado!" -ForegroundColor Green
    Write-Host $javaVersion[0]
    Write-Host ""
} catch {
    Write-Host "[ERRO] Java nao encontrado. Reinicie o terminal e tente novamente." -ForegroundColor Red
    exit
}

# Encontrar o caminho do Java
Write-Host "2. Encontrando caminho do Java..." -ForegroundColor Yellow
$javaPath = (Get-Command java).Source
Write-Host "Caminho encontrado: $javaPath" -ForegroundColor Green

# Extrair JAVA_HOME (remover \bin\java.exe)
$javaHome = $javaPath -replace "\\bin\\java.exe", ""
Write-Host ""
Write-Host "JAVA_HOME sera configurado como: $javaHome" -ForegroundColor Yellow
Write-Host ""

# Confirmar
$confirm = Read-Host "Deseja configurar JAVA_HOME agora? (S/N)"
if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "Cancelado." -ForegroundColor Yellow
    exit
}

# Configurar JAVA_HOME
Write-Host ""
Write-Host "3. Configurando JAVA_HOME..." -ForegroundColor Yellow
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
Write-Host "[OK] JAVA_HOME configurado!" -ForegroundColor Green

# Adicionar ao PATH se necessario
$binPath = Join-Path $javaHome "bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$binPath*") {
    Write-Host "4. Adicionando ao PATH..." -ForegroundColor Yellow
    $newPath = "$binPath;$currentPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "[OK] Adicionado ao PATH!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Configuracao Concluida! ===" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE:" -ForegroundColor Yellow
Write-Host "1. FECHE e REABRA o PowerShell agora!" -ForegroundColor Cyan
Write-Host "2. Depois execute: .\mvnw.cmd spring-boot:run" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

