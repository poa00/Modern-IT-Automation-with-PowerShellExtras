function Search-SWPerson {
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )
    # load all the people
    $response = Invoke-StarWarsApi -objectType People
    # filter on the name
    $results = $response | Where-Object name -Like "*$Name*"

    if ($null -eq $results) {
        Write-Output @{ Error = "No person results found for '$Name'." }
    } else {
        # return all matches with some properties
        Write-Output $results | Select-Object @{
            Name = 'id'; Expression = { $_.url | Get-SWIdFromUrl }
        }, name, gender, height,
        @{ Name = 'weight'; Expression = { $_.mass } }
    }
}
