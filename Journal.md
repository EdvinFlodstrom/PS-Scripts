# Journal

So this is where I'll be documenting my process on learning PowerShell scripting.

## 2024-05-21

I wrote some basic, and some slightly less basic, scripts today. Mostly for opening a certain quiz project faster...

## 2024-05-22

Hm. I'm trying to write a script that takes three inputs; one input file path, one output folder path, and one 'Company name'. The point is to replace "[Datum]" and "[Företag]" with proper text. But, uh, it did not quite go according to plan. After writing the script and debugging it for a bit, it actually worked. With some odd results:

Input file contents:

```
My text file...

This is some text in my text file!

Lorem ipsum dolor sit amet

[Datum]       [Företag]

tema tis rolod muspi meroL
```

Output file contents:

```
2024-05-22y 2024-05-22Bingusx2024-05-22 BingusilBingus...

2024-05-22his is so2024-05-22Bingus 2024-05-22Bingusx2024-05-22 in 2024-05-22y 2024-05-22Bingusx2024-05-22 BingusilBingus!

LoBingusBingus2024-05-22 ips2024-05-222024-05-22 2024-05-22oloBingus si2024-05-22 2024-05-222024-05-22Bingus2024-05-22

[2024-05-222024-05-222024-05-222024-05-222024-05-22]       [BingusBingusBingusBingusBingus2024-05-222024-05-22Bingus]

2024-05-22Bingus2024-05-222024-05-22 2024-05-22is Bingusolo2024-05-22 2024-05-222024-05-22spi 2024-05-22BingusBingusoL

```

I really don't know what happened. Or why. But, I'll try debugging it...

I believe I know why the issue above occured. Whenever a letter in the submitted text file appears that matches any letter in 'Datum', that letter is replaced with '2024-05-22'. Same with with 'Företag', but with 'Bingus' in this case, instead.

Alright! It's working now. All I had to do was escape the '[]' characters, like this:

```powershell
$replacementWords = @{
    "\[Datum\]"   = $date
    "\[Företag\]" = $companyName
}
```

So the above was working, but I wasn't satisfied. I wanted to convert a .docx to a .pdf. This wasn't particularly easy, as I would notice. Currently, I can't even seem to open the Word document, despite it being present. PowerShell complains about it being non-existent or moved. Not sure why...

Ah, seems I skipped on some journaling. So, the problem above was with relative/absolute paths. The solution was to convert the relative path to an absolute one using `$absPath = (Resolve-Path -Path $path).Path`. So with that solved, it's now working. I also ran into a problem of it only changing the date and not the company name. I realized relatively quickly that it was because the placeholder for the company name was 'Företag'. Illegal move. Changed that to 'Company' and now it works (seems it doesn't like 'Ö'). The following link proved fruitful in my search for answers:  
'https://codereview.stackexchange.com/questions/174455/powershell-script-to-find-and-replace-in-word-document-including-header-footer'
