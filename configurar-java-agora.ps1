# Configurar Java automaticamente - JDK 25 encontrado

Write-Host "=== Configurando Java JDK 25 ===" -ForegroundColor Cyan
Write-Host ""

$javaHome = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot"
$javaBin = "$javaHome\bin"

# Verificar se existe
if (-not (Test-Path "$javaBin\java.exe")) {
    Write-Host "[ERRO] Java nao encontrado em: $javaBin" -ForegroundColor Red
    exit
}

Write-Host "Java encontrado em: $javaHome" -ForegroundColor Green
Write-Host ""

# Configurar JAVA_HOME
Write-Host "Configurando JAVA_HOME..." -ForegroundColor Yellow
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
Write-Host "[OK] JAVA_HOME configurado!" -ForegroundColor Green

# Adicionar ao PATH
Write-Host "Adicionando ao PATH..." -ForegroundColor Yellow
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$javaBin*") {
    $newPath = "$javaBin;$currentPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "[OK] Java adicionado ao PATH!" -ForegroundColor Green
} else {
    Write-Host "[INFO] Java ja esta no PATH" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Configuracao Concluida! ===" -ForegroundColor Green
Write-Host ""
Write-Host "JAVA_HOME: $javaHome" -ForegroundColor White
Write-Host "PATH: $javaBin" -ForegroundColor White
Write-Host ""
Write-Host "PROXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "1. FECHE completamente este PowerShell" -ForegroundColor Cyan
Write-Host "2. Abra um NOVO PowerShell" -ForegroundColor Cyan
Write-Host "3. Execute: java -version" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

