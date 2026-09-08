# Microsoft Teams Administration & Support Lab
# Teams-Administration.ps1
#
# Purpose:
# Provides a read-only Microsoft Teams administration inventory covering
# tenant connectivity, users, Teams, channels, memberships, custom policies,
# guest access, external federation, and effective user policy assignments.
#
# This script is intended for lab documentation and administrative validation.
# It does not modify tenant configuration.

Clear-Host

Write-Host "============================================================"
Write-Host " MICROSOFT TEAMS ADMINISTRATION & SUPPORT LAB"
Write-Host " ADMINISTRATIVE INVENTORY"
Write-Host "============================================================"
Write-Host ""

# ------------------------------------------------------------
# Environment
# ------------------------------------------------------------

Write-Host "=== POWERSHELL ENVIRONMENT ==="
Write-Host ""

[PSCustomObject]@{
    PowerShellVersion = $PSVersionTable.PSVersion.ToString()
    TeamsModule       = (
        Get-Module MicrosoftTeams -ListAvailable |
        Sort-Object Version -Descending |
        Select-Object -First 1
    ).Version.ToString()
}

Write-Host ""

# ------------------------------------------------------------
# Connect to Microsoft Teams
# ------------------------------------------------------------

Write-Host "=== MICROSOFT TEAMS CONNECTION ==="
Write-Host ""

$ExistingModule = Get-Module MicrosoftTeams

if (-not $ExistingModule) {
    Import-Module MicrosoftTeams
}

try {
    $Tenant = Get-CsTenant -ErrorAction Stop
    Write-Host "Existing Microsoft Teams session detected."
}
catch {
    Write-Host "No active Teams session detected."
    Write-Host "Starting Microsoft Teams authentication..."
    Write-Host ""

    Connect-MicrosoftTeams -DisableWAM

    $Tenant = Get-CsTenant
}

Write-Host ""

[PSCustomObject]@{
    Connection = "Successful"
    Tenant     = $Tenant.DisplayName
}

Write-Host ""

# ------------------------------------------------------------
# Teams Users
# ------------------------------------------------------------

Write-Host "=== TEAMS USER INVENTORY ==="
Write-Host ""

$Users = Get-CsOnlineUser -ResultSize 1000

[PSCustomObject]@{
    TeamsUsers = $Users.Count
}

Write-Host ""

Write-Host "Sample Users:"
Write-Host ""

$Users |
    Where-Object DisplayName |
    Sort-Object DisplayName |
    Select-Object -First 10 DisplayName

Write-Host ""

# ------------------------------------------------------------
# Teams Inventory
# ------------------------------------------------------------

Write-Host "=== MICROSOFT TEAMS INVENTORY ==="
Write-Host ""

$Teams = Get-Team

Write-Host "Teams Detected: $($Teams.Count)"
Write-Host ""

$Teams |
    Sort-Object DisplayName |
    Select-Object DisplayName, Visibility, Archived

Write-Host ""

# ------------------------------------------------------------
# IT Team
# ------------------------------------------------------------

Write-Host "=== IT TEAM CONFIGURATION ==="
Write-Host ""

$ITTeam = Get-Team -DisplayName "IT" |
    Select-Object -First 1

if ($ITTeam) {

    $ITTeam |
        Select-Object DisplayName, Visibility, Archived

    Write-Host ""

    # --------------------------------------------------------
    # Channels
    # --------------------------------------------------------

    Write-Host "=== IT TEAM CHANNELS ==="
    Write-Host ""

    Get-TeamChannel -GroupId $ITTeam.GroupId |
        Select-Object DisplayName, MembershipType |
        Sort-Object DisplayName

    Write-Host ""

    # --------------------------------------------------------
    # Membership
    # --------------------------------------------------------

    Write-Host "=== IT TEAM MEMBERSHIP ==="
    Write-Host ""

    Get-TeamUser -GroupId $ITTeam.GroupId |
        Select-Object Name, Role |
        Sort-Object Role, Name
}
else {
    Write-Host "IT Team was not found."
}

Write-Host ""

# ------------------------------------------------------------
# Guest Access
# ------------------------------------------------------------

Write-Host "=== GUEST ACCESS ==="
Write-Host ""

$GuestConfiguration = Get-CsTeamsClientConfiguration

[PSCustomObject]@{
    GuestAccessEnabled = $GuestConfiguration.AllowGuestUser
}

Write-Host ""

if ($ITTeam) {

    Write-Host "IT Team Guest Membership:"
    Write-Host ""

    Get-TeamUser -GroupId $ITTeam.GroupId |
        Where-Object Role -eq "guest" |
        Select-Object Name, Role
}

Write-Host ""

# ------------------------------------------------------------
# External Federation
# ------------------------------------------------------------

Write-Host "=== EXTERNAL ACCESS / FEDERATION ==="
Write-Host ""

Get-CsTenantFederationConfiguration |
    Select-Object AllowFederatedUsers, AllowTeamsConsumer

Write-Host ""

# ------------------------------------------------------------
# Custom Messaging Policy
# ------------------------------------------------------------

Write-Host "=== CUSTOM MESSAGING POLICY ==="
Write-Host ""

$MessagingPolicyName = "IT-Support-Messaging-Policy"

try {
    Get-CsTeamsMessagingPolicy -Identity $MessagingPolicyName |
        Select-Object `
            Identity,
            AllowUserChat,
            AllowUserDeleteMessage,
            AllowUserEditMessage,
            ReadReceiptsEnabledType
}
catch {
    Write-Host "$MessagingPolicyName was not found."
}

Write-Host ""

# ------------------------------------------------------------
# Custom Meeting Policy
# ------------------------------------------------------------

Write-Host "=== CUSTOM MEETING POLICY ==="
Write-Host ""

$MeetingPolicyName = "IT-Support-Meeting-Policy"

try {
    Get-CsTeamsMeetingPolicy -Identity $MeetingPolicyName |
        Select-Object `
            Identity,
            AllowPrivateMeetingScheduling,
            ScreenSharingMode,
            AllowCloudRecording,
            AllowTranscription,
            AllowMeetNow
}
catch {
    Write-Host "$MeetingPolicyName was not found."
}

Write-Host ""

# ------------------------------------------------------------
# Custom App Setup Policy
# ------------------------------------------------------------

Write-Host "=== CUSTOM APP SETUP POLICY ==="
Write-Host ""

$AppPolicyName = "IT-Support-App-Policy"

try {
    Get-CsTeamsAppSetupPolicy -Identity $AppPolicyName |
        Select-Object Identity, AllowUserPinning
}
catch {
    Write-Host "$AppPolicyName was not found."
}

Write-Host ""

# ------------------------------------------------------------
# Amanda Taylor Effective Policies
# ------------------------------------------------------------

Write-Host "=== AMANDA TAYLOR EFFECTIVE TEAMS POLICIES ==="
Write-Host ""

$Amanda = $Users |
    Where-Object DisplayName -eq "Amanda Taylor" |
    Select-Object -First 1

if ($Amanda) {

    $Amanda.EffectivePolicyAssignments |
        Where-Object {
            $_.PolicyType -in @(
                "TeamsMessagingPolicy",
                "TeamsMeetingPolicy",
                "TeamsAppSetupPolicy"
            )
        } |
        ForEach-Object {

            [PSCustomObject]@{
                PolicyType     = $_.PolicyType
                Policy         = $_.PolicyAssignment.DisplayName
                AssignmentType = $_.PolicyAssignment.AssignmentType
            }

        }
}
else {
    Write-Host "Amanda Taylor was not found."
}

Write-Host ""

# ------------------------------------------------------------
# Final Summary
# ------------------------------------------------------------

Write-Host "=== LAB ADMINISTRATION SUMMARY ==="
Write-Host ""

[PSCustomObject]@{
    Teams               = $Teams.Count
    TeamsUsers          = $Users.Count
    MessagingPolicy     = $MessagingPolicyName
    MeetingPolicy       = $MeetingPolicyName
    AppSetupPolicy      = $AppPolicyName
    GuestAccessEnabled  = $GuestConfiguration.AllowGuestUser
}

Write-Host ""
Write-Host "============================================================"
Write-Host " INVENTORY COMPLETE"
Write-Host "============================================================"
