# chatGPT POWERSHELL CLIENT

A simple script to query ***one direct question / task*** to chatGPT via terminal.<br>
It doesn't remember questions made previously like the normal web chat.<br> 
Its main porpuse is to use chatGPT as a ***powerful search-engine / terminal-tool*** directly via terminal.<br>
<br>
This is the ***Powershell version*** of the bash script ***"chatGPT_Terminal_Client"***, source here:

```
https://github.com/futurisiko/chatGPT_Terminal_Client
```
<br>

Help:
```
.\chatGPT.ps1 -help
Usage: .\chatGTP.ps1 -model <MODEL> -temperature <NUMBER> -maxtokens <NUMBER> 'Question in single quotes'                                    
Example: .\chatGPT.ps1 -model gpt-4 -temperature 0.7 -maxtoken 1000 'Write a powershell oneliner to launch a command to a servers list'

Options:

-model <model_name>: select which model to use.
     If not specified default value is 'gpt-3.5-turbo'.
     You can try 'gpt-4' to ask more complex question/tasks.

-temperature <NUMBER>: set the temperature used.                                        
     If not specified default value is 0.5.
     Lower temperature (e.g. 0.0 / 1.0):
     chatGPT will choose words with a higher probability of occurrence.
     Useful when we want to complete something with the most probable value/phrase/word.
     Higher temperature (e.g. 1.0 / max 2.0):
     Very creative but inconsistent answers.
     Above 1.5 very inconsistent.

-maxtokens <NUMBER>: the maximum number of tokens to generate in completion.            
     If not specified default value is 4000.
     Your prompt + max_tokens can't exceed the context lenght of the model.

-help: print this help. 
```



