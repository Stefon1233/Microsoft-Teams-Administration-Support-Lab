# Microsoft Teams Administration & Support Lab

## 10 — Support Incidents

## Overview

This section summarizes the ten Microsoft Teams support incidents completed during the lab.

The incidents were designed to simulate realistic Microsoft 365 and Microsoft Teams help desk scenarios involving:

- Team access
- Meeting scheduling
- Guest collaboration
- External chat
- Screen sharing
- Meeting recording
- Teams app policies
- Microphone permissions
- Call quality
- Messaging policy restrictions

Each incident followed a structured support workflow:

```text
User Report
    >
Reproduce or Confirm Issue
    >
Review Configuration
    >
Identify Root Cause
    >
Apply Remediation
    >
Verify Restored State
    >
Document Resolution
```

---

## Incident Summary

| Ticket | Scenario | Root Cause | Status |
|---|---|---|---|
| TEAM-001 | User missing access to IT Team | Missing Team membership | Resolved |
| TEAM-002 | User cannot schedule private Teams meetings | Private meeting scheduling disabled in meeting policy | Resolved 
|
| TEAM-003 | Guest user cannot access Teams | Tenant-wide guest access disabled | Resolved |
| TEAM-004 | External Teams communication restricted | External federation disabled | Resolved |
| TEAM-005 | User cannot share screen | Screen sharing disabled in meeting policy | Resolved |
| TEAM-006 | User cannot record Teams meetings | Cloud recording disabled in meeting policy | Resolved |
| TEAM-007 | Incorrect Teams app setup policy | Direct app setup policy assignment removed | Resolved |
| TEAM-008 | Microphone unavailable in Teams | Browser microphone permission blocked | Resolved |
| TEAM-009 | Teams call quality concern | Video issue detected for one participant | Investigation Completed |
| TEAM-010 | User cannot edit sent messages | Message editing disabled in messaging policy | Resolved |

---

# TEAM-001 — User Missing Access to IT Team

## Issue

Amanda Taylor could no longer access the IT Team.

The Team itself remained available to other users.

## Investigation

The IT Team membership was queried with Microsoft Teams PowerShell.

Amanda Taylor was not present in the Team membership.

This isolated the issue to Team membership rather than:

- Microsoft 365 licensing
- Teams service availability
- Meeting policy
- Messaging policy
- Tenant authentication

## Root Cause

```text
Amanda Taylor had been removed from the IT Team.
```

## Resolution

Amanda Taylor was added back to the IT Team as:

```text
Member
```

PowerShell verification confirmed her restored role.

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-001 — Team Access Missing](../Help-Desk-Tickets/TEAM-001-Team-Access-Missing.md)

---

# TEAM-002 — User Cannot Schedule Private Teams Meetings

## Issue

Amanda Taylor was unable to schedule private Microsoft Teams meetings.

## Investigation

The assigned custom meeting policy was reviewed:

```text
IT-Support-Meeting-Policy
```

PowerShell confirmed the affected configuration:

```text
AllowPrivateMeetingScheduling = False
```

## Root Cause

```text
Private meeting scheduling disabled by Teams meeting policy
```

## Resolution

Private meeting scheduling was re-enabled.

PowerShell verification confirmed:

```text
AllowPrivateMeetingScheduling = True
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-002 — Meeting Scheduling Disabled](../Help-Desk-Tickets/TEAM-002-Meeting-Scheduling-Disabled.md)

---

# TEAM-003 — Guest User Cannot Access Microsoft Teams

## Issue

A guest user could no longer collaborate through Teams even though the guest account remained a member of the IT Team.

## Investigation

The guest membership was checked first.

The user was still present as:

```text
Teams Guest User
Role: guest
```

Tenant-level guest configuration was then reviewed.

PowerShell confirmed:

```text
AllowGuestUser = False
```

## Root Cause

```text
Tenant-wide Teams guest access disabled
```

## Resolution

Guest access was re-enabled in the Microsoft Teams Admin Center.

PowerShell later confirmed:

```text
AllowGuestUser = True
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-003 — Guest Access Disabled](../Help-Desk-Tickets/TEAM-003-Guest-Access-Disabled.md)

---

# TEAM-004 — External User Communication Restricted

## Issue

Users were unable to communicate with external Teams users.

## Investigation

Teams external collaboration settings were reviewed.

Microsoft Teams PowerShell was used to inspect federation settings.

During the affected state:

```text
AllowFederatedUsers = False
```

## Root Cause

```text
External Teams federation disabled at the tenant level
```

## Resolution

External access was restored.

PowerShell verification confirmed:

```text
AllowFederatedUsers = True
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-004 — External Chat Restricted](../Help-Desk-Tickets/TEAM-004-External-Chat-Restricted.md)

---

# TEAM-005 — Screen Sharing Disabled During Meetings

## Issue

Amanda Taylor was unable to share her screen during Teams meetings.

## Investigation

The assigned meeting policy was reviewed.

The affected configuration showed:

```text
ScreenSharingMode = Disabled
```

Amanda Taylor was confirmed to be using:

```text
IT-Support-Meeting-Policy
```

## Root Cause

```text
Screen sharing disabled in the assigned Teams meeting policy
```

## Resolution

The policy was changed back to:

```text
ScreenSharingMode = EntireScreen
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-005 — Screen Sharing Disabled](../Help-Desk-Tickets/TEAM-005-Screen-Sharing-Disabled.md)

---

# TEAM-006 — User Cannot Record Microsoft Teams Meetings

## Issue

Amanda Taylor was unable to record Teams meetings.

## Investigation

The custom meeting policy was queried with PowerShell.

The affected state showed:

```text
AllowCloudRecording = False
```

## Root Cause

```text
Cloud meeting recording disabled in the user's assigned meeting policy
```

## Resolution

Cloud meeting recording was enabled.

PowerShell verification confirmed:

```text
AllowCloudRecording = True
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-006 — Meeting Recording Disabled](../Help-Desk-Tickets/TEAM-006-Meeting-Recording-Disabled.md)

---

# TEAM-007 — Incorrect Teams App Setup Policy

## Issue

Amanda Taylor no longer received the custom Teams application configuration intended for IT support users.

## Baseline

The expected policy was:

```text
IT-Support-App-Policy
```

with:

```text
Assignment Type: Direct
```

## Investigation

The direct custom policy assignment was removed.

Amanda Taylor then fell back to the Global organization-wide app setup policy.

PowerShell policy assignment commands were used to review the effective state.

## Root Cause

```text
Direct Teams app setup policy assignment removed
```

## Resolution

The custom policy was reassigned directly:

```text
IT-Support-App-Policy
```

PowerShell later confirmed the restored policy.

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-007 — Incorrect App Policy](../Help-Desk-Tickets/TEAM-007-Incorrect-App-Policy.md)

---

# TEAM-008 — Microphone Unavailable in Microsoft Teams

## Issue

Amanda Taylor could not use her microphone in Microsoft Teams.

## Baseline

Teams initially detected:

- Speaker
- Microphone
- Camera

The Teams test-call option was available.

## Investigation

Browser site permissions were reviewed.

Google Chrome showed:

```text
Microphone: Blocked
```

Teams then displayed a user-facing audio/video permission warning.

This confirmed that the issue was client-side rather than a Microsoft Teams policy or tenant configuration problem.

## Root Cause

```text
Browser microphone permission blocked for Microsoft Teams
```

## Resolution

Microphone access was changed back to:

```text
Allow
```

Teams was refreshed.

The microphone became available again.

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-008 — Microphone Permission Issue](../Help-Desk-Tickets/TEAM-008-Microphone-Permission-Issue.md)

---

# TEAM-009 — Microsoft Teams Call Quality Investigation

## Issue

A completed Teams meeting was reviewed following a call-quality concern.

## Investigation

The meeting contained:

```text
2 participants
```

Microsoft Teams diagnostics identified:

```text
Video issue: 1 affected user
```

Participant audio telemetry showed:

```text
Packet loss: 0%
Round-trip time: 68 ms
Audio codec: OPUS
```

The following diagnostic areas were also reviewed:

- Meetings and calls
- Participant telemetry
- Teams Client Health
- Call Quality Dashboard

## Finding

The available evidence showed a video-related issue affecting one participant.

The audio telemetry did not show packet loss.

The investigation did not assign a root cause beyond what the diagnostic evidence supported.

## Recommended Follow-Up

If the issue recurs, investigate:

- Camera hardware
- Camera permissions
- Browser configuration
- Teams client
- Operating system device permissions
- Local network conditions

## Outcome

```text
STATUS: INVESTIGATION COMPLETED
```

## Ticket Documentation

[TEAM-009 — Call Quality Investigation](../Help-Desk-Tickets/TEAM-009-Call-Quality-Investigation.md)

---

# TEAM-010 — User Cannot Edit Sent Teams Messages

## Issue

Amanda Taylor was unable to edit messages after sending them in Teams.

## Investigation

The assigned messaging policy was:

```text
IT-Support-Messaging-Policy
```

The affected configuration showed:

```text
AllowUserEditMessage = False
```

## Root Cause

```text
Edit sent messages disabled in the assigned Teams messaging policy
```

## Resolution

Message editing was re-enabled.

PowerShell verification confirmed:

```text
AllowUserEditMessage = True
```

## Outcome

```text
STATUS: RESOLVED
```

## Ticket Documentation

[TEAM-010 — Message Editing Disabled](../Help-Desk-Tickets/TEAM-010-Message-Editing-Disabled.md)

---

## Troubleshooting Methods Used

The ten incidents required multiple troubleshooting approaches.

### Microsoft Teams Admin Center

Used to review and modify:

- Team membership
- Guest access
- External access
- Messaging policies
- Meeting policies
- App setup policies
- Meeting diagnostics
- Client health
- Call Quality Dashboard

---

### Microsoft Teams PowerShell

Used to validate:

- Team membership
- Guest access
- Federation
- Meeting policy settings
- Messaging policy settings
- App policy assignments
- Effective user policies
- Restored configuration

Representative commands included:

```powershell
Get-Team
Get-TeamUser
Get-CsOnlineUser
Get-CsTeamsClientConfiguration
Get-CsTenantFederationConfiguration
Get-CsTeamsMeetingPolicy
Get-CsTeamsMessagingPolicy
Get-CsTeamsAppSetupPolicy
Get-CsUserPolicyAssignment
```

---

### Browser and Client Troubleshooting

Used to investigate:

- Microphone permissions
- Device availability
- Teams browser behavior
- User-facing Teams warnings

This demonstrated that not every Microsoft Teams problem is caused by the Microsoft 365 tenant.

---

### Meeting Diagnostics

Used to review:

- Meeting records
- Participant count
- Detected issues
- Audio packet loss
- Round-trip time
- Audio codec
- Video issues
- Client health
- Call Quality Dashboard

---

## Troubleshooting Categories Demonstrated

The support incidents covered several major categories.

### Access

```text
TEAM-001
TEAM-003
TEAM-004
```

### Meeting Policies

```text
TEAM-002
TEAM-005
TEAM-006
```

### Application Policies

```text
TEAM-007
```

### Client and Device Troubleshooting

```text
TEAM-008
```

### Meeting Quality and Diagnostics

```text
TEAM-009
```

### Messaging Policies

```text
TEAM-010
```

---

## Support Workflow Demonstrated

The lab consistently followed a structured troubleshooting method.

```text
1. Identify reported symptom
2. Confirm user and service scope
3. Review current configuration
4. Reproduce or verify the affected state
5. Use Admin Center and/or PowerShell for diagnosis
6. Identify the configuration or client-side cause
7. Apply the smallest appropriate remediation
8. Re-query or retest the environment
9. Confirm restored functionality
10. Document the final result
```

This approach avoided making unrelated configuration changes and provided evidence for both the problem and the remediation.

---

## Incident Outcomes

Of the ten support incidents:

```text
Resolved: 9
Investigation Completed: 1
```

TEAM-009 remained categorized as an investigation because the diagnostic evidence identified a video issue but did not 
conclusively prove a single root cause.

This reflected a realistic support practice: an administrator should not claim a definitive root cause when the available 
evidence does not support one.

---

## Skills Demonstrated

- Microsoft Teams help desk support
- Incident troubleshooting
- Root-cause analysis
- Team access troubleshooting
- Guest access troubleshooting
- External federation troubleshooting
- Meeting policy troubleshooting
- Messaging policy troubleshooting
- App setup policy troubleshooting
- Client and browser troubleshooting
- Microphone support
- Meeting diagnostics
- Participant telemetry
- Call Quality Dashboard
- Microsoft Teams PowerShell
- Post-remediation verification
- Technical documentation
- Evidence-based troubleshooting

---

## Result

Ten Microsoft Teams support incidents were documented as part of the lab.

The incidents demonstrated troubleshooting across multiple layers of the Microsoft Teams environment:

```text
Identity
    |
Team Membership
    |
Guest / External Collaboration
    |
User Policies
    |
Teams Applications
    |
Browser / Client
    |
Audio / Video Devices
    |
Meeting Telemetry
    |
Call Quality
```

The completed support scenarios provide portfolio evidence of both Microsoft Teams administration and practical 
troubleshooting rather than configuration work alone.
