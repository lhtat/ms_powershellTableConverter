$htmlDoc = ConvertFrom-Html -URI "http://localhost:8080"

$htmlTableHeaders = $htmlDoc.SelectNodes('//table/thead/tr[1]/th')

$pwshTable = @()

$tableRows = ($htmlDoc.SelectNodes('//table/tbody/tr')).Count
$pwshTable = for ($row=1; $row -le $tableRows; $row++){
    $htmlTableRow = $htmlDoc.SelectNodes("//table/tbody/tr[$row]/td|//table/tbody/tr[$row]/th")
    $hashRow = @{}
    $i=0
    foreach($cell in $htmlTableHeaders){
        $hashRow[$cell.InnerText] = $htmlTableRow[$i].InnerText
        $i++
    }
    $hashRow
}

