# TEAM-002 — User Cannot Schedule Private Teams Meetings

## Ticket Summary

| Field | Details |
|---|---|
| Ticket ID | TEAM-002 |
| User | Amanda Taylor |
| Service | Microsoft Teams |
| Category | Meeting Policy |
| Priority | Medium |
| Status | Resolved |

## Issue

Amanda Taylor was unable to schedule private Microsoft Teams meetings.

## Investigation

The assigned `IT-Support-Meeting-Policy` was reviewed using Microsoft Teams PowerShell.

The baseline configuration showed private meeting scheduling enabled.

The issue was reproduced by disabling the private meeting scheduling setting in the custom meeting policy.

PowerShell verification then confirmed:

`AllowPrivateMeetingScheduling = False`

Amanda Taylor was also confirmed to be using the affected custom meeting policy.

## Root Cause

Private meeting scheduling had been disabled in the assigned Teams meeting policy.

## Resolution

Private meeting scheduling was re-enabled in the `IT-Support-Meeting-Policy`.

## Verification

PowerShell verification confirmed:

- User: Amanda Taylor
- Meeting policy: `IT-Support-Meeting-Policy`
- Private meeting scheduling: `True`
- Status: Resolved

## Evidence

![Scheduling Baseline](../Screenshots/10-Troubleshooting/56-TEAM-002-Meeting-Scheduling-Baseline.png)

![Scheduling Disabled](../Screenshots/10-Troubleshooting/57-TEAM-002-Meeting-Scheduling-Disabled.png)

![Policy Diagnosis](../Screenshots/10-Troubleshooting/58-TEAM-002-Meeting-Policy-Diagnosis.png)

![Scheduling Restored](../Screenshots/10-Troubleshooting/59-TEAM-002-Meeting-Scheduling-Restored.png)

![Resolution Verified](../Screenshots/10-Troubleshooting/60-TEAM-002-Resolution-Verified.png)

## Support Skills Demonstrated

- Teams meeting policy administration
- Policy assignment troubleshooting
- Microsoft Teams PowerShell
- Configuration comparison
- Service restoration
