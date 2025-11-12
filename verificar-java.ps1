# Script para verificar e configurar Java no Windows

Write-Host "=== Verificando Instalacao do Java ===" -ForegroundColor Cyan
Write-Host ""

# Verificar se java esta no PATH
try {
    $javaVersion = java -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Java encontrado no PATH!" -ForegroundColor Green
        Write-Host $javaVersion[0]
        Write-Host ""
        
        # Tentar encontrar JAVA_HOME
        $javaPath = (Get-Command java).Source
        Write-Host "Caminho do Java: $javaPath" -ForegroundColor Yellow
        
        # Tentar encontrar o JAVA_HOME baseado no caminho
        if ($javaPath -match "Program Files") {
            $possibleJavaHome = $javaPath -replace "\\bin\\java.exe", ""
            Write-Host ""
            Write-Host "JAVA_HOME sugerido: $possibleJavaHome" -ForegroundColor Yellow
        }
    }
} catch {
    Write-Host "[ERRO] Java NAO encontrado no PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Locais comuns de instalacao do Java:" -ForegroundColor Yellow
    Write-Host "  - C:\Program Files\Java\jdk-17"
    Write-Host "  - C:\Program Files\Java\jdk-21"
    Write-Host "  - C:\Program Files\Eclipse Adoptium\jdk-17"
    Write-Host "  - C:\Program Files\Eclipse Adoptium\jdk-21"
    Write-Host ""
}

# Verificar JAVA_HOME atual
Write-Host ""
Write-Host "=== Verificando JAVA_HOME ===" -ForegroundColor Cyan
$currentJavaHome = $env:JAVA_HOME
if ($currentJavaHome) {
    Write-Host "JAVA_HOME atual: $currentJavaHome" -ForegroundColor Green
    $javaExePath = Join-Path $currentJavaHome "bin\java.exe"
    if (Test-Path $javaExePath) {
        Write-Host "[OK] JAVA_HOME aponta para um Java valido!" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] JAVA_HOME nao aponta para um Java valido!" -ForegroundColor Red
    }
} else {
    Write-Host "[ERRO] JAVA_HOME nao esta configurado" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Procurando instalacoes do Java ===" -ForegroundColor Cyan
$commonPaths = @(
    "C:\Program Files\Java",
    "C:\Program Files\Eclipse Adoptium",
    "C:\Program Files (x86)\Java",
    "$env:LOCALAPPDATA\Programs\Eclipse Adoptium"
)

$foundJava = $false
foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        Write-Host "Verificando: $path" -ForegroundColor Yellow
        $javaDirs = Get-ChildItem -Path $path -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "jdk|jre" }
        foreach ($dir in $javaDirs) {
            $javaExe = Join-Path $dir.FullName "bin\java.exe"
            if (Test-Path $javaExe) {
                Write-Host "  [OK] Encontrado: $($dir.FullName)" -ForegroundColor Green
                $foundJava = $true
            }
        }
    }
}

if (-not $foundJava) {
    Write-Host "Nenhuma instalacao do Java encontrada nos locais comuns." -ForegroundColor Red
    Write-Host ""
    Write-Host "Para instalar o Java:" -ForegroundColor Yellow
    Write-Host "1. Acesse: https://adoptium.net/" -ForegroundColor Cyan
    Write-Host "2. Baixe o JDK 17 ou superior" -ForegroundColor Cyan
    Write-Host "3. Execute o instalador" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Pressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
