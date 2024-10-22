# Función para verificar si un módulo está instalado y cargarlo
function Ensure-Module {
    param (
        [string]$ModuleName
    )
    
    # Comprobar si el módulo ya está disponible (instalado)
    $module = Get-Module -ListAvailable -Name $ModuleName
    
    if (-not $module) {
        # Si no está instalado, lo instala
        Write-Host "El módulo $ModuleName no está instalado. Instalando..." -ForegroundColor Yellow
        try {
            Install-Module -Name $ModuleName -Force -Scope CurrentUser
            Write-Host "Módulo $ModuleName instalado correctamente." -ForegroundColor Green
        } catch {
            Write-Error "No se pudo instalar el módulo $ModuleName. Error: $_"
            exit 1
        }
    }
    
    # Importar el módulo
    try {
        Import-Module $ModuleName -ErrorAction Stop
        Write-Host "Módulo $ModuleName cargado correctamente." -ForegroundColor Green
    } catch {
        Write-Error "No se pudo cargar el módulo $ModuleName. Error: $_"
        exit 1
    }
}

Write-Host ("PowerShell {0}" -f $PSVersionTable.PSVersion)
Write-Host ""

# Verificar si el módulo ImportExcel está instalado y cargarlo
Ensure-Module -ModuleName 'ImportExcel'

$baseDirectory = $PSScriptRoot

$outputXmlFile = Join-Path $baseDirectory "Win32_ProductAll.xml"
$outputCsvFile = Join-Path $baseDirectory "Win32_ProductAll.csv"
$outputExcelFile = Join-Path $baseDirectory "Win32_ProductAll.xlsx"

$productsAll = @()


# $folders = Get-ChildItem -Path $baseDirectory -Directory
$folders = Get-ChildItem -Path $baseDirectory -Directory | Where-Object { $_.Name -notmatch '^\.' }

foreach ($folder in $folders) {
    Write-Output ("Procesing {0} ..." -f $folder.Name) 
    $xmlFilePath = Join-Path $folder.FullName "Win32_Product.xml"

    if (Test-Path $xmlFilePath) {
        $products = Import-Clixml -Path $xmlFilePath

        foreach ($product in $products) {

            if ($null -eq $product.Name) {
                Write-Warning ("Skip: Is null Product Name!")
                continue
            }
            

            $existingProduct = $productsAll | Where-Object {
                $_.Name -eq $product.Name -and $_.Version -eq $product.Version -and $_.Vendor -eq $product.Vendor
            }

            if ($existingProduct) {
                if ($existingProduct.InstaladoEn -notlike "*$($folder.Name)*") {
                    $existingProduct.InstaladoEn += ", $($folder.Name)"
                }
            }
            else {
                $newProduct = [PSCustomObject]@{
                    Name        = $product.Name
                    Version     = $product.Version
                    Vendor      = $product.Vendor
                    InstaladoEn = $folder.Name
                    InstaladoEnCount = 1
                }
                $productsAll += $newProduct
            }
        }
    }
    else {
        Write-Warning ("Skip: Not found Win32_Product.xml in folder {0}!" -f $folder.Name)
    }
}

foreach ($product in $productsAll) {
    $product.InstaladoEnCount = ($product.InstaladoEn -split ',').Count
}

$productsAll = $productsAll | Sort-Object -Property Name

$productsAll | Export-Clixml -Path $outputXmlFile
$productsAll | Select-Object Name, Version, Vendor, InstaladoEn, InstaladoEnCount | Export-Csv -Path $outputCsvFile -NoTypeInformation
# $productsAll | Select-Object Name, Version, Vendor, InstaladoEn, InstaladoEnCount | Export-Excel -Path $outputExcelFile -AutoSize -AutoFilter -FreezeTopRow  -NumberFormat @{"Name"="@" ; "Version"="@" ; "Vendor"="@" ; "InstaladoEn"="@"; "InstaladoEnCount"="@"}
$productsAll | Select-Object Name, Version, Vendor, InstaladoEn, InstaladoEnCount | Export-Excel -Path $outputExcelFile -AutoFilter -FreezeTopRow

Write-Output ("Process completed. {0} products found." -f $productsAll.Count)