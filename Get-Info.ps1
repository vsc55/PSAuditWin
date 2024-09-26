param (
    [switch]$Debug
)

$debugMode = if ($Debug) {$true} else {$false}



# Verifica si el módulo Appx ya está cargado
if (-not (Get-Module -Name Appx)) {
    # Importa el módulo Appx si no está cargado
    Import-Module Appx
}

<#
.SYNOPSIS
Comprueba si el usuario actual tiene privilegios de administrador.

.DESCRIPTION
La función Test-IsAdmin utiliza clases del .NET Framework para determinar si el usuario actual que ejecuta el script tiene privilegios de administrador en la máquina. Devuelve $true si el usuario actual es un administrador, de lo contrario devuelve $false.

.EXAMPLE
$isAdmin = Test-IsAdmin
if ($isAdmin) {
    Write-Host "El usuario actual tiene privilegios de administrador."
} else {
    Write-Host "El usuario actual NO tiene privilegios de administrador."
}

Este ejemplo llama a la función Test-IsAdmin y almacena el resultado en la variable $isAdmin. Luego, utiliza una declaración if para verificar si $isAdmin es $true y escribe un mensaje en la consola según sea el caso.

.NOTES
Es importante tener en cuenta que esta función simplemente verifica si el usuario actual tiene privilegios de administrador y no intenta elevar los privilegios ni realizar ninguna acción administrativa.

.LINK
https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsprincipal
https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsbuilt-inrole

#>
function Test-IsAdmin {
    try {
        $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    } catch {
        return $false
    }
}

<#
.SYNOPSIS
Añade contenido a un archivo con reintentos en caso de error.

.DESCRIPTION
La función Add-ContentWithRetry intenta añadir contenido a un archivo especificado. Si se encuentra con errores, como un archivo bloqueado por otro proceso, reintentará la operación un número definido de veces antes de rendirse. Los reintentos se realizan con un retraso entre intentos, ambos configurables.

.PARAMETER Path
La ruta del archivo al que se añadirá el contenido.

.PARAMETER Value
El contenido que se añadirá al archivo.

.PARAMETER MaxRetries
El número máximo de intentos para añadir el contenido al archivo antes de generar un error. El valor predeterminado es 10.

.PARAMETER RetryDelayMilliseconds
El tiempo de espera entre intentos en milisegundos. El valor predeterminado es 100 milisegundos.

.EXAMPLE
Add-ContentWithRetry -Path "C:\temp\myFile.txt" -Value "Nueva línea de texto"

Este ejemplo intenta añadir "Nueva línea de texto" a "C:\temp\myFile.txt", reintentándolo hasta 10 veces si es necesario, con un intervalo de 100 milisegundos entre intentos.

.EXAMPLE
Add-ContentWithRetry -Path "C:\temp\myFile.txt" -Value "Otro texto" -MaxRetries 5 -RetryDelayMilliseconds 500

Este ejemplo intentará añadir "Otro texto" a "C:\temp\myFile.txt", pero solo lo intentará hasta 5 veces con un intervalo de 500 milisegundos entre intentos si se encuentran errores.

.NOTES
Utiliza esta función para escribir en archivos que puedan estar temporalmente bloqueados por otros procesos, como archivos de log en uso o archivos en directorios muy accedidos.

#>
function Add-ContentWithRetry {
    param(
        [string]$Path,
        [string]$Value,
        [int]$MaxRetries = 10,
        [int]$RetryDelayMilliseconds = 100
    )

    $retryCount = 0
    $success = $false

    while (-not $success -and $retryCount -lt $MaxRetries) {
        try {
            Add-Content -Path $Path -Value $Value -ErrorAction Stop
            $success = $true
        } catch {
            Start-Sleep -Milliseconds $RetryDelayMilliseconds
            $retryCount++
        }
    }

    if (-not $success)
    {
        Write-Error ("Could not write to file '{0}' after {1} attempts." -f $Path, $MaxRetries)
    }

    Start-Sleep -Milliseconds 100
}



# Definir los comandos a ejecutar
$commands = @(
    # Info:
    # @{
    #     Command       = "Get-CimInstance -Class Win32_Baseboard";     Comando a ejecutar
    #     Sudo          = $false;                                       $true necesitas ser admin para poder ejecutar el comando.
    #     FileName      = "Win32_Baseboard.xml";                        Archivo XML donde guarda el objeto serializado.
    #     Label         = "Baseboard";                                  Label que se usa en la consola para informar de la exportacion y preparacion del log.
    #     Log           = $true;                                        $true añade la info al Log, $False omite y no la añade en el Log.
    #     LogLabel      = "Baseboard";                                  Label del título de la seccion del Log, si no se define o es $null se usara Label.
    #     LogSelect     = $null;                                        Parametros que deseamos exportar al archivo log, $null usara los valores por defecto.
    #     LogShowDebug  = $true;                                        $true muestra la informacion que se va a añadir al log, $false solo muestra Error o OK.
    #     LogListMode   = $true;                                        $true exporta al log la info en modo lista, $false exptro la info al log en modo tabla.
    #     LogGenCSV     = $true;                                        $true genera un CSV con la info. Esto solo vale para los datos en modo tabla.
    
    # }
    @{
        Command      = "Get-CimInstance -Class Win32_Baseboard";
        Sudo         = $false;
        FileName     = "Win32_Baseboard.xml";
        Label        = "Baseboard";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_ComputerSystem";
        Sudo         = $false;
        FileName     = "Win32_ComputerSystem.xml";
        Label        = "ComputerSystem";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_BIOS";
        Sudo         = $false;
        FileName     = "Win32_BIOS.xml";
        Label        = "BIOS";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_Processor";
        Sudo         = $false;
        FileName     = "Win32_Processor.xml";
        Label        = "Processor";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_OperatingSystem";
        Sudo         = $false;
        FileName     = "Win32_OperatingSystem.xml";
        Label        = "Operating System";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = 'Get-CimInstance  -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm';
        Sudo         = $false;
        FileName     = "Win32_Tpm.xml";
        Label        = "TPM";
        Log          = $true;
        LogSelect    = $null;
        LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-Printer";
        Sudo         = $false;
        FileName     = "Printer.xml";
        Label        = "Printers";
        Log          = $true;
        LogSelect    = @('Name', 'DriverName', 'PortName', 'Shared', 'Published');
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    # @{
    #     Command = "Get-CimInstance -ClassName Win32_Printer";
    # },
    @{
        Command      = "Get-PrinterPort";
        Sudo         = $false;
        FileName     = "PrinterPort.xml";
        Label        = "Ports Printer";
        Log          = $true;
        LogSelect    = @('Name', 'PrinterHostAddress', 'Description');
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_TCPIPPrinterPort";
        Sudo         = $false;
        FileName     = "Win32_TCPIPPrinterPort.xml";
        Label        = "Ports TCP/IP of Pritners";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-PrinterDriver";
        Sudo         = $false;
        FileName     = "PrinterDriver.xml";
        Label        = "Drivers Pritners";
        Log          = $true;
        LogSelect    = @( 'Name', 'Manufacturer', 'DriverVersion', 'InfPath');
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-NetAdapter";
        Sudo         = $false;
        FileName     = "NetAdapter.xml";
        Label        = "Net Adapters";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-NetIPAddress";
        Sudo         = $false;
        FileName     = "NetIPAddress.xml";
        Label        = "IP Address";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-NetRoute";
        Sudo         = $false;
        FileName     = "NetRoute.xml";
        Label        = "Routes";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-DnsClientServerAddress";
        Sudo         = $false;
        FileName     = "DnsClientServerAddress.xml";
        Label        = "Servers DNS";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-SmbShare";
        Sudo         = $false;
        FileName     = "SmbShare.xml";
        Label        = "Samba Share";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    # No necesario Get-PSDrive muestra la misma info.
    # @{
    #     Command = "Get-CimInstance -ClassName Win32_LogicalDisk";
    #     FileName = "CimInstance_LogicalDisk.xml";
    # }, 
    @{
        Command      = "Get-PhysicalDisk";
        Sudo         = $false;
        FileName     = "PSPhysicalDisk.xml";
        Label        = "Physical Disk";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-Volume";
        Sudo         = $false;
        FileName     = "PSVolume.xml";
        Label        = "Volume";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-Partition";
        Sudo         = $false;
        FileName     = "PSPartition.xml";
        Label        = "Partition";
        Log          = $true;
        LogSelect    = @('DiskPath', 'DiskNumber', 'PartitionNumber', 'DriveLetter');
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-PSDrive";
        Sudo         = $false;
        FileName     = "PSDrive.xml";
        Label        = "Drives";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_UserProfile";
        Sudo         = $false;
        FileName     = "Win32_UserProfile.xml";
        Label        = "Profiles Users";
        Log          = $true;
        LogSelect    = @('LocalPath', 'RoamingPath', 'SID', 'Status', 'RoamingConfigured', 'Special', 'Loaded', 'LastUseTime');
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-LocalUser";
        Sudo         = $false;
        FileName     = "LocalUser.xml";
        Label        = "Local Users";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-LocalGroup";
        Sudo         = $false;
        FileName     = "LocalGroup.xml";
        Label        = "Local Gropus";
        Log          = $true;
        LogSelect    = $null;
        # LogListMode  = $true;
        # LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-AppxPackage";
        Sudo         = $false;
        FileName     = "AppxPackage.xml";
        Label        = "AppxPackage";
        Log          = $true;
        LogSelect    = @('Name', 'Version', 'Architecture', 'InstallLocation', 'Status');
        # LogListMode  = $true;
        LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-AppxPackage -AllUsers";
        Sudo         = $true;
        FileName     = "AppxPackage-AllUser.xml";
        Label        = "AppxPackage - AllUser";
        Log          = $true;
        LogSelect    = @('Name', 'Version', 'Architecture', 'InstallLocation', 'Status');
        # LogListMode  = $true;
        LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    },
    @{
        Command      = "Get-CimInstance -Class Win32_Product";
        Sudo         = $false;
        FileName     = "Win32_Product.xml";
        Label        = "Win32 Products";
        Log          = $true;
        LogSelect    = @('Name', 'Vendor', 'Version', 'InstallDate', 'IdentifyingNumber', 'LocalPackage');
        # LogListMode  = $true;
        LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    }
    @{
        Command      = "Get-CimInstance -Class Win32_PnPEntity";
        Sudo         = $false;
        FileName     = "Win32_PnPEntity.xml";
        Label        = "Win32 PnP Entity";
        Log          = $true;
        LogSelect    = @('Manufacturer', 'Name', 'Status', 'DeviceID');
        # LogListMode  = $true;
        LogGenCSV    = $true;
        LogShowDebug = $debugMode;
    }
)


Write-Host ("PowerShell {0}" -f $PSVersionTable.PSVersion)
Write-Host ""


$NamePC = hostname
$NameUser = [Environment]::UserName

# Caracteres no válidos en nombres de archivo/carpeta en Windows, incluyendo el escape correcto para '\'
$invalidChars = '[<>:"/\|?*]' -replace '\\', '\\\\'

$NameFolderData = "{0} - {1}" -f $NamePC, $NameUser

# Limpiar $NameFolderData reemplazando caracteres no válidos por "_"
$NameFolderDataClean = $NameFolderData -replace $invalidChars, "_"

# Asegurar que el script maneja correctamente el carácter '\'
$NameFolderDataClean = $NameFolderDataClean -replace '\\', '_'


# Obtener el timestamp actual en formato año-mes-día-hora-minuto-segundo
$timestamp = Get-Date -Format "yyyyMMddHHmmss"

# Nombre final de la carpeta y los archivos, ejemplo: PC1 - Usuario - 20240203152010
$NameAudit = "{0}-{1}" -f $NameFolderDataClean, $timestamp

# Path completo del directorio de exportacion de los XML.
$pathFilesXML = Join-Path -Path $PSScriptRoot -ChildPath $NameAudit

# Nombre del archivo y Path del archivo Log
$NameFileLog = "{0}.txt" -f $NameAudit
$pathFileLog = Join-Path -Path $PSScriptRoot -ChildPath $NameFileLog


Write-Host ("Creating folder '{0}'... " -f $NameAudit) -NoNewline
try {
    New-Item -Path $pathFilesXML -ItemType Directory | Out-Null
    Write-Host "[OK]" -ForegroundColor Green
}
catch
{
    Write-Host "[Error]" -ForegroundColor Red
    Exit 5
}



Write-Host ("Creating Log File... " -f $NameAudit) -NoNewline
# Asegurarse de que el archivo de salida esté vacío
if (Test-Path $pathFileLog)
{
    Clear-Content $pathFileLog
}
Write-Host "[OK]" -ForegroundColor Green
Write-Host ""

foreach ($cmd in $commands)
{

    Write-Host ("{0}... " -f $cmd.Label) -NoNewline

    # Write-Host ("Exporting {0}..." -f $cmd.Label) -NoNewline
    

    if ($cmd.Sudo -and -not (Test-IsAdmin))
    {
        Write-Host " [SKIP]" -ForegroundColor Yellow
        Write-Warning "You need administrator permissions!"
    }
    else
    {
        Write-Host ""
        Write-Host " - Exporting..." -NoNewline

        try
        {
            $xmlFileOut = Join-Path -Path $pathFilesXML -ChildPath $cmd.FileName

            $result = Invoke-Expression $cmd.Command
            $result | Export-Clixml -Path $xmlFileOut
            
            Write-Host "      [OK]" -ForegroundColor Green



            # Write-Host ("Generating Log {0}..." -f $cmd.Label) -NoNewline
            Write-Host " - Generating Log..." -NoNewline
            $labelout = $cmd.Label
            if ($null -ne $cmd.LogLabel)
            {
                $labelout = $cmd.LogLabel
            }
            $labelout = "---- {0} ----" -f $labelout
            Add-ContentWithRetry -Path $pathFileLog -Value ("{0}`n{1}" -f $labelout, ('-' * $labelout.Length))
            
            if ($cmd.Log -eq $true)
            {
                if ($null -ne $cmd.LogSelect)
                {
                    $data = $result | Select-Object -Property $cmd.LogSelect
                }
                else
                {
                    $data = $result
                }
    
                if ($cmd.LogListMode)
                {
                    $data | Format-List | Out-File -FilePath $pathFileLog -Append -Encoding utf8
                    if ($cmd.LogShowDebug)
                    {
                        $data | Format-List
                    }
                    # unknown;string;unicode;bigendianunicode;utf8;utf7;utf32;ascii;default;oem
                }
                else
                {
                    $data | Format-Table -AutoSize | Out-File -FilePath $pathFileLog -Append -Width 4096 -Encoding utf8
                    if ($cmd.LogGenCSV)
                    {
                        $csvFileName = "{0}-{1}.csv" -f $NameAudit, [System.IO.Path]::GetFileNameWithoutExtension($cmd.FileName)
                        $csvFilePath = Join-Path -Path $PSScriptRoot -ChildPath $csvFileName
                        $data | Export-Csv -Path $csvFilePath -NoTypeInformation
                    }
                    if ($cmd.LogShowDebug)
                    {
                        $data | Format-Table
                    }
                }
                Write-Host " [OK]" -ForegroundColor Green
            }
            else
            {
                Add-ContentWithRetry -Path $pathFileLog -Value "Skip!"
                Write-Host " [SKIP]" -ForegroundColor Yellow
            }
        
            # Añadir una línea en blanco entre secciones para mejor legibilidad
            Add-ContentWithRetry -Path $pathFileLog -Value ("{0}`n{1}`n{2}" -f ('-' * 80), ('-' * 80), "")
        }
        catch
        {
            Write-Host "      [ERR]" -ForegroundColor Red
            Write-Warning "Error Run Command $($cmd.Command): $_"
        }
    }

    Write-Host ""
}



#         $xmlFileIn = Join-Path -Path $pathFilesXML -ChildPath $cmd.FileName
#         $data = Import-Clixml -Path $xmlFileIn
#         $data | Select-Object -Property $cmd.LogSelect | Format-Table -AutoSize 
#         $data | Export-Csv -Path $csvFilePath -NoTypeInformation