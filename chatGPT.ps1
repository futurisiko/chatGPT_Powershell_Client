###########################
# Powershell chatGPT script
#
#   *** Simple script to query one direct question to chatGPT from terminal. ***
#
#   *** REMEMBER TO ADD YOUR API KEY ***
#   -> https://beta.openai.com/account/api-keys
#
# chatGPT.ps1 use 3 parameters: model, max_token and temperature.
#
# -model = 	select which model to use.
#			If not specified default value is 'gpt-3.5-turbo' .
#			You can try 'gpt-4' to ask more complex question/tasks.
#
# -maxtokens = the maximum number of tokens to generate in completion.
#              Default = 4000
#              Your prompt + max_tokens can't exceed the context lenght of the model.
#
# -temperature = defines the type of processing applied to answer.
#                Default = 0.5
#
#                - lower (e.g. 0.0 / 1.0):
#                chatGPT will choose words with a higher probability of occurrence.
#                Useful when we want to complete something with the most probable value/phrase/word.
#                - higher (e.g. 1.0 / max 2.0):
#                Very "creative" but inconsistent answers.
#
# ---------------------------
# --- Credits: futurisiko ---
# ---------------------------
###########################


### Parameter declaration
param(
    [Parameter()][string]$questionparam,
    [Parameter()][switch]$helpparam,
    [Parameter()]$temperatureparam = 0.5,
    [Parameter()]$maxtokensparam = 4000,
	[Parameter()]$model = "gpt-3.5-turbo"
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
  Write-Host " .\chatGTP.ps1 -model <MODEL> -temperature <NUMBER> -maxtokens <NUMBER> 'Question in single quotes' [Options]"
  Write-Host "`nExample:" -NoNewline -ForegroundColor yellow
  Write-Host " .\chatGPT.ps1 'Write a powershell oneliner to launch a command to a servers list'"
  Write-Host "Example:" -NoNewline -ForegroundColor yellow
  Write-Host " .\chatGPT.ps1 -model gpt-4 -temperature 1.0 'Write a powershell oneliner to launch a command to a servers list'"
  Write-Host "`nOptions:"
  Write-Host "`n-model <model_name>:" -ForegroundColor green -NoNewLine
  Write-Host " select which model to use."
  Write-Host "     If not specified default value is 'gpt-3.5-turbo' ."
  Write-Host "     You can try 'gpt-4' to ask more complex question/tasks."
  Write-Host "`n-temperature <NUMBER>:" -ForegroundColor green -NoNewLine
  Write-Host " set the temperature used."
  Write-Host "     If not specified default value is 0.7."
  Write-Host "     Lower temperature (e.g. 0.0 / 1.0):"
  Write-Host "     chatGPT will choose words with a higher probability of occurrence."
  Write-Host "     Useful when we want to complete something with the most probable value/phrase/word."
  Write-Host "     Higher temperature (e.g. 1.0 / max 2.0):"
  Write-Host "     Very creative but inconsistent answers."
  Write-Host "     Above 1.5 very inconsistent."
  Write-Host "`n-maxtokens <NUMBER>:" -ForegroundColor green -NoNewLine
  Write-Host " the maximum number of tokens to generate in completion."
  Write-Host "     If not specified default value is 4000."
  Write-Host "     Your prompt + max_tokens can't exceed the context lenght of the model."
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
Write-Host "Model: $model" -ForegroundColor red
Write-Host "Temperature: $temperatureparam" -ForegroundColor red
Write-Host "Max tokens: $maxtokensparam" -ForegroundColor red


### Output feedback
Write-Host "`n--------------------"
Write-Host "`nAnswer:" -ForegroundColor green


### Headers
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $TOKEN"
}


### Build the query (JSON)
$payload = [ordered]@{
    model = $model
	messages = @(
        [ordered]@{
            role = "system"
            content = $questionparam
		}
    )
	max_tokens = $maxtokensparam
    temperature = $temperatureparam
}
$json = $payload | ConvertTo-Json


### Perform the query
$response = Invoke-WebRequest -Uri "https://api.openai.com/v1/chat/completions" -Method Post -Headers $headers -Body $json


### Extract the responsees | Select-Object -ExpandProperty message | Select-Object -ExpandProperty content
$result = $result = ($response.Content | ConvertFrom-Json).choices[0].message.content


### Output the result
Write-Host $result -ForegroundColor green

### End
Write-Host "`n--------------------`n`n"
