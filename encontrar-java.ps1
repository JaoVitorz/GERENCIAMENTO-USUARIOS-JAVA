# Script para encontrar onde o Java foi instalado

Write-Host "=== Procurando instalacao do Java ===" -ForegroundColor Cyan
Write-Host ""

# Locais comuns de instalacao
$locais = @(
    "C:\Program Files\Java",
    "C:\Program Files\Eclipse Adoptium",
    "C:\Program Files (x86)\Java",
    "$env:LOCALAPPDATA\Programs\Eclipse Adoptium",
    "$env:ProgramFiles\Java",
    "$env:ProgramFiles\Eclipse Adoptium"
)

$encontrado = $false

foreach ($local in $locais) {
    if (Test-Path $local) {
        Write-Host "Verificando: $local" -ForegroundColor Yellow
        
        # Procurar por pastas JDK ou JRE
        $pastas = Get-ChildItem -Path $local -Directory -ErrorAction SilentlyContinue
        
        foreach ($pasta in $pastas) {
            $javaExe = Join-Path $pasta.FullName "bin\java.exe"
            
            if (Test-Path $javaExe) {
                Write-Host ""
                Write-Host "[OK] Java encontrado!" -ForegroundColor Green
                Write-Host "Caminho completo: $($pasta.FullName)" -ForegroundColor Green
                Write-Host "java.exe: $javaExe" -ForegroundColor Green
                Write-Host ""
                
                # Testar versao
                Write-Host "Versao do Java:" -ForegroundColor Yellow
                & $javaExe -version
                Write-Host ""
                
                Write-Host "=== Para configurar, execute: ===" -ForegroundColor Cyan
                Write-Host "[System.Environment]::SetEnvironmentVariable('JAVA_HOME', '$($pasta.FullName)', 'User')" -ForegroundColor White
                Write-Host ""
                Write-Host "E adicione ao PATH:" -ForegroundColor Cyan
                $binPath = Join-Path $pasta.FullName "bin"
                $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
                if ($currentPath -notlike "*$binPath*") {
                    $newPath = "$binPath;$currentPath"
                    Write-Host "[System.Environment]::SetEnvironmentVariable('Path', '$newPath', 'User')" -ForegroundColor White
                }
                
                $encontrado = $true
            }
        }
    }
}

if (-not $encontrado) {
    Write-Host "[ERRO] Java nao encontrado nos locais comuns." -ForegroundColor Red
    Write-Host ""
    Write-Host "Possiveis causas:" -ForegroundColor Yellow
    Write-Host "1. Java nao foi instalado corretamente" -ForegroundColor White
    Write-Host "2. Java foi instalado em outro local" -ForegroundColor White
    Write-Host ""
    Write-Host "Solucao:" -ForegroundColor Yellow
    Write-Host "1. Reinstale o Java: https://adoptium.net/" -ForegroundColor Cyan
    Write-Host "2. Durante a instalacao, marque 'Add to PATH'" -ForegroundColor Cyan
    Write-Host "3. Ou procure manualmente em C:\Program Files" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Pressione Enter para sair..."
Read-Host

