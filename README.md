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
Usage: chatGTP 'Question in single quotes' [Options]                                    
Example: chatGPT 'Write a oneliner in powershell to get a reverse shell'

Options:

-temperature <NUMBER>: set the temperature used.                                        
     If not specified default value is 1.0.
     Lower temperature (e.g. 0.0 / 1.0):
     chatGPT will choose words with a higher probability of occurrence.
     Useful when we want to complete something with the most probable value/phrase/word.
     Higher temperature (e.g. 1.0 / max 2.0):
     Very creative but inconsistent answers.
     Above 1.5 very inconsistent.

-maxtokens <NUMBER>: the maximum number of tokens to generate in completion.            
     If not specified default value is 4000.
     1000 tokens = 750 words.
     Your prompt + max_tokens can't exceed the context lenght of the model.
     Normal models have a context lenght of 2048. New ones accept up to 4096.

-help: print this help. 
```



