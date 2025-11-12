# Script para configurar Git e fazer push para o repositório GitHub
# Repositório: https://github.com/JaoVitorz/GERENCIAMENTO-USUARIOS-JAVA

$ErrorActionPreference = "Stop"

# Navegar para o diretório do projeto
$projectPath = $PSScriptRoot
Set-Location $projectPath

Write-Host "Diretório do projeto: $projectPath" -ForegroundColor Green

# Verificar se já existe um repositório Git
if (Test-Path ".git") {
    Write-Host "Repositório Git já existe." -ForegroundColor Yellow
} else {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Cyan
    git init
}

# Configurar o remote do GitHub
Write-Host "Configurando remote do GitHub..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/JaoVitorz/GERENCIAMENTO-USUARIOS-JAVA.git

# Verificar se há arquivos para adicionar
Write-Host "Adicionando arquivos ao Git..." -ForegroundColor Cyan
git add .

# Verificar status
Write-Host "`nStatus do repositório:" -ForegroundColor Yellow
git status

# Fazer commit inicial
Write-Host "`nFazendo commit inicial..." -ForegroundColor Cyan
$commitMessage = "Initial commit: Sistema de gerenciamento de usuários Java"
git commit -m $commitMessage

# Verificar se há um branch main
$currentBranch = git branch --show-current
if (-not $currentBranch) {
    Write-Host "Criando branch main..." -ForegroundColor Cyan
    git branch -M main
}

Write-Host "`n=== PRÓXIMOS PASSOS ===" -ForegroundColor Green
Write-Host "Para fazer push para o GitHub, execute:" -ForegroundColor Yellow
Write-Host "  git push -u origin main" -ForegroundColor White
Write-Host "`nOu se preferir forçar o push (substituir o conteúdo remoto):" -ForegroundColor Yellow
Write-Host "  git push -u origin main --force" -ForegroundColor White

