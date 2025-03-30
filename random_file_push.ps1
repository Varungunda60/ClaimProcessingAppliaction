# Set the branch name
$mainBranch = "main"  # Change if your main branch is different

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

$commitCount = 0
$randomThreshold = Get-Random -Minimum 2 -Maximum 5  # Set a random number of commits before creating a new branch

foreach ($file in $filesToPush) {
    # Add, commit the file
    git add $file
    git commit -m "Committing $file"

    # Log the action
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - Committed $file" | Out-File -Append -FilePath $logFile
    Write-Host "$timestamp - Committed $file"

    $commitCount++

    # If commit count reaches the threshold, create a new branch and merge it
    if ($commitCount -ge $randomThreshold) {
        $branchName = "feature-" + ($file -replace '[^a-zA-Z0-9]', '_')
        Write-Host "Creating new branch: $branchName"

        git checkout -b $branchName
        git push origin $branchName  # Push the new branch to remote BEFORE merging

        # Merge back to main
        git checkout $mainBranch
        git merge $branchName --no-edit
        git push origin $mainBranch  # Push the merged main branch

        # Log the merge
        "$timestamp - Merged $branchName into $mainBranch" | Out-File -Append -FilePath $logFile
        Write-Host "$timestamp - Merged $branchName into $mainBranch"

        # Delete the merged branch locally and remotely
        git branch -d $branchName
        git push origin --delete $branchName

        # Reset commit counter and set a new random threshold
        $commitCount = 0
        $randomThreshold = Get-Random -Minimum 2 -Maximum 5
    }

    # Wait for a random interval between 30 and 80 seconds
    $interval = Get-Random -Minimum 30 -Maximum 300
    Write-Host "Next push in $interval seconds..."
    Start-Sleep -Seconds $interval
}

Write-Host "All files pushed successfully!"
"All files pushed successfully at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")" | Out-File -Append -FilePath $logFile
