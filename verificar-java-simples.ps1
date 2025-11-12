Write-Host "Verificando Java..." -ForegroundColor Cyan
Write-Host ""

# Verificar se java esta no PATH
$javaCheck = java -version 2>&1
if ($?) {
    Write-Host "[OK] Java encontrado!" -ForegroundColor Green
    Write-Host $javaCheck[0]
    Write-Host ""
    $javaPath = (Get-Command java).Source
    Write-Host "Caminho: $javaPath" -ForegroundColor Yellow
    $javaHome = $javaPath -replace "\\bin\\java.exe", ""
    Write-Host "JAVA_HOME sugerido: $javaHome" -ForegroundColor Yellow
} else {
    Write-Host "[ERRO] Java nao encontrado no PATH" -ForegroundColor Red
}

Write-Host ""
Write-Host "JAVA_HOME atual: $env:JAVA_HOME" -ForegroundColor Cyan

Write-Host ""
Write-Host "Procurando Java instalado..." -ForegroundColor Cyan
$paths = @("C:\Program Files\Java", "C:\Program Files\Eclipse Adoptium")
foreach ($p in $paths) {
    if (Test-Path $p) {
        Write-Host "Verificando: $p" -ForegroundColor Yellow
        $dirs = Get-ChildItem -Path $p -Directory -ErrorAction SilentlyContinue
        foreach ($d in $dirs) {
            $j = Join-Path $d.FullName "bin\java.exe"
            if (Test-Path $j) {
                Write-Host "  [OK] $($d.FullName)" -ForegroundColor Green
            }
        }
    }
}

Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

