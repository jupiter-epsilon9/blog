+++
title = "Serwer vSphere i PowerCLI"
description = "Przykładowe sesje z serwerem vSphere poprzez PowerCLI"
draft = false
date = "2016-11-30T09:54:32+01:00"
tags = [ "powercli", "vSphere", "vmware" ]
categories = [ "Informatyka", "Wirtualizacja" ]
banner = "../vsphere-powercli.jpg"
#slug= ""

+++

Czasami szybciej jest posłuzyć się konsolą tekstową niż środowiskiem graficznym. Wiedzą to wszyscy użytkownicy Linuxa. Komercyjny vSphere również posiada taką możliwość za pośrednictwem PowerCLI - interfejsu do PowerShell'a.

<!--more-->
## Przykładowe polecenia:

Nawiązanie sesji z vSphere:
~~~
Connect-VIServer 10.0.0.10
~~~

Wyświetlenie wszystkich migawek:
~~~
Get-VM | get-snapshot
Get-VM | get-snapshot | select vm,name,sizegb
~~~

Wyświetlenie wszystkich metod dla wybranej maszyny:
~~~
Get-VM -name storage1 | gm
~~~

Przeniesienie maszyny *storage1* do magazynu danych *ibm_ds_02*:
~~~
Get-VM -name storage1 | Move-VM -Datastore ibm_ds_02
~~~

Przykłady pętli:
~~~
# wyświetla informacje o dysku dla wszystkich maszyn, których nazwa zaczyna sie na STOR:
Get-VM -name STOR* | %{Get-Harddisk -vm $_.name} 
 
# przenosi wszystkie maszyny znajdujące się w folderze DO_MIGRACJI do magazynu ibm_ds_02:
Get-VM -location DO_MIGRACJI | %{Move-VM -vm $_  -Datastore ibm_ds_02 }

# jak wyżej, tylko wg nazwy:
Get-VM -name STOR-* | %{Move-VM -vm $_  -Datastore ibm_ds_02 }

# jak wyżej, nazwy podane bezpośrednio:
Get-VM -name storage1,sotrage2,database1,database2,webserver1 | %{Move-VM -vm $_  -Datastore ibm_ds_02 }
~~~

## Przygotowanie raportu w formacie CSV - plik zostanie utworzony na pulpicie: 

Raport zawiera: Nazwa maszyny, pojemność w GB, ilość CPU, łączna wielkość dysków, nazwy datastore zaczynające się od ibm*, notatkę.

~~~
Connect-VIServer 10.0.0.20
$CSV = [Environment]::GetFolderPath("Desktop")+"\vm.csv"
Get-VM | Select-Object Name, MemoryGB, NumCpu, `
   @{n="HardDiskSizeGB"; e={(Get-HardDisk -VM $_ | Measure-Object -Sum CapacityGB).Sum}}, `
   @{n="Datastore"; e={(Get-Datastore ibm* -VM $_).name}}, Notes `
   | Export-Csv  -Encoding UTF8 -NoTypeInformation -UseCulture $CSV
~~~

Tak przygotowany plik można zaimportować do Excel'a lub OpenOffcie Calc uzyskując raport, którego nie ma możliwości wyeksportować z żadnego widoku konsoli vSphere. Pomyślmy jak przydatny może on być w sytuacji gdy mamy kilkadziesiat/kilkaset maszyn wirtualnych i chcemy przedstawić wybrane dane osobie z zewnątrz.

{{< figure src="../historie-z-wiersza-polecen-powercli1.png" caption="Raport zaimportowano do OpenOffcie Calc a następnie użyto podsumowań i autoformatowanie tabeli, wynik w 5 minut." >}}

*Autor zdjęcia Arthur Caranta, Datacenter @ Night*
