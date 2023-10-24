$htmlDoc = ConvertFrom-Html -URI "http://localhost:8080"

$htmlTableHeaders = $htmlDoc.SelectNodes('//table/thead/tr[1]/th')

$pwshTable = @()

$tableRows = ($htmlDoc.SelectNodes('//table/tbody/tr')).Count
$pwshTable = for ($row=1; $row -le $tableRows; $row++){
    $htmlTableRow = $htmlDoc.SelectNodes("//table/tbody/tr[$row]/td|//table/tbody/tr[$row]/th")
    $hashRow = @{}
    $i=0
    foreach($cell in $htmlTableHeaders){
        $hashRow[$cell.InnerText.trim()] = $htmlTableRow[$i].InnerText.trim()
        $i++
    }
    $hashRow
}

$responseJson = Invoke-RestMethod -Method GET "http://localhost:8080/catbreeds/"

foreach ($catbreedTable in $pwshTable) {
    $catbreedTable.Breed
    $catbreedJson = $responseJson.catbreeds | Where-Object { $_.Breed -eq $catbreedTable.Breed }
    if ($null -ne $catbreedJson){
        Write-Output "Breed found: " $catbreedJson.Breed
    } else {
        Write-Output "Breed not found" $catbreedJson.Breed
    }
}