# Set the branch name
$branch = "main"  # Change if your branch is different

# Log file for tracking script activity
$logFile = "random_file_push.log"

# Ensure we're in a Git repository
if (-not (Test-Path ".git")) {
    Write-Host "This is not a Git repository. Please run this script inside a Git repo."
    exit
}

# Get a list of all new/modified files
$filesToPush = git ls-files --others --exclude-standard
$modifiedFiles = git diff --name-only

$filesToPush += $modifiedFiles
$filesToPush = $filesToPush | Sort-Object {Get-Random}

# Check if there are any files to push
if ($filesToPush.Count -eq 0) {
    Write-Host "No new files to push."
    exit
}

Write-Host "Found $($filesToPush.Count) files to push."

# Loop through files one by one in random order
foreach ($file in $filesToPush) {
    # Add, commit, and push the file
    git add $file
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    git commit -m "Auto commit for $file on $timestamp"
    git push origin $branch

    # Log the action
    "$timestamp - Pushed $file" | Out-File -Append -FilePath $logFile
    Write-Host "$timestamp - Pushed $file"

    # Wait for a random interval between 30 and 300 seconds
    $interval = Get-Random -Minimum 30 -Maximum 300
    Write-Host "Next push in $interval seconds..."
    Start-Sleep -Seconds $interval
}

Write-Host "All files pushed successfully!"
"All files pushed successfully at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")" | Out-File -Append -FilePath $logFile
