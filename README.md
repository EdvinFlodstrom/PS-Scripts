# PS-Scripts

This here's a collection of scripts that I've been testing. I'm not planning on actively using all of them, but I'll save them in this repository for potential future use. Do note that any absolute paths are temporary. I don't actually store, for example, my quiz repository in `C:\Path1`. Below, I'll be documenting what each script does...

## Quiz

### Quiz.ps1

This script does two things: 1) It changes the directory of the current PowerShell instance to `$ps1Path`. 2) It opens two new PowerShell instances and sets their active directories to `$ps2Path` and `$ps3Path`, respectively. The point of this is to quickly and easily open the root of a certain project, and the frontend/backend.

### StartQuiz.ps1

This script does the same as the above, but with a bit of added functionality. The frontend PowerShell instance also runs `npm start`, and the backend PowerShell instance runs `dotnet watch run --launch-profile https`.
