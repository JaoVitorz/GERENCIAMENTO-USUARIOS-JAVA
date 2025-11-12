# Script para testar se Java esta funcionando

Write-Host "=== Testando Java ===" -ForegroundColor Cyan
Write-Host ""

# Teste 1: Comando correto (um hifen)
Write-Host "1. Testando: java -version" -ForegroundColor Yellow
try {
    $result = java -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Java funciona!" -ForegroundColor Green
        Write-Host $result[0]
    } else {
        Write-Host "[ERRO] Java nao funciona" -ForegroundColor Red
    }
} catch {
    Write-Host "[ERRO] Comando java nao encontrado" -ForegroundColor Red
}

Write-Host ""

# Teste 2: Verificar se esta no PATH
Write-Host "2. Verificando PATH..." -ForegroundColor Yellow
$path = $env:Path -split ';'
$javaNoPath = $path | Where-Object { $_ -like "*Java*" -or $_ -like "*Eclipse*" -or $_ -like "*Adoptium*" }

if ($javaNoPath) {
    Write-Host "[OK] Java encontrado no PATH:" -ForegroundColor Green
    foreach ($p in $javaNoPath) {
        Write-Host "  - $p" -ForegroundColor White
    }
} else {
    Write-Host "[ERRO] Java NAO encontrado no PATH" -ForegroundColor Red
}

Write-Host ""

# Teste 3: Verificar JAVA_HOME
Write-Host "3. Verificando JAVA_HOME..." -ForegroundColor Yellow
if ($env:JAVA_HOME) {
    Write-Host "[OK] JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Green
    if (Test-Path "$env:JAVA_HOME\bin\java.exe") {
        Write-Host "[OK] java.exe encontrado em JAVA_HOME" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] java.exe NAO encontrado em JAVA_HOME" -ForegroundColor Red
    }
} else {
    Write-Host "[ERRO] JAVA_HOME nao configurado" -ForegroundColor Red
}

Write-Host ""

# Teste 4: Procurar Java instalado
Write-Host "4. Procurando Java instalado..." -ForegroundColor Yellow
$locais = @(
    "C:\Program Files\Java",
    "C:\Program Files\Eclipse Adoptium",
    "C:\Program Files (x86)\Java"
)

$encontrado = $false
foreach ($local in $locais) {
    if (Test-Path $local) {
        $pastas = Get-ChildItem -Path $local -Directory -ErrorAction SilentlyContinue
        foreach ($pasta in $pastas) {
            $javaExe = Join-Path $pasta.FullName "bin\java.exe"
            if (Test-Path $javaExe) {
                Write-Host "[OK] Java encontrado em: $($pasta.FullName)" -ForegroundColor Green
                Write-Host "   Caminho completo: $javaExe" -ForegroundColor White
                $encontrado = $true
            }
        }
    }
}

if (-not $encontrado) {
    Write-Host "[ERRO] Java nao encontrado nos locais comuns" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Resumo ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "COMANDO CORRETO: java -version (um hifen, nao dois)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Se Java nao funciona:" -ForegroundColor Yellow
Write-Host "1. Execute: .\encontrar-java.ps1" -ForegroundColor Cyan
Write-Host "2. Adicione o caminho \bin ao PATH" -ForegroundColor Cyan
Write-Host "3. Feche e reabra o PowerShell" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

