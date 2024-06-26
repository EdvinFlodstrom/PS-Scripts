# PS-Scripts

This here's a collection of scripts that I've been testing. I'm not planning on actively using all of them, but I'll save them in this repository for potential future use. Do note that any absolute paths are temporary. I don't actually store, for example, my quiz repository in `C:\Path1`. Below, I'll be documenting what each script does...

## Quiz

### Quiz.ps1

This script does two things: 1) It changes the directory of the current PowerShell instance to `$ps1Path`. 2) It opens two new PowerShell instances and sets their active directories to `$ps2Path` and `$ps3Path`, respectively. The point of this is to quickly and easily open the root of a certain project, and the frontend/backend.

### StartQuiz.ps1

This script does the same as the above, but with a bit of added functionality. The frontend PowerShell instance also runs `npm start`, and the backend PowerShell instance runs `dotnet watch run --launch-profile https`.

## General

### CdDir.ps1

This is a small script that I wrote, mainly for testing purposes. It accepts the name of a directory to search for, in `~/`, and an optional boolean for whether or not to run `git status`. So, say you run it with: `.\CdDir.ps1 React-Quiz`. PowerShell moves to that directory (if it exists, otherwise it throws an error) and runs `git status`. I mostly wrote this for learning purposes, I doubt I'll ever actually need this sort of script for anything. Though, with improvements, it may become useful eventually...

## File

### CreatePdfWithDateAndCompany.ps1

This script takes three inputs. The first one is the input file path, the second one is the folder path for the output file, and the third is the name of the company to appear in the PDF. What the script does is that it replaces placeholder '[Date]' and '[Company]' with proper values. So, '[Date]' is replaced with the current date (YYYY-MM-DD), and '[Company]' is replaced with the provided name of the company, such as 'My Company'.

### CreatePdf.ps1

This script is much like the one above, but without replacing any contents. It simply converts the input .docx file to a .pdf file.
