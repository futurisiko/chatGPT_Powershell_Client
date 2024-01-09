###########################
# Powershell chatGPT script
#
#   *** Simple script to query one direct question to chatGPT from terminal. ***
#
#   *** REMEMBER TO ADD YOUR API KEY ***
#   -> https://beta.openai.com/account/api-keys
#
#
# chatGPT use 2 parameters: max_token and temperature.
#
# -maxtokens = the maximum number of tokens to generate in completion.
#              Default = 4000
#              1000 tokens =~ 750 words
#              Your prompt + max_tokens can't exceed the context lenght of the model.
#              Normal models have a context lenght of 2048.
#              New ones accept 4096.
#
# -temperature = defines the type of processing applied to answer.
#                Default = 1.0
#
#                - lower (e.g. 0.0 / 1.0):
#                chatGPT will choose words with a higher probability of occurrence.
#                Useful when we want to complete something with the most probable value/phrase/word.
#                - higher (e.g. 1.0 / max 2.0):
#                Very creative but inconsistent answers.
#                Above 1.5 very inconsistent.
#
# ---------------------------
# --- Credits: futurisiko ---
# ---------------------------
###########################


### Parameter declaration
param(
    [Parameter()][string]$questionparam,
    [Parameter()][switch]$helpparam,
    [Parameter()]$temperatureparam = 1.0,
    [Parameter()]$maxtokensparam = 4000
)


### API token value
$TOKEN = "" # -> ADD/CHANGE HERE YOUR API TOKEN


### Not token help
if ($TOKEN -eq "") {
    Write-Host "`n--------------------"
    Write-Host "`nNo API token present!" -ForegroundColor red
    Write-Host "`nTo add it modify the script with a text editor."
    Write-Host "You can find the variable TOKEN at the beginning of the code."
    Write-Host "If you do not have it go to:" -NoNewLine
    Write-Host "`n`nhttps://beta.openai.com/account/api-keys" -ForegroundColor green
    Write-Host "`n`nSubscribe and require it."
    Write-Host "Cya! `n"
    Write-Host "`n--------------------`n"
    exit 1
}


### Help function
function Help {
  Write-Host " `n`n--------------------"
  Write-Host "`nchatGPT TERMINAL CLIENT" -ForegroundColor red
  Write-Host "`nSimple powershell script to query one direct question to chatGPT."
  Write-Host "`nUsage:" -NoNewline -ForegroundColor green
  Write-Host " chatGTP.ps1 'Question in single quotes' [Options]"
  Write-Host "Example:" -NoNewline -ForegroundColor yellow
  Write-Host " chatGPT.ps1 'Write a oneliner in powershell to get a reverse shell'"
  Write-Host "`nOptions:"
  Write-Host "`n-temperature <NUMBER>:" -ForegroundColor green -NoNewLine
  Write-Host " set the temperature used."
  Write-Host "     If not specified default value is 1.0."
  Write-Host "     Lower temperature (e.g. 0.0 / 1.0):"
  Write-Host "     chatGPT will choose words with a higher probability of occurrence."
  Write-Host "     Useful when we want to complete something with the most probable value/phrase/word."
  Write-Host "     Higher temperature (e.g. 1.0 / max 2.0):"
  Write-Host "     Very creative but inconsistent answers."
  Write-Host "     Above 1.5 very inconsistent."
  Write-Host "`n-maxtokens <NUMBER>:" -ForegroundColor green -NoNewLine
  Write-Host " the maximum number of tokens to generate in completion."
  Write-Host "     If not specified default value is 4000."
  Write-Host "     1000 tokens = 750 words."
  Write-Host "     Your prompt + max_tokens can't exceed the context lenght of the model."
  Write-Host "     Normal models have a context lenght of 2048. New ones accept up to 4096."
  Write-Host "`n-help:" -ForegroundColor green -NoNewLine
  Write-Host " print this help."
  Write-Host "`nCya!"
  Write-Host "`n--------------------`n`n"
}


### No args print help
if ( $PSBoundParameters.Values.Count -eq 0 -and $args.count -eq 0 ){
    Help
    return
}


### Help flag action
 if ($helpparam.IsPresent) {
    Help
    return
 }


### Input feedback
Write-Host "`n`n--------------------"
Write-Host "`nQuestion: $questionparam" -ForegroundColor red
Write-Host "Temperature: $temperatureparam" -ForegroundColor red
Write-Host "Max tokens: $maxtokensparam" -ForegroundColor red


### Output feedback
Write-Host "`n--------------------"
Write-Host "`nAnswer:" -ForegroundColor green


### Other variables
$model = "gpt-3.5-turbo"


### Build the query (JSON)
$payload = @{
    model = $model
    prompt = $questionparam
    max_tokens = $maxtokensparam
    temperature = $temperatureparam
}
$json = $payload | ConvertTo-Json


### Perform the query
$response = Invoke-RestMethod -Uri 'https://api.openai.com/v1/completions' -Method POST -Body $json -Headers @{Authorization = "Bearer $TOKEN"} -ContentType 'application/json'


### Extract the response
$result = $response.choices | Select-Object -ExpandProperty text


### Output the result
Write-Host $result -ForegroundColor green


### End
Write-Host "`n--------------------`n`n"


