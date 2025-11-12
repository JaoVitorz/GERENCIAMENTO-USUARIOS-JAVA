# Diagnostico completo do Java

Write-Host "=== DIAGNOSTICO COMPLETO DO JAVA ===" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar se java.exe existe
Write-Host "1. Verificando instalacao do Java..." -ForegroundColor Yellow
$javaPath = "C:\Program Files\Eclipse Adoptium\jdk-25.0.1.8-hotspot\bin\java.exe"

if (Test-Path $javaPath) {
    Write-Host "[OK] java.exe encontrado em: $javaPath" -ForegroundColor Green
    
    # Testar executar diretamente
    Write-Host ""
    Write-Host "Testando execucao direta..." -ForegroundColor Yellow
    & $javaPath -version
} else {
    Write-Host "[ERRO] java.exe NAO encontrado!" -ForegroundColor Red
    Write-Host "Procurando em outros locais..." -ForegroundColor Yellow
    
    $locais = @(
        "C:\Program Files\Eclipse Adoptium",
        "C:\Program Files\Java",
        "C:\Program Files (x86)\Java"
    )
    
    foreach ($local in $locais) {
        if (Test-Path $local) {
            Write-Host "Verificando: $local" -ForegroundColor Gray
            $pastas = Get-ChildItem -Path $local -Directory -ErrorAction SilentlyContinue
            foreach ($pasta in $pastas) {
                $j = Join-Path $pasta.FullName "bin\java.exe"
                if (Test-Path $j) {
                    Write-Host "[OK] Encontrado: $($pasta.FullName)" -ForegroundColor Green
                    $javaPath = $j
                    break
                }
            }
        }
    }
}

Write-Host ""
Write-Host "2. Verificando PATH atual..." -ForegroundColor Yellow
$path = [System.Environment]::GetEnvironmentVariable("Path", "User")
$pathSistema = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Host "PATH do usuario:" -ForegroundColor Cyan
if ($path) {
    $pathSplit = $path -split ';'
    foreach ($p in $pathSplit) {
        if ($p -like "*Java*" -or $p -like "*Eclipse*" -or $p -like "*Adoptium*") {
            Write-Host "  [ENCONTRADO] $p" -ForegroundColor Green
        }
    }
} else {
    Write-Host "  [VAZIO]" -ForegroundColor Red
}

Write-Host ""
Write-Host "3. Verificando JAVA_HOME..." -ForegroundColor Yellow
$javaHome = [System.Environment]::GetEnvironmentVariable("JAVA_HOME", "User")
if ($javaHome) {
    Write-Host "[OK] JAVA_HOME: $javaHome" -ForegroundColor Green
} else {
    Write-Host "[ERRO] JAVA_HOME nao configurado" -ForegroundColor Red
}

Write-Host ""
Write-Host "4. Testando comando java..." -ForegroundColor Yellow
try {
    $result = java -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Comando java funciona!" -ForegroundColor Green
        Write-Host $result[0]
    } else {
        Write-Host "[ERRO] Comando java nao funciona" -ForegroundColor Red
    }
} catch {
    Write-Host "[ERRO] Comando java nao encontrado" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== SOLUCAO ===" -ForegroundColor Cyan
Write-Host ""

# Extrair caminho do java.exe
$javaDir = Split-Path (Split-Path $javaPath)
$javaBin = Join-Path $javaDir "bin"

Write-Host "Caminho do Java: $javaDir" -ForegroundColor White
Write-Host "Caminho do bin: $javaBin" -ForegroundColor White
Write-Host ""

Write-Host "Para configurar, execute estes comandos:" -ForegroundColor Yellow
Write-Host ""
Write-Host "# Configurar JAVA_HOME" -ForegroundColor Cyan
Write-Host "[System.Environment]::SetEnvironmentVariable('JAVA_HOME', '$javaDir', 'User')" -ForegroundColor White
Write-Host ""
Write-Host "# Adicionar ao PATH" -ForegroundColor Cyan
Write-Host "`$currentPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')" -ForegroundColor White
Write-Host "[System.Environment]::SetEnvironmentVariable('Path', '$javaBin;' + `$currentPath, 'User')" -ForegroundColor White
Write-Host ""

Write-Host "OU use a interface grafica:" -ForegroundColor Yellow
Write-Host "1. Win+R -> sysdm.cpl" -ForegroundColor Cyan
Write-Host "2. Avancado -> Variaveis de Ambiente" -ForegroundColor Cyan
Write-Host "3. Adicione JAVA_HOME: $javaDir" -ForegroundColor Cyan
Write-Host "4. Edite Path e adicione: $javaBin" -ForegroundColor Cyan
Write-Host ""

Write-Host "Pressione Enter para sair..."
Read-Host

