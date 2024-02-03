# PSAuditWin
Powershell script that audits the system and obtains information such as network configuration, printer, installed programs, hardware.
The log file generated shows some information, but a copy of all the system information (Network, Printer, Installed Programs) is saved in XML files so that you can work with it later, or just have it recorded.

An example of how to work with XML files:
```powershell
PS > $AppxPackage = Import-Clixml -Path "AppxPackage-AllUser.xml"
PS > $AppxPackage | Select-Object Name, PackageFullName, Version

Name                                               PackageFullName                                                                         Version
----                                               ---------------                                                                         -------
windows.immersivecontrolpanel                      windows.immersivecontrolpanel_10.0.2.1000_neutral_neutral_cw5n1h2txyewy                 10.0.2.1000
Windows.PrintDialog                                Windows.PrintDialog_6.2.1.0_neutral_neutral_cw5n1h2txyewy                               6.2.1.0
Microsoft.NET.Native.Runtime.1.6                   Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe                         1.6.24903.0
Microsoft.NET.Native.Runtime.1.6                   Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe                         1.6.24903.0
Microsoft.NET.Native.Runtime.2.1                   Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x64__8wekyb3d8bbwe                         2.1.26424.0
Microsoft.NET.Native.Runtime.2.1                   Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x86__8wekyb3d8bbwe                         2.1.26424.0
....
Microsoft.WinAppRuntime.DDLM.2000.609.1413.0-x8-p1 Microsoft.WinAppRuntime.DDLM.2000.609.1413.0-x8-p1_2000.609.1413.0_x86__8wekyb3d8bbwe   2000.609.1413.0
NVIDIACorp.NVIDIAControlPanel                      NVIDIACorp.NVIDIAControlPanel_8.1.964.0_x64__56jybvy8sckqj                              8.1.964.0
Microsoft.WindowsAppRuntime.1.2                    Microsoft.WindowsAppRuntime.1.2_2000.802.31.0_x86__8wekyb3d8bbwe                        2000.802.31.0
.....
microsoft.windowscommunicationsapps                microsoft.windowscommunicationsapps_16005.14326.21798.0_x64__8wekyb3d8bbwe              16005.14326.21798.0
Microsoft.Microsoft3DViewer                        Microsoft.Microsoft3DViewer_7.2401.29012.0_x64__8wekyb3d8bbwe                           7.2401.29012.0
Microsoft.Winget.Platform.Source                   Microsoft.Winget.Platform.Source_2024.105.1947.899_neutral__8wekyb3d8bbwe               2024.105.1947.899
5319275A.WhatsAppDesktop                           5319275A.WhatsAppDesktop_2.2401.5.0_x64__cv1g1gvanyjgm                                  2.2401.5.0
MSTeams                                            MSTeams_23335.232.2637.4844_x64__8wekyb3d8bbwe                                          23335.232.2637.4844

PS > $filteredPackages = $AppxPackage | Where-Object { $_.Name -like "*NVIDIA*" }
PS > $filteredPackages | Select-Object Name, PackageFullName, Version

Name                          PackageFullName                                            Version
----                          ---------------                                            -------
NVIDIACorp.NVIDIAControlPanel NVIDIACorp.NVIDIAControlPanel_8.1.964.0_x64__56jybvy8sckqj 8.1.964.0

PS > $filteredPackages | Export-Csv -Path "nvidia.csv" -NoTypeInformation
```

*nvidia.csv*
```csv
"Name","Publisher","PublisherId","Architecture","ResourceId","Version","PackageFamilyName","PackageFullName","InstallLocation","IsFramework","PackageUserInformation","IsResourcePackage","IsBundle","IsDevelopmentMode","NonRemovable","Dependencies","IsPartiallyStaged","SignatureKind","Status"
"NVIDIACorp.NVIDIAControlPanel","CN=D6816951-877F-493B-B4EE-41AB9419C326","56jybvy8sckqj","X64","","8.1.964.0","NVIDIACorp.NVIDIAControlPanel_56jybvy8sckqj","NVIDIACorp.NVIDIAControlPanel_8.1.964.0_x64__56jybvy8sckqj","C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_8.1.964.0_x64__56jybvy8sckqj","False","S-1-5-21-1004103112-930421597-950816272-1001 [jpastor]: Installed S-1-5-21-1004103112-930421597-950816272-1005 [xbox]: Installed","False","False","False","False","","False","Store","Ok"
```

---


## **Sample Create Log Audit:**
```powershell
PowerShell 5.1.19041.3930

Creating folder 'PC - User1-20240204004011'... [OK]
Creating Log File... [OK]

Baseboard...
 - Exporting...      [OK]
 - Generating Log... [OK]

ComputerSystem...
 - Exporting...      [OK]
 - Generating Log... [OK]

BIOS...
 - Exporting...      [OK]
 - Generating Log... [OK]

Processor...
 - Exporting...      [OK]
 - Generating Log... [OK]

Operating System...
 - Exporting...      [OK]
 - Generating Log... [OK]

Printers...
 - Exporting...      [OK]
 - Generating Log... [OK]

Ports Printer...
 - Exporting...      [OK]
 - Generating Log... [OK]

Ports TCP/IP of Pritners...
 - Exporting...      [OK]
 - Generating Log... [OK]

Drivers Pritners...
 - Exporting...      [OK]
 - Generating Log... [OK]

Net Adapters...
 - Exporting...      [OK]
 - Generating Log... [OK]

IP Address...
 - Exporting...      [OK]
 - Generating Log... [OK]

Routes...
 - Exporting...      [OK]
 - Generating Log... [OK]

Servers DNS...
 - Exporting...      [OK]
 - Generating Log... [OK]

Samba Share...
 - Exporting...      [OK]
 - Generating Log... [OK]

Drives...
 - Exporting...      [OK]
 - Generating Log... [OK]

Profiles Users...
 - Exporting...      [OK]
 - Generating Log... [OK]

Local Users...
 - Exporting...      [OK]
 - Generating Log... [OK]

Local Gropus...
 - Exporting...      [OK]
 - Generating Log... [OK]

AppxPackage...
 - Exporting...      [OK]
 - Generating Log... [OK]

AppxPackage - AllUser...
 - Exporting...      [OK]
 - Generating Log... [OK]

Win32 Products...
 - Exporting...      [OK]
 - Generating Log... [OK]
```


## **Sample Log Audit:**
```
---- Baseboard ----
-------------------


Manufacturer : Intel Corporation
Model        : 
Name         : Placa base
SerialNumber : None
SKU          : 
Product      : 440BX Desktop Reference Platform



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- ComputerSystem ----
------------------------


Domain              : WORKGROUP
Manufacturer        : VMware, Inc.
Model               : VMware20,1
Name                : DEV-CAC050EC
PrimaryOwnerName    : 
TotalPhysicalMemory : 8488116224



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- BIOS ----
--------------


SMBIOSBIOSVersion : VMW201.00V.209345234.B64.1112051119
Manufacturer      : VMware, Inc.
Name              : VMW201.00V.209345234.B64.1112051119
SerialNumber      : VMware-56 4d 73 fd 33 02 78 f5-2e 49 3c ac 00 ee f0 ec
Version           : INTEL  - 6040000



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Processor ----
-------------------


Caption           : Intel64 Family 6 Model 62 Stepping 4
DeviceID          : CPU0
Manufacturer      : GenuineIntel
MaxClockSpeed     : 2801
Name              : Intel(R) Xeon(R) CPU E5-4657L v2 @ 2.40GHz
SocketDesignation : CPU 0

Caption           : Intel64 Family 6 Model 62 Stepping 4
DeviceID          : CPU1
Manufacturer      : GenuineIntel
MaxClockSpeed     : 2801
Name              : Intel(R) Xeon(R) CPU E5-4657L v2 @ 2.40GHz
SocketDesignation : CPU 1



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Operating System ----
--------------------------


SystemDirectory : C:\WINDOWS\system32
Organization    : 
BuildNumber     : 22621
RegisteredUser  : 
SerialNumber    : 00330-80000-654-AFSD45
Version         : 10.0.22621



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Printers ----
------------------

Name                   DriverName                          PortName    Shared Published
----                   ----------                          --------    ------ ---------
OneNote (Desktop)      Send to Microsoft OneNote 16 Driver nul:         False     False
Microsoft Print to PDF Microsoft Print To PDF              PORTPROMPT:  False     False


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Ports Printer ----
-----------------------

Name        PrinterHostAddress Description 
----        ------------------ ----------- 
COM1:                          Puerto local
COM2:                          Puerto local
COM3:                          Puerto local
COM4:                          Puerto local
FILE:                          Puerto local
LPT1:                          Puerto local
LPT2:                          Puerto local
LPT3:                          Puerto local
PORTPROMPT:                    Puerto local
nul:                           Puerto local


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Ports TCP/IP of Pritners ----
----------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Drivers Pritners ----
--------------------------

Name                                                    Manufacturer    DriverVersion InfPath                                                                                        
----                                                    ------------    ------------- -------                                                                                        
Send to Microsoft OneNote 16 Driver                     Microsoft    4503600127348640 C:\WINDOWS\System32\DriverStore\FileRepository\prnms006.inf_amd64_c3bdcb6fc975b614\prnms006.inf
Microsoft Print To PDF                                  Microsoft    2814751249596417 C:\WINDOWS\System32\DriverStore\FileRepository\prnms009.inf_amd64_3107874c7db0aa5a\prnms009.inf
Microsoft enhanced Point and Print compatibility driver Microsoft    2814751249599423 C:\WINDOWS\System32\DriverStore\FileRepository\prnms003.inf_amd64_832edc9d9add292c\prnms003.inf
Microsoft enhanced Point and Print compatibility driver Microsoft    2814751249599423 C:\WINDOWS\System32\DriverStore\FileRepository\prnms003.inf_x86_c56503890afc3c6c\prnms003.inf  


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Net Adapters ----
----------------------

Name      InterfaceDescription                       ifIndex Status MacAddress        LinkSpeed
----      --------------------                       ------- ------ ----------        ---------
Ethernet  VirtualBox Host-Only Ethernet Adapter            7 Up     0A-00-17-08-00-07    1 Gbps
Ethernet0 Intel(R) 82574L Gigabit Network Connection       5 Up     00-0C-79-EA-F0-EC    1 Gbps


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- IP Address ----
--------------------

ifIndex IPAddress                   PrefixLength PrefixOrigin SuffixOrigin AddressState PolicyStore
------- ---------                   ------------ ------------ ------------ ------------ -----------
7       fe80::eba7:33ad:f9fb:57c8%7           64 WellKnown    Link         Preferred    ActiveStore
5       fe80::c033:f7e1:c18f:f079%5           64 WellKnown    Link         Preferred    ActiveStore
1       ::1                                  128 WellKnown    WellKnown    Preferred    ActiveStore
7       192.168.56.1                          24 Manual       Manual       Preferred    ActiveStore
5       192.168.88.119                        24 Dhcp         Dhcp         Preferred    ActiveStore
1       127.0.0.1                              8 WellKnown    WellKnown    Preferred    ActiveStore


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Routes ----
----------------

ifIndex DestinationPrefix             NextHop       RouteMetric ifMetric PolicyStore
------- -----------------             -------       ----------- -------- -----------
5       255.255.255.255/32            0.0.0.0               256 25       ActiveStore
7       255.255.255.255/32            0.0.0.0               256 25       ActiveStore
1       255.255.255.255/32            0.0.0.0               256 75       ActiveStore
5       224.0.0.0/4                   0.0.0.0               256 25       ActiveStore
7       224.0.0.0/4                   0.0.0.0               256 25       ActiveStore
1       224.0.0.0/4                   0.0.0.0               256 75       ActiveStore
7       192.168.56.255/32             0.0.0.0               256 25       ActiveStore
7       192.168.56.1/32               0.0.0.0               256 25       ActiveStore
7       192.168.56.0/24               0.0.0.0               256 25       ActiveStore
5       192.168.88.255/32             0.0.0.0               256 25       ActiveStore
5       192.168.88.119/32             0.0.0.0               256 25       ActiveStore
5       192.168.88.0/24               0.0.0.0               256 25       ActiveStore
1       127.255.255.255/32            0.0.0.0               256 75       ActiveStore
1       127.0.0.1/32                  0.0.0.0               256 75       ActiveStore
1       127.0.0.0/8                   0.0.0.0               256 75       ActiveStore
5       0.0.0.0/0                     192.168.88.201          0 25       ActiveStore
5       ff00::/8                      ::                    256 25       ActiveStore
7       ff00::/8                      ::                    256 25       ActiveStore
1       ff00::/8                      ::                    256 75       ActiveStore
7       fe80::eba7:33ad:f9fb:57c8/128 ::                    256 25       ActiveStore
5       fe80::c033:f7e1:c18f:f079/128 ::                    256 25       ActiveStore
5       fe80::/64                     ::                    256 25       ActiveStore
7       fe80::/64                     ::                    256 25       ActiveStore
1       ::1/128                       ::                    256 75       ActiveStore


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Servers DNS ----
---------------------

InterfaceAlias              InterfaceIndex AddressFamily ServerAddresses                                       
--------------              -------------- ------------- ---------------                                       
Ethernet0                                5 IPv4          {8.8.8.8, 1.1.1.1}                        
Ethernet0                                5 IPv6          {}                                                    
Ethernet                                 7 IPv4          {}                                                    
Ethernet                                 7 IPv6          {fec0:0:0:ffff::1, fec0:0:0:ffff::2, fec0:0:0:ffff::3}
Loopback Pseudo-Interface 1              1 IPv4          {}                                                    
Loopback Pseudo-Interface 1              1 IPv6          {fec0:0:0:ffff::1, fec0:0:0:ffff::2, fec0:0:0:ffff::3}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Samba Share ----
---------------------

Name   ScopeName Path       Description           
----   --------- ----       -----------           
ADMIN$ *         C:\WINDOWS Admin remota          
C$     *         C:\        Recurso predeterminado
IPC$   *                    IPC remota            


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Drives ----
----------------

Name     Used (GB) Free (GB) Provider    Root                                                        CurrentLocation
----     --------- --------- --------    ----                                                        ---------------
Alias                        Alias                                                                                  
C            75,55    163,73 FileSystem  C:\                Users\User1\Desktop\PSAudit
Cert                         Certificate \                                                                          
D                            FileSystem  D:\                                                                        
Env                          Environment                                                                            
Function                     Function                                                                               
HKCU                         Registry    HKEY_CURRENT_USER                                                          
HKLM                         Registry    HKEY_LOCAL_MACHINE                                                         
Variable                     Variable                                                                               
WSMan                        WSMan                                                                                  


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Profiles Users ----
------------------------

LocalPath                                 RoamingPath SID                                                  Status RoamingConfigured Special Loaded LastUseTime        
---------                                 ----------- ---                                                  ------ ----------------- ------- ------ -----------        
C:\WINDOWS\ServiceProfiles\NetworkService             S-1-5-20                                                  0             False    True   True 04/02/2024 0:14:56 
C:\WINDOWS\ServiceProfiles\LocalService               S-1-5-19                                                  0             False    True   True 04/02/2024 0:14:56 
C:\WINDOWS\system32\config\systemprofile              S-1-5-18                                                  0             False    True   True 04/02/2024 0:14:56 
C:\Users\User2                                        S-1-12-1-3944656339-564654-534453453-2183437850           0             False    False  False 03/02/2024 23:59:06
C:\Users\User1                                        S-1-12-1-3944656339-564654-534453453-622170382            0             False    False  True 04/02/2024 0:14:56 


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Local Users ----
---------------------

Name               Enabled Description                                                                                                             
----               ------- -----------                                                                                                             
Administrador      True    Cuenta integrada para la administración del equipo o dominio                                                            
DefaultAccount     False   Cuenta de usuario administrada por el sistema.                                                                          
Invitado           False   Cuenta integrada para el acceso como invitado al equipo o dominio                                                       
WDAGUtilityAccount False   Una cuenta de usuario que el sistema administra y usa para escenarios de Protección de aplicaciones de Windows Defender.


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Local Gropus ----
----------------------

Name                                          Description                                                                                                                                                                                                                                                            
----                                          -----------                                                                                                                                                                                                                                                            
Administradores                               Los administradores tienen acceso completo y sin restricciones al equipo o dominio                                                                                                                                                                                     
Administradores de Hyper-V                    Los miembros de este grupo tienen acceso completo y sin restricciones a todas las características de Hyper-V.                                                                                                                                                          
Duplicadores                                  Pueden replicar archivos en un dominio                                                                                                                                                                                                                                 
IIS_IUSRS                                     Grupo integrado usado por Internet Information Services.                                                                                                                                                                                                               
Invitados                                     De forma predeterminada, los invitados tienen el mismo acceso que los miembros del grupo Usuarios, excepto la cuenta de invitado que tiene más restricciones                                                                                                           
Lectores del registro de eventos              Los miembros de este grupo pueden leer registros de eventos del equipo local.                                                                                                                                                                                          
Operadores criptográficos                     Los miembros tienen autorización para realizar operaciones criptográficas.                                                                                                                                                                                             
Operadores de asistencia de control de acceso Los miembros de este grupo pueden consultar de forma remota los atributos de autorización y los permisos para los recursos de este equipo.                                                                                                                             
Operadores de configuración de red            Los miembros en este equipo pueden tener algunos privilegios administrativos para administrar la configuración de las características de la red                                                                                                                        
Operadores de copia de seguridad              Los operadores de copia de seguridad pueden invalidar restricciones de seguridad con el único propósito de hacer copias de seguridad o restaurar archivos.                                                                                                             
Propietarios del dispositivo                  Los miembros de este grupo pueden cambiar la configuración de todo el sistema.                                                                                                                                                                                         
System Managed Accounts Group                 Los miembros de este grupo los administra el sistema.                                                                                                                                                                                                                  
Usuarios                                      Los usuarios no pueden hacer cambios accidentales o intencionados en el sistema y pueden ejecutar la mayoría de aplicaciones                                                                                                                                           
Usuarios avanzados                            Los usuarios avanzados se incluyen para la compatibilidad con versiones anteriores y poseen derechos administrativos limitados                                                                                                                                         
Usuarios COM distribuidos                     Los miembros pueden iniciar, activar y usar objetos de COM distribuido en este equipo.                                                                                                                                                                                 
Usuarios de administración remota             Los miembros de este grupo pueden acceder a los recursos de WMI mediante protocolos de administración (como WS-Management a través del servicio Administración remota de Windows). Esto se aplica solo a los espacios de nombres de WMI que conceden acceso al usuario.
Usuarios de escritorio remoto                 A los miembros de este grupo se les concede el derecho de iniciar sesión remotamente                                                                                                                                                                                   
Usuarios del monitor de sistema               Los miembros de este grupo tienen acceso a los datos del contador de rendimiento de forma local y remota                                                                                                                                                               
Usuarios del registro de rendimiento          Los miembros de este grupo pueden programar contadores de registro y rendimiento, habilitar proveedores de seguimiento y recopilar seguimientos de eventos localmente y a través del acceso remoto a este equipo                                                       


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- AppxPackage ----
---------------------

Name                                        Version              Architecture InstallLocation                                                                                          Status
----                                        -------              ------------ ---------------                                                                                          ------
Microsoft.Windows.OOBENetworkConnectionFlow 10.0.21302.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.OOBENetworkConnectionFlow_cw5n1h2txyewy                              Ok
Microsoft.Windows.OOBENetworkCaptivePortal  10.0.21302.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.OOBENetworkCaptivePortal_cw5n1h2txyewy                               Ok
MicrosoftWindows.UndockedDevKit             10.0.22621.1              Neutral C:\Windows\SystemApps\MicrosoftWindows.UndockedDevKit_cw5n1h2txyewy                                          Ok
Microsoft.UI.Xaml.CBS                       8.2305.16002.0                X64 C:\Windows\SystemApps\Microsoft.UI.Xaml.CBS_8wekyb3d8bbwe                                                    Ok
MicrosoftWindows.Client.Core                1000.22645.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.Core_cw5n1h2txyewy                                             Ok
Microsoft.WindowsAppRuntime.CBS             4000.1000.1727.0              X64 C:\Windows\SystemApps\Microsoft.WindowsAppRuntime.CBS_8wekyb3d8bbwe                                          Ok
MicrosoftWindows.Client.FileExp             1000.22651.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.FileExp_cw5n1h2txyewy                                          Ok
Microsoft.AAD.BrokerPlugin                  1000.19580.1000.0         Neutral C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy                                               Ok
Microsoft.BioEnrollment                     10.0.19587.1000           Neutral C:\Windows\SystemApps\Microsoft.BioEnrollment_cw5n1h2txyewy                                                  Ok
windows.immersivecontrolpanel               10.0.6.1000               Neutral C:\Windows\ImmersiveControlPanel                                                                             Ok
Microsoft.NET.Native.Framework.2.2          2.2.29512.0                   X64 C:\Program Files\WindowsApps\microsoft.net.native.framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe               Ok
Microsoft.NET.Native.Framework.2.2          2.2.29512.0                   X86 C:\Program Files\WindowsApps\microsoft.net.native.framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe               Ok
Microsoft.NET.Native.Runtime.2.2            2.2.28604.0                   X64 C:\Program Files\WindowsApps\microsoft.net.native.runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe                 Ok
Microsoft.NET.Native.Runtime.2.2            2.2.28604.0                   X86 C:\Program Files\WindowsApps\microsoft.net.native.runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe                 Ok
Microsoft.UI.Xaml.2.7                       7.2208.15002.0                X64 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.7_7.2208.15002.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.7                       7.2208.15002.0                X86 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.7_7.2208.15002.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.XboxIdentityProvider              12.95.3001.0                  X64 C:\Program Files\WindowsApps\microsoft.xboxidentityprovider_12.95.3001.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.WindowsAppRuntime.1.3             3000.934.1904.0               X64 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.3_3000.934.1904.0_x64__8wekyb3d8bbwe              Ok
Microsoft.WindowsAppRuntime.1.3             3000.934.1904.0               X86 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.3_3000.934.1904.0_x86__8wekyb3d8bbwe              Ok
Microsoft.Services.Store.Engagement         10.0.23012.0                  X64 C:\Program Files\WindowsApps\microsoft.services.store.engagement_10.0.23012.0_x64__8wekyb3d8bbwe             Ok
Microsoft.Services.Store.Engagement         10.0.23012.0                  X86 C:\Program Files\WindowsApps\microsoft.services.store.engagement_10.0.23012.0_x86__8wekyb3d8bbwe             Ok
Windows.CBSPreview                          10.0.19580.1000           Neutral C:\Windows\SystemApps\Windows.CBSPreview_cw5n1h2txyewy                                                       Ok
Microsoft.Windows.PinningConfirmationDialog 1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.PinningConfirmationDialog_cw5n1h2txyewy                              Ok
Microsoft.MicrosoftEdgeDevToolsClient       1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe                                    Ok
Microsoft.Win32WebViewHost                  10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Win32WebViewHost_cw5n1h2txyewy                                               Ok
Microsoft.Windows.Apprep.ChxApp             1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy                                          Ok
Microsoft.Windows.AssignedAccessLockApp     1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.AssignedAccessLockApp_cw5n1h2txyewy                                  Ok
Microsoft.Windows.CallingShellApp           1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.CallingShellApp_cw5n1h2txyewy                                        Ok
Microsoft.Windows.CapturePicker             10.0.19580.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.CapturePicker_cw5n1h2txyewy                                          Ok
Microsoft.CredDialogHost                    10.0.19595.1001           Neutral C:\Windows\SystemApps\microsoft.creddialoghost_cw5n1h2txyewy                                                 Ok
Microsoft.Windows.NarratorQuickStart        10.0.22621.1              Neutral C:\Windows\SystemApps\microsoft.windows.narratorquickstart_8wekyb3d8bbwe                                     Ok
Microsoft.Windows.ParentalControls          1000.22621.1.0            Neutral C:\Windows\SystemApps\ParentalControls_cw5n1h2txyewy                                                         Ok
Windows.PrintDialog                         6.2.2.0                   Neutral C:\Windows\PrintDialog                                                                                       Ok
Microsoft.Windows.PeopleExperienceHost      10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy                                   Ok
1527c705-839a-4832-9118-54d4Bd6a0c89        10.0.19640.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.FilePicker_cw5n1h2txyewy                                             Ok
c5e2524a-ea46-4f67-841f-6a9465d9d515        10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.FileExplorer_cw5n1h2txyewy                                           Ok
E2A4F912-2574-4A75-9BB0-0D023378592B        10.0.19640.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.AppResolverUX_cw5n1h2txyewy                                          Ok
F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE        10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.AddSuggestedFoldersToLibraryDialog_cw5n1h2txyewy                     Ok
Microsoft.AccountsControl                   10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.AccountsControl_cw5n1h2txyewy                                                Ok
Microsoft.AsyncTextService                  10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.AsyncTextService_8wekyb3d8bbwe                                               Ok
Microsoft.Windows.PrintQueueActionCenter    1.0.1.0                   Neutral C:\Windows\SystemApps\Microsoft.Windows.PrintQueueActionCenter_cw5n1h2txyewy                                 Ok
Microsoft.Windows.XGpuEjectDialog           10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.XGpuEjectDialog_cw5n1h2txyewy                                        Ok
Microsoft.XboxGameCallableUI                1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.XboxGameCallableUI_cw5n1h2txyewy                                             Ok
NcsiUwpApp                                  1000.22621.1.0            Neutral C:\Windows\SystemApps\NcsiUwpApp_8wekyb3d8bbwe                                                               Ok
MicrosoftCorporationII.QuickAssist          2.0.22.0                      X64 C:\Program Files\WindowsApps\microsoftcorporationii.quickassist_2.0.22.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.XboxSpeechToTextOverlay           1.21.13002.0                  X64 C:\Program Files\WindowsApps\microsoft.xboxspeechtotextoverlay_1.21.13002.0_x64__8wekyb3d8bbwe               Ok
Microsoft.XboxGameOverlay                   1.54.4001.0                   X64 C:\Program Files\WindowsApps\microsoft.xboxgameoverlay_1.54.4001.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.Xbox.TCUI                         1.24.10001.0                  X64 C:\Program Files\WindowsApps\microsoft.xbox.tcui_1.24.10001.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.SecHealthUI                       1000.25873.9001.0             X64 C:\Program Files\WindowsApps\microsoft.sechealthui_1000.25873.9001.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.People                            10.2202.33.0                  X64 C:\Program Files\WindowsApps\microsoft.people_10.2202.33.0_x64__8wekyb3d8bbwe                                Ok
Microsoft.HEVCVideoExtension                2.0.61931.0                   X64 C:\Program Files\WindowsApps\microsoft.hevcvideoextension_2.0.61931.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.BingWeather                       4.53.52331.0                  X64 C:\Program Files\WindowsApps\microsoft.bingweather_4.53.52331.0_x64__8wekyb3d8bbwe                           Ok
Microsoft.UI.Xaml.2.8                       8.2310.30001.0                X64 C:\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.8                       8.2310.30001.0                X86 C:\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.MicrosoftSolitaireCollection      4.18.11020.0                  X64 C:\Program Files\WindowsApps\Microsoft.MicrosoftSolitaireCollection_4.18.11020.0_x64__8wekyb3d8bbwe          Ok
Microsoft.HEIFImageExtension                1.0.63001.0                   X64 C:\Program Files\WindowsApps\Microsoft.HEIFImageExtension_1.0.63001.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.WindowsFeedbackHub                1.2309.12711.0                X64 C:\Program Files\WindowsApps\Microsoft.WindowsFeedbackHub_1.2309.12711.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.LanguageExperiencePackes-ES       22621.51.191.0            Neutral C:\Program Files\WindowsApps\Microsoft.LanguageExperiencePackes-ES_22621.51.191.0_neutral__8wekyb3d8bbwe     Ok
Microsoft.WindowsAppRuntime.CBS             4000.1027.2341.0              X64 C:\Windows\SystemApps\Microsoft.WindowsAppRuntime.CBS_8wekyb3d8bbwe                                          Ok
Microsoft.Windows.CloudExperienceHost       10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy                                    Ok
Microsoft.Windows.StartMenuExperienceHost   10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy                                Ok
Microsoft.Windows.ShellExperienceHost       10.0.22621.2506           Neutral C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy                                                      Ok
Microsoft.Windows.ContentDeliveryManager    10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy                                 Ok
Microsoft.Windows.SecureAssessmentBrowser   10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.SecureAssessmentBrowser_cw5n1h2txyewy                                Ok
Microsoft.ECApp                             10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.ECApp_8wekyb3d8bbwe                                                          Ok
Microsoft.Winget.Platform.Source            2023.1102.1838.719        Neutral C:\Program Files\WindowsApps\Microsoft.Winget.Platform.Source_2023.1102.1838.719_neutral__8wekyb3d8bbwe      Ok
Microsoft.WebMediaExtensions                1.0.62931.0                   X64 C:\Program Files\WindowsApps\Microsoft.WebMediaExtensions_1.0.62931.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.RawImageExtension                 2.1.63181.0                   X64 C:\Program Files\WindowsApps\Microsoft.RawImageExtension_2.1.63181.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.Winget.Source                     2023.1127.2224.867        Neutral C:\Program Files\WindowsApps\Microsoft.Winget.Source_2023.1127.2224.867_neutral__8wekyb3d8bbwe               Ok
Microsoft.WindowsTerminal                   1.18.3181.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe                        Ok
MicrosoftWindows.Client.CBS                 1000.22681.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy                                              Ok
Microsoft.DesktopAppInstaller               1.21.3482.0                   X64 C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.21.3482.0_x64__8wekyb3d8bbwe                    Ok
Microsoft.Getstarted                        10.2312.1.0                   X64 C:\Program Files\WindowsApps\Microsoft.Getstarted_10.2312.1.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.CompanyPortal                     11.2.360.0                    X64 C:\Program Files\WindowsApps\Microsoft.CompanyPortal_11.2.360.0_x64__8wekyb3d8bbwe                           Ok
Microsoft.Paint                             11.2311.29.0                  X64 C:\Program Files\WindowsApps\Microsoft.Paint_11.2311.29.0_x64__8wekyb3d8bbwe                                 Ok
Microsoft.WindowsAppRuntime.1.4             4000.1082.2259.0              X86 C:\Program Files\WindowsApps\Microsoft.WindowsAppRuntime.1.4_4000.1082.2259.0_x86__8wekyb3d8bbwe             Ok
Microsoft.WindowsAppRuntime.1.4             4000.1082.2259.0              X64 C:\Program Files\WindowsApps\Microsoft.WindowsAppRuntime.1.4_4000.1082.2259.0_x64__8wekyb3d8bbwe             Ok
Microsoft.LockApp                           10.0.22621.3007           Neutral C:\Windows\SystemApps\Microsoft.LockApp_cw5n1h2txyewy                                                        Ok
MSTeams                                     23320.3027.2591.1505          X64 C:\Program Files\WindowsApps\MSTeams_23320.3027.2591.1505_x64__8wekyb3d8bbwe                                 Ok
Microsoft.WindowsStore                      22312.1401.5.0                X64 C:\Program Files\WindowsApps\Microsoft.WindowsStore_22312.1401.5.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.StorePurchaseApp                  22312.1401.1.0                X64 C:\Program Files\WindowsApps\Microsoft.StorePurchaseApp_22312.1401.1.0_x64__8wekyb3d8bbwe                    Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.33321.0                  X86 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33321.0_x86__8wekyb3d8bbwe              Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.33321.0                  X64 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33321.0_x64__8wekyb3d8bbwe              Ok
Microsoft.VCLibs.140.00                     14.0.33321.0                  X86 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00_14.0.33321.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.VCLibs.140.00                     14.0.33321.0                  X64 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00_14.0.33321.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.Todos                             2.114.7122.0                  X64 C:\Program Files\WindowsApps\Microsoft.Todos_2.114.7122.0_x64__8wekyb3d8bbwe                                 Ok
Microsoft.WindowsCalculator                 11.2311.0.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsCalculator_11.2311.0.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.WebpImageExtension                1.1.171.0                     X64 C:\Program Files\WindowsApps\Microsoft.WebpImageExtension_1.1.171.0_x64__8wekyb3d8bbwe                       Ok
Microsoft.WindowsSoundRecorder              11.2312.2.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsSoundRecorder_11.2312.2.0_x64__8wekyb3d8bbwe                   Ok
Microsoft.ZuneMusic                         11.2312.7.0                   X64 C:\Program Files\WindowsApps\Microsoft.ZuneMusic_11.2312.7.0_x64__8wekyb3d8bbwe                              Ok
Microsoft.WindowsCamera                     2023.2312.3.0                 X64 C:\Program Files\WindowsApps\Microsoft.WindowsCamera_2023.2312.3.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.ScreenSketch                      11.2312.33.0                  X64 C:\Program Files\WindowsApps\Microsoft.ScreenSketch_11.2312.33.0_x64__8wekyb3d8bbwe                          Ok
Microsoft.WindowsNotepad                    11.2312.18.0                  X64 C:\Program Files\WindowsApps\Microsoft.WindowsNotepad_11.2312.18.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.Windows.Photos                    2024.11010.10002.0            X64 C:\Program Files\WindowsApps\Microsoft.Windows.Photos_2024.11010.10002.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.MicrosoftEdge.Stable              121.0.2277.83             Neutral C:\Program Files\WindowsApps\Microsoft.MicrosoftEdge.Stable_121.0.2277.83_neutral__8wekyb3d8bbwe             Ok
MicrosoftWindows.Client.WebExperience       424.400.20.0                  X64 C:\Program Files\WindowsApps\MicrosoftWindows.Client.WebExperience_424.400.20.0_x64__cw5n1h2txyewy           Ok
Microsoft.YourPhone                         1.23112.87.0                  X64 C:\Program Files\WindowsApps\Microsoft.YourPhone_1.23112.87.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.Windows.DevHomeGitHubExtension    0.1000.393.0                  X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHomeGitHubExtension_0.1000.393.0_x64__8wekyb3d8bbwe        Ok
Microsoft.Windows.DevHome                   0.1001.389.0                  X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHome_0.1001.389.0_x64__8wekyb3d8bbwe                       Ok
Microsoft.Windows.DevHomeAzureExtension     0.500.389.0                   X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHomeAzureExtension_0.500.389.0_x64__8wekyb3d8bbwe          Ok
Microsoft.VP9VideoExtensions                1.1.41.0                      X64 C:\Program Files\WindowsApps\Microsoft.VP9VideoExtensions_1.1.41.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.ZuneVideo                         10.22091.10061.0              X64 C:\Program Files\WindowsApps\Microsoft.ZuneVideo_10.22091.10061.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.PowerAutomateDesktop              11.2401.31.0                  X64 C:\Program Files\WindowsApps\Microsoft.PowerAutomateDesktop_11.2401.31.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.OneDriveSync                      24020.128.3.0             Neutral C:\Program Files\WindowsApps\Microsoft.OneDriveSync_24020.128.3.0_neutral__8wekyb3d8bbwe                     Ok


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- AppxPackage - AllUser ----
-------------------------------

Name                                        Version              Architecture InstallLocation                                                                                          Status
----                                        -------              ------------ ---------------                                                                                          ------
1527c705-839a-4832-9118-54d4Bd6a0c89        10.0.19640.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.FilePicker_cw5n1h2txyewy                                             Ok
c5e2524a-ea46-4f67-841f-6a9465d9d515        10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.FileExplorer_cw5n1h2txyewy                                           Ok
E2A4F912-2574-4A75-9BB0-0D023378592B        10.0.19640.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.AppResolverUX_cw5n1h2txyewy                                          Ok
F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE        10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.AddSuggestedFoldersToLibraryDialog_cw5n1h2txyewy                     Ok
Microsoft.AAD.BrokerPlugin                  1000.19580.1000.0         Neutral C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy                                               Ok
Microsoft.AccountsControl                   10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.AccountsControl_cw5n1h2txyewy                                                Ok
Microsoft.AsyncTextService                  10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.AsyncTextService_8wekyb3d8bbwe                                               Ok
Microsoft.BioEnrollment                     10.0.19587.1000           Neutral C:\Windows\SystemApps\Microsoft.BioEnrollment_cw5n1h2txyewy                                                  Ok
Microsoft.CredDialogHost                    10.0.19595.1001           Neutral C:\Windows\SystemApps\microsoft.creddialoghost_cw5n1h2txyewy                                                 Ok
Microsoft.MicrosoftEdgeDevToolsClient       1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe                                    Ok
Microsoft.UI.Xaml.CBS                       8.2305.16002.0                X64 C:\Windows\SystemApps\Microsoft.UI.Xaml.CBS_8wekyb3d8bbwe                                                    Ok
Microsoft.Win32WebViewHost                  10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Win32WebViewHost_cw5n1h2txyewy                                               Ok
Microsoft.Windows.Apprep.ChxApp             1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy                                          Ok
Microsoft.Windows.AssignedAccessLockApp     1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.AssignedAccessLockApp_cw5n1h2txyewy                                  Ok
Microsoft.Windows.CallingShellApp           1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.CallingShellApp_cw5n1h2txyewy                                        Ok
Microsoft.Windows.CapturePicker             10.0.19580.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.CapturePicker_cw5n1h2txyewy                                          Ok
Microsoft.Windows.NarratorQuickStart        10.0.22621.1              Neutral C:\Windows\SystemApps\microsoft.windows.narratorquickstart_8wekyb3d8bbwe                                     Ok
Microsoft.Windows.OOBENetworkCaptivePortal  10.0.21302.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.OOBENetworkCaptivePortal_cw5n1h2txyewy                               Ok
Microsoft.Windows.OOBENetworkConnectionFlow 10.0.21302.1000           Neutral C:\Windows\SystemApps\Microsoft.Windows.OOBENetworkConnectionFlow_cw5n1h2txyewy                              Ok
Microsoft.Windows.ParentalControls          1000.22621.1.0            Neutral C:\Windows\SystemApps\ParentalControls_cw5n1h2txyewy                                                         Ok
Microsoft.Windows.PeopleExperienceHost      10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.PeopleExperienceHost_cw5n1h2txyewy                                   Ok
Microsoft.Windows.PinningConfirmationDialog 1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.Windows.PinningConfirmationDialog_cw5n1h2txyewy                              Ok
Microsoft.Windows.PrintQueueActionCenter    1.0.1.0                   Neutral C:\Windows\SystemApps\Microsoft.Windows.PrintQueueActionCenter_cw5n1h2txyewy                                 Ok
Microsoft.Windows.XGpuEjectDialog           10.0.22621.1              Neutral C:\Windows\SystemApps\Microsoft.Windows.XGpuEjectDialog_cw5n1h2txyewy                                        Ok
Microsoft.WindowsAppRuntime.CBS             4000.1000.1727.0              X64 C:\Windows\SystemApps\Microsoft.WindowsAppRuntime.CBS_8wekyb3d8bbwe                                          Ok
Microsoft.XboxGameCallableUI                1000.22621.1.0            Neutral C:\Windows\SystemApps\Microsoft.XboxGameCallableUI_cw5n1h2txyewy                                             Ok
MicrosoftWindows.Client.FileExp             1000.22651.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.FileExp_cw5n1h2txyewy                                          Ok
MicrosoftWindows.UndockedDevKit             10.0.22621.1              Neutral C:\Windows\SystemApps\MicrosoftWindows.UndockedDevKit_cw5n1h2txyewy                                          Ok
NcsiUwpApp                                  1000.22621.1.0            Neutral C:\Windows\SystemApps\NcsiUwpApp_8wekyb3d8bbwe                                                               Ok
Windows.CBSPreview                          10.0.19580.1000           Neutral C:\Windows\SystemApps\Windows.CBSPreview_cw5n1h2txyewy                                                       Ok
windows.immersivecontrolpanel               10.0.6.1000               Neutral C:\Windows\ImmersiveControlPanel                                                                             Ok
Windows.PrintDialog                         6.2.2.0                   Neutral C:\Windows\PrintDialog                                                                                       Ok
Microsoft.549981C3F5F10                     4.2308.1005.0                 X64 C:\Program Files\WindowsApps\microsoft.549981c3f5f10_4.2308.1005.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.BingNews                          4.55.62231.0                  X64 C:\Program Files\WindowsApps\microsoft.bingnews_4.55.62231.0_x64__8wekyb3d8bbwe                              Ok
Microsoft.BingWeather                       4.53.52331.0                  X64 C:\Program Files\WindowsApps\microsoft.bingweather_4.53.52331.0_x64__8wekyb3d8bbwe                           Ok
Microsoft.GetHelp                           10.2308.12552.0               X64 C:\Program Files\WindowsApps\microsoft.gethelp_10.2308.12552.0_x64__8wekyb3d8bbwe                            Ok
Microsoft.HEVCVideoExtension                2.0.61931.0                   X64 C:\Program Files\WindowsApps\microsoft.hevcvideoextension_2.0.61931.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.NET.Native.Framework.2.2          2.2.29512.0                   X64 C:\Program Files\WindowsApps\microsoft.net.native.framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe               Ok
Microsoft.NET.Native.Framework.2.2          2.2.29512.0                   X86 C:\Program Files\WindowsApps\microsoft.net.native.framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe               Ok
Microsoft.NET.Native.Runtime.2.2            2.2.28604.0                   X64 C:\Program Files\WindowsApps\microsoft.net.native.runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe                 Ok
Microsoft.NET.Native.Runtime.2.2            2.2.28604.0                   X86 C:\Program Files\WindowsApps\microsoft.net.native.runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe                 Ok
Microsoft.People                            10.2202.33.0                  X64 C:\Program Files\WindowsApps\microsoft.people_10.2202.33.0_x64__8wekyb3d8bbwe                                Ok
Microsoft.SecHealthUI                       1000.25873.9001.0             X64 C:\Program Files\WindowsApps\microsoft.sechealthui_1000.25873.9001.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.Services.Store.Engagement         10.0.23012.0                  X64 C:\Program Files\WindowsApps\microsoft.services.store.engagement_10.0.23012.0_x64__8wekyb3d8bbwe             Ok
Microsoft.Services.Store.Engagement         10.0.23012.0                  X86 C:\Program Files\WindowsApps\microsoft.services.store.engagement_10.0.23012.0_x86__8wekyb3d8bbwe             Ok
Microsoft.UI.Xaml.2.1                       2.11906.6001.0                X64 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.1_2.11906.6001.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.3                       2.32002.13001.0               X86 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.3_2.32002.13001.0_x86__8wekyb3d8bbwe                        Ok
Microsoft.UI.Xaml.2.4                       2.42007.9001.0                X86 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.4_2.42007.9001.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.7                       7.2208.15002.0                X64 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.7_7.2208.15002.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.7                       7.2208.15002.0                X86 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.7_7.2208.15002.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.8                       8.2306.22001.0                X64 C:\Program Files\WindowsApps\microsoft.ui.xaml.2.8_8.2306.22001.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.32530.0                  X64 C:\Program Files\WindowsApps\microsoft.vclibs.140.00.uwpdesktop_14.0.32530.0_x64__8wekyb3d8bbwe              Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.32530.0                  X86 C:\Program Files\WindowsApps\microsoft.vclibs.140.00.uwpdesktop_14.0.32530.0_x86__8wekyb3d8bbwe              Ok
Microsoft.VCLibs.140.00                     14.0.32530.0                  X64 C:\Program Files\WindowsApps\microsoft.vclibs.140.00_14.0.32530.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.VCLibs.140.00                     14.0.32530.0                  X86 C:\Program Files\WindowsApps\microsoft.vclibs.140.00_14.0.32530.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.WindowsAppRuntime.1.1             1005.616.1651.0               X64 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.1_1005.616.1651.0_x64__8wekyb3d8bbwe              Ok
Microsoft.WindowsAppRuntime.1.1             1005.616.1651.0               X86 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.1_1005.616.1651.0_x86__8wekyb3d8bbwe              Ok
Microsoft.WindowsAppRuntime.1.3             3000.934.1904.0               X64 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.3_3000.934.1904.0_x64__8wekyb3d8bbwe              Ok
Microsoft.WindowsAppRuntime.1.3             3000.934.1904.0               X86 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.3_3000.934.1904.0_x86__8wekyb3d8bbwe              Ok
Microsoft.WindowsAppRuntime.1.4             4000.1010.1349.0              X64 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.4_4000.1010.1349.0_x64__8wekyb3d8bbwe             Ok
Microsoft.WindowsAppRuntime.1.4             4000.1010.1349.0              X86 C:\Program Files\WindowsApps\microsoft.windowsappruntime.1.4_4000.1010.1349.0_x86__8wekyb3d8bbwe             Ok
Microsoft.Xbox.TCUI                         1.24.10001.0                  X64 C:\Program Files\WindowsApps\microsoft.xbox.tcui_1.24.10001.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.XboxGameOverlay                   1.54.4001.0                   X64 C:\Program Files\WindowsApps\microsoft.xboxgameoverlay_1.54.4001.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.XboxIdentityProvider              12.95.3001.0                  X64 C:\Program Files\WindowsApps\microsoft.xboxidentityprovider_12.95.3001.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.XboxSpeechToTextOverlay           1.21.13002.0                  X64 C:\Program Files\WindowsApps\microsoft.xboxspeechtotextoverlay_1.21.13002.0_x64__8wekyb3d8bbwe               Ok
MicrosoftCorporationII.MicrosoftFamily      0.2.40.0                      X64 C:\Program Files\WindowsApps\microsoftcorporationii.microsoftfamily_0.2.40.0_x64__8wekyb3d8bbwe              Ok
MicrosoftCorporationII.QuickAssist          2.0.22.0                      X64 C:\Program Files\WindowsApps\microsoftcorporationii.quickassist_2.0.22.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.UI.Xaml.2.8                       8.2310.30001.0                X86 C:\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.UI.Xaml.2.8                       8.2310.30001.0                X64 C:\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.MicrosoftSolitaireCollection      4.18.11020.0                  X64 C:\Program Files\WindowsApps\Microsoft.MicrosoftSolitaireCollection_4.18.11020.0_x64__8wekyb3d8bbwe          Ok
Microsoft.HEIFImageExtension                1.0.63001.0                   X64 C:\Program Files\WindowsApps\Microsoft.HEIFImageExtension_1.0.63001.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.WindowsFeedbackHub                1.2309.12711.0                X64 C:\Program Files\WindowsApps\Microsoft.WindowsFeedbackHub_1.2309.12711.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.LanguageExperiencePackes-ES       22621.51.191.0            Neutral C:\Program Files\WindowsApps\Microsoft.LanguageExperiencePackes-ES_22621.51.191.0_neutral__8wekyb3d8bbwe     Ok
Microsoft.WindowsAppRuntime.CBS             4000.1027.2341.0              X64 C:\Windows\SystemApps\Microsoft.WindowsAppRuntime.CBS_8wekyb3d8bbwe                                          Ok
Microsoft.ECApp                             10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.ECApp_8wekyb3d8bbwe                                                          Ok
Microsoft.Windows.CloudExperienceHost       10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy                                    Ok
Microsoft.Windows.ContentDeliveryManager    10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy                                 Ok
Microsoft.Windows.SecureAssessmentBrowser   10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.SecureAssessmentBrowser_cw5n1h2txyewy                                Ok
Microsoft.Windows.ShellExperienceHost       10.0.22621.2506           Neutral C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy                                                      Ok
Microsoft.Windows.StartMenuExperienceHost   10.0.22621.2506           Neutral C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy                                Ok
Microsoft.Winget.Platform.Source            2023.1102.1838.719        Neutral C:\Program Files\WindowsApps\Microsoft.Winget.Platform.Source_2023.1102.1838.719_neutral__8wekyb3d8bbwe      Ok
Microsoft.WebMediaExtensions                1.0.62931.0                   X64 C:\Program Files\WindowsApps\Microsoft.WebMediaExtensions_1.0.62931.0_x64__8wekyb3d8bbwe                     Ok
Microsoft.RawImageExtension                 2.1.63181.0                   X64 C:\Program Files\WindowsApps\Microsoft.RawImageExtension_2.1.63181.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.Winget.Source                     2023.1127.2224.867        Neutral C:\Program Files\WindowsApps\Microsoft.Winget.Source_2023.1127.2224.867_neutral__8wekyb3d8bbwe               Ok
Microsoft.WindowsTerminal                   1.18.3181.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe                        Ok
MicrosoftWindows.Client.CBS                 1000.22681.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy                                              Ok
MicrosoftWindows.Client.Core                1000.22645.1000.0             X64 C:\Windows\SystemApps\MicrosoftWindows.Client.Core_cw5n1h2txyewy                                             Ok
Microsoft.DesktopAppInstaller               1.21.3482.0                   X64 C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.21.3482.0_x64__8wekyb3d8bbwe                    Ok
Microsoft.Getstarted                        10.2312.1.0                   X64 C:\Program Files\WindowsApps\Microsoft.Getstarted_10.2312.1.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.CompanyPortal                     11.2.360.0                    X64 C:\Program Files\WindowsApps\Microsoft.CompanyPortal_11.2.360.0_x64__8wekyb3d8bbwe                           Ok
Microsoft.WindowsAppRuntime.1.4             4000.1082.2259.0              X64 C:\Program Files\WindowsApps\Microsoft.WindowsAppRuntime.1.4_4000.1082.2259.0_x64__8wekyb3d8bbwe             Ok
Microsoft.WindowsAppRuntime.1.4             4000.1082.2259.0              X86 C:\Program Files\WindowsApps\Microsoft.WindowsAppRuntime.1.4_4000.1082.2259.0_x86__8wekyb3d8bbwe             Ok
Microsoft.Paint                             11.2311.29.0                  X64 C:\Program Files\WindowsApps\Microsoft.Paint_11.2311.29.0_x64__8wekyb3d8bbwe                                 Ok
MicrosoftWindows.Client.WebExperience       424.400.20.0                  X64 C:\Program Files\WindowsApps\MicrosoftWindows.Client.WebExperience_424.400.20.0_x64__cw5n1h2txyewy           Ok
Microsoft.LockApp                           10.0.22621.3007           Neutral C:\Windows\SystemApps\Microsoft.LockApp_cw5n1h2txyewy                                                        Ok
MSTeams                                     23320.3027.2591.1505          X64 C:\Program Files\WindowsApps\MSTeams_23320.3027.2591.1505_x64__8wekyb3d8bbwe                                 Ok
Microsoft.OneDriveSync                      24007.109.1.0             Neutral C:\Program Files\WindowsApps\Microsoft.OneDriveSync_24007.109.1.0_neutral__8wekyb3d8bbwe                     Ok
Microsoft.MicrosoftEdge.Stable              120.0.2210.144            Neutral C:\Program Files\WindowsApps\Microsoft.MicrosoftEdge.Stable_120.0.2210.144_neutral__8wekyb3d8bbwe            Ok
Microsoft.WindowsMaps                       11.2311.1.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsMaps_11.2311.1.0_x64__8wekyb3d8bbwe                            Ok
Microsoft.XboxGamingOverlay                 6.123.11012.0                 X64 C:\Program Files\WindowsApps\Microsoft.XboxGamingOverlay_6.123.11012.0_x64__8wekyb3d8bbwe                    Ok
Microsoft.MicrosoftStickyNotes              6.0.2.0                       X64 C:\Program Files\WindowsApps\Microsoft.MicrosoftStickyNotes_6.0.2.0_x64__8wekyb3d8bbwe                       Ok
Microsoft.GamingApp                         2312.1001.18.0                X64 C:\Program Files\WindowsApps\Microsoft.GamingApp_2312.1001.18.0_x64__8wekyb3d8bbwe                           Ok
Microsoft.MicrosoftOfficeHub                18.2311.1071.0                X64 C:\Program Files\WindowsApps\Microsoft.MicrosoftOfficeHub_18.2311.1071.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.WindowsStore                      22312.1401.5.0                X64 C:\Program Files\WindowsApps\Microsoft.WindowsStore_22312.1401.5.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.StorePurchaseApp                  22312.1401.1.0                X64 C:\Program Files\WindowsApps\Microsoft.StorePurchaseApp_22312.1401.1.0_x64__8wekyb3d8bbwe                    Ok
Clipchamp.Clipchamp                         2.8.3.0                   Neutral C:\Program Files\WindowsApps\Clipchamp.Clipchamp_2.8.3.0_neutral__yxz26nhyzhsrt                              Ok
microsoft.windowscommunicationsapps         16005.14326.21778.0           X64 C:\Program Files\WindowsApps\microsoft.windowscommunicationsapps_16005.14326.21778.0_x64__8wekyb3d8bbwe      Ok
Microsoft.OneDriveSync                      24015.121.1.0             Neutral                                                                                                              Ok
Microsoft.Todos                             2.114.7122.0                  X64 C:\Program Files\WindowsApps\Microsoft.Todos_2.114.7122.0_x64__8wekyb3d8bbwe                                 Ok
Microsoft.YourPhone                         1.23112.87.0                  X64 C:\Program Files\WindowsApps\Microsoft.YourPhone_1.23112.87.0_x64__8wekyb3d8bbwe                             Ok
Microsoft.VCLibs.140.00                     14.0.33321.0                  X64 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00_14.0.33321.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.VCLibs.140.00                     14.0.33321.0                  X86 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00_14.0.33321.0_x86__8wekyb3d8bbwe                         Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.33321.0                  X64 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33321.0_x64__8wekyb3d8bbwe              Ok
Microsoft.VCLibs.140.00.UWPDesktop          14.0.33321.0                  X86 C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33321.0_x86__8wekyb3d8bbwe              Ok
Microsoft.ZuneMusic                         11.2312.7.0                   X64 C:\Program Files\WindowsApps\Microsoft.ZuneMusic_11.2312.7.0_x64__8wekyb3d8bbwe                              Ok
Microsoft.WindowsSoundRecorder              11.2312.2.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsSoundRecorder_11.2312.2.0_x64__8wekyb3d8bbwe                   Ok
Microsoft.WindowsCalculator                 11.2311.0.0                   X64 C:\Program Files\WindowsApps\Microsoft.WindowsCalculator_11.2311.0.0_x64__8wekyb3d8bbwe                      Ok
Microsoft.WebpImageExtension                1.1.171.0                     X64 C:\Program Files\WindowsApps\Microsoft.WebpImageExtension_1.1.171.0_x64__8wekyb3d8bbwe                       Ok
Microsoft.WindowsCamera                     2023.2312.3.0                 X64 C:\Program Files\WindowsApps\Microsoft.WindowsCamera_2023.2312.3.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.ScreenSketch                      11.2312.33.0                  X64 C:\Program Files\WindowsApps\Microsoft.ScreenSketch_11.2312.33.0_x64__8wekyb3d8bbwe                          Ok
Microsoft.Windows.Photos                    2024.11010.10002.0            X64 C:\Program Files\WindowsApps\Microsoft.Windows.Photos_2024.11010.10002.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.WindowsNotepad                    11.2312.18.0                  X64 C:\Program Files\WindowsApps\Microsoft.WindowsNotepad_11.2312.18.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.MicrosoftEdge.Stable              121.0.2277.83             Neutral C:\Program Files\WindowsApps\Microsoft.MicrosoftEdge.Stable_121.0.2277.83_neutral__8wekyb3d8bbwe             Ok
Microsoft.Windows.DevHomeGitHubExtension    0.1000.393.0                  X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHomeGitHubExtension_0.1000.393.0_x64__8wekyb3d8bbwe        Ok
Microsoft.Windows.DevHome                   0.1001.389.0                  X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHome_0.1001.389.0_x64__8wekyb3d8bbwe                       Ok
Microsoft.Windows.DevHomeAzureExtension     0.500.389.0                   X64 C:\Program Files\WindowsApps\Microsoft.Windows.DevHomeAzureExtension_0.500.389.0_x64__8wekyb3d8bbwe          Ok
Microsoft.VP9VideoExtensions                1.1.41.0                      X64 C:\Program Files\WindowsApps\Microsoft.VP9VideoExtensions_1.1.41.0_x64__8wekyb3d8bbwe                        Ok
Microsoft.PowerAutomateDesktop              11.2401.31.0                  X64 C:\Program Files\WindowsApps\Microsoft.PowerAutomateDesktop_11.2401.31.0_x64__8wekyb3d8bbwe                  Ok
Microsoft.ZuneVideo                         10.22091.10061.0              X64 C:\Program Files\WindowsApps\Microsoft.ZuneVideo_10.22091.10061.0_x64__8wekyb3d8bbwe                         Ok
Microsoft.OneDriveSync                      24017.123.1.0             Neutral                                                                                                              Ok
MSTeams                                     23335.232.2637.4844           X64 C:\Program Files\WindowsApps\MSTeams_23335.232.2637.4844_x64__8wekyb3d8bbwe                                  Ok
Microsoft.OneDriveSync                      24020.128.3.0             Neutral C:\Program Files\WindowsApps\Microsoft.OneDriveSync_24020.128.3.0_neutral__8wekyb3d8bbwe                     Ok


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

---- Win32 Products ----
------------------------

Name                                                                             Vendor                       Version          InstallDate IdentifyingNumber                      LocalPackage                   
----                                                                             ------                       -------          ----------- -----------------                      ------------                   
Crystal Reports Basic Runtime Spanish Language Pack for Visual Studio 2008 (x64) Business Objects             10.5.2.0         20240131    {9FBD0602-B068-42D5-8045-9B7A116C58F1} C:\WINDOWS\Installer\446c22.msi
Microsoft Teams Meeting Add-in for Microsoft Office                              Microsoft                    1.23.33413       20240115    {A7AB73A3-CB10-4AA5-9D38-6AEFFBDE4C91} C:\WINDOWS\Installer\2a9f44.msi
Office 16 Click-to-Run Extensibility Component                                   Microsoft Corporation        16.0.17231.20036 20240115    {90160000-008C-0000-1000-0000000FF1CE} C:\WINDOWS\Installer\a1d13.msi 
Office 16 Click-to-Run Localization Component                                    Microsoft Corporation        16.0.17231.20036 20240115    {90160000-008C-0C0A-1000-0000000FF1CE} C:\WINDOWS\Installer\a1d17.msi 
Office 16 Click-to-Run Licensing Component                                       Microsoft Corporation        16.0.17231.20084 20240118    {90160000-007E-0000-1000-0000000FF1CE} c:\WINDOWS\Installer\687ca.msi 
Microsoft .NET Runtime - 6.0.26 (x64)                                            Microsoft Corporation        48.104.7000      20240112    {1A02C1B1-05BB-49F7-9DFF-99A66C6877FC} C:\WINDOWS\Installer\f460c.msi 
Microsoft Visual C++ 2013 x86 Minimum Runtime - 12.0.40664                       Microsoft Corporation        12.0.40664       20231031    {8122DAB1-ED4D-3676-BB0A-CA368196543E} C:\WINDOWS\Installer\fd63d.msi 
Microsoft Visual C++ 2022 X64 Additional Runtime - 14.36.32532                   Microsoft Corporation        14.36.32532      20231031    {0025DD72-A959-45B5-A0A3-7EFEB15A8050} C:\WINDOWS\Installer\fd6b4.msi 
Microsoft Visual C++ 2013 x64 Minimum Runtime - 12.0.40664                       Microsoft Corporation        12.0.40664       20231031    {53CF6934-A98D-3D84-9146-FC4EDF3D5641} C:\WINDOWS\Installer\fd6c4.msi 
Microsoft .NET Host - 6.0.26 (x64)                                               Microsoft Corporation        48.104.7000      20240112    {87EBA554-A002-4EF4-A612-4FFD06092B5B} C:\WINDOWS\Installer\f4615.msi 
Microsoft Intune Management Extension                                            Microsoft Corporation        1.75.102.0       20240129    {E218EEE4-2DA7-4DE4-A148-FF4F38CB7867} C:\WINDOWS\Installer\3343e.msi 
Crystal Reports Basic Runtime for Visual Studio 2008 (x64)                       Business Objects             10.5.2.0         20240131    {2BFA9B05-7418-4EDE-A6FC-620427BAAAA3} C:\WINDOWS\Installer\446c29.msi
Advanced Installer 21.4                                                          Caphyon                      21.4             20240131    {61B33625-F842-4A8F-891B-E62CD1B53A7C} C:\WINDOWS\Installer\447acd.msi
Microsoft .NET Runtime - 6.0.24 (x64)                                            Microsoft Corporation        48.96.4014       20240112    {666FEAD5-547D-451D-B0A7-4DCB3648D53D} C:\WINDOWS\Installer\4e166.msi 
Oracle VM VirtualBox 7.0.10                                                      Oracle and/or its affiliates 7.0.10           20231031    {D989F957-5A0B-4C36-BF71-38BD1A35C2F1} C:\WINDOWS\Installer\fd6d0.msi 
PowerShell 7-x64                                                                 Microsoft Corporation        7.4.0.0          20231127    {AD700148-DD32-4283-8C07-ED1F8AF876CD} C:\WINDOWS\Installer\13ff0b.msi
Microsoft .NET Host FX Resolver - 6.0.24 (x64)                                   Microsoft Corporation        48.96.4014       20240112    {1FACB768-CB68-43B5-BB26-1898E1959990} C:\WINDOWS\Installer\4e16a.msi 
7-Zip 21.07 (x64 edition)                                                        Igor Pavlov                  21.07.00.0       20231031    {23170F69-40C1-2702-2107-000001000000} C:\WINDOWS\Installer\fd6cc.msi 
VMware Tools                                                                     VMware, Inc.                 12.1.5.20735119  20231031    {65A35679-0C08-4C9A-9AC3-46417F198653} C:\WINDOWS\Installer\fd681.msi 
                                                                                                                                           {9AC08E99-230B-47e8-9721-4577B7F124EA}                                
Microsoft Visual C++ 2013 x64 Additional Runtime - 12.0.40664                    Microsoft Corporation        12.0.40664       20231031    {010792BA-551A-3AC0-A7EF-0FAB4156C382} C:\WINDOWS\Installer\fd6c8.msi 
Microsoft Visual C++ 2022 X86 Additional Runtime - 14.36.32532                   Microsoft Corporation        14.36.32532      20231031    {C2C59CAB-8766-4ABD-A8EF-1151A36C41E5} C:\WINDOWS\Installer\fd67e.msi 
Microsoft Windows Desktop Runtime - 6.0.26 (x64)                                 Microsoft Corporation        48.104.6996      20240112    {1F0EB53C-BE30-436A-BC54-FA364227A870} C:\WINDOWS\Installer\f461d.msi 
Microsoft Visual C++ 2013 x86 Additional Runtime - 12.0.40664                    Microsoft Corporation        12.0.40664       20231031    {D401961D-3A20-3AC7-943B-6139D5BD490A} C:\WINDOWS\Installer\fd641.msi 
CodeTwo User Photos For Office365                                                CodeTwo                      2.1.0.0          20240105    {B9DCE3BD-04BC-4F0D-AC45-7FE4C954BF96} C:\WINDOWS\Installer\d3abd3.msi
Microsoft Update Health Tools                                                    Microsoft Corporation        5.72.0.0         20231107    {C6FD611E-7EFE-488C-A0E0-974C09EF6473} C:\WINDOWS\Installer\2c4e4.msi 
Microsoft Visual C++ 2022 X86 Minimum Runtime - 14.36.32532                      Microsoft Corporation        14.36.32532      20231031    {73F77E4E-5A17-46E5-A5FC-8A061047725F} C:\WINDOWS\Installer\fd66a.msi 
Microsoft Visual C++ 2022 X64 Minimum Runtime - 14.36.32532                      Microsoft Corporation        14.36.32532      20231031    {D5D19E2F-7189-42FE-8103-92CD1FA457C2} C:\WINDOWS\Installer\fd6a0.msi 
Microsoft Windows Desktop Runtime - 6.0.24 (x64)                                 Microsoft Corporation        48.96.4015       20240112    {956E923F-CC4F-423A-BE6C-18F5FA7D8D5B} C:\WINDOWS\Installer\4e16e.msi 
AutoFirma                                                                        Gobierno de España           1.8.2            20231107    {30D80F4F-F22D-4079-A445-6F9786658270} C:\WINDOWS\Installer\464f86.msi
Microsoft .NET Host FX Resolver - 6.0.26 (x64)                                   Microsoft Corporation        48.104.7000      20240112    {D81A418F-966D-4069-B3E8-5EE4843CA862} C:\WINDOWS\Installer\f4610.msi 


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
```