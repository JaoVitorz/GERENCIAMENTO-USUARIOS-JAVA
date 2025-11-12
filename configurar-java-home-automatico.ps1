# Script para configurar JAVA_HOME automaticamente

Write-Host "=== Configurador Automatico de JAVA_HOME ===" -ForegroundColor Cyan
Write-Host ""

# Procurar Java instalado
Write-Host "Procurando Java instalado..." -ForegroundColor Yellow

$locais = @(
    "C:\Program Files\Eclipse Adoptium",
    "C:\Program Files\Java",
    "C:\Program Files (x86)\Java",
    "$env:LOCALAPPDATA\Programs\Eclipse Adoptium"
)

$javaEncontrado = $null

foreach ($local in $locais) {
    if (Test-Path $local) {
        Write-Host "Verificando: $local" -ForegroundColor Gray
        $pastas = Get-ChildItem -Path $local -Directory -ErrorAction SilentlyContinue
        
        foreach ($pasta in $pastas) {
            $javaExe = Join-Path $pasta.FullName "bin\java.exe"
            if (Test-Path $javaExe) {
                $javaEncontrado = $pasta.FullName
                Write-Host "[OK] Java encontrado: $javaEncontrado" -ForegroundColor Green
                break
            }
        }
        
        if ($javaEncontrado) { break }
    }
}

if (-not $javaEncontrado) {
    Write-Host "[ERRO] Java nao encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Por favor, informe o caminho do Java manualmente:" -ForegroundColor Yellow
    $javaEncontrado = Read-Host "Digite o caminho completo (ex: C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot)"
    
    # Verificar se o caminho e valido
    $javaExe = Join-Path $javaEncontrado "bin\java.exe"
    if (-not (Test-Path $javaExe)) {
        Write-Host "[ERRO] Caminho invalido! java.exe nao encontrado em: $javaExe" -ForegroundColor Red
        Write-Host "Pressione Enter para sair..."
        Read-Host
        exit
    }
}

Write-Host ""
Write-Host "=== Configurando JAVA_HOME ===" -ForegroundColor Cyan
Write-Host "JAVA_HOME sera configurado como: $javaEncontrado" -ForegroundColor Yellow
Write-Host ""

# Configurar JAVA_HOME
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $javaEncontrado, "User")
Write-Host "[OK] JAVA_HOME configurado!" -ForegroundColor Green

# Verificar se ja esta no PATH
$binPath = Join-Path $javaEncontrado "bin"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$binPath*") {
    Write-Host ""
    Write-Host "=== Adicionando ao PATH ===" -ForegroundColor Cyan
    $newPath = "$binPath;$currentPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "[OK] Java adicionado ao PATH!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[INFO] Java ja esta no PATH" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Configuracao Concluida! ===" -ForegroundColor Green
Write-Host ""
Write-Host "JAVA_HOME: $javaEncontrado" -ForegroundColor White
Write-Host "PATH contem: $binPath" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANTE:" -ForegroundColor Yellow
Write-Host "1. FECHE completamente o PowerShell" -ForegroundColor Cyan
Write-Host "2. Abra um novo PowerShell" -ForegroundColor Cyan
Write-Host "3. Teste: java -version" -ForegroundColor Cyan
Write-Host "4. Teste: echo `$env:JAVA_HOME" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

