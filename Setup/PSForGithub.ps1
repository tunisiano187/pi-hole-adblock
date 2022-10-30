# Install required tools for this repository and setup required variables
    Install-Module -Name PowerShellForGitHub
    $secureString = ${{ secrets.GITHUB_TOKEN }} | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential "username is ignored", $secureString
    Set-GitHubAuthentication -Credential $cred
    $secureString = $null # clear this out now that it's no longer needed
    $cred = $null # clear this out now that it's no longer needed


    Get-GitHubUser -Current