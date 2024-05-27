$swApiUrl = 'https://swapi.info'
function Invoke-StarWarsApi {
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Planets', 'Films', 'People')]
        [string]$objectType,

        [int]$id = -1
    )
    try {
        $suffix = $id -ne -1 ? "/$id" : ''
        $path = "$($objectType.ToLower())$suffix"

        $output = Invoke-RestMethod -Uri "$swApiUrl/api/$path" -Method GET
        Write-Output $output
    } catch {
        $msg = "Error calling $swApiUrl/api/$path. $($_.Exception.Message)"
        Write-Host $msg -f Red
    }
}
