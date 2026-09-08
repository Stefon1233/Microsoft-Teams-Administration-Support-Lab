# TEAM-008 — Microphone Unavailable in Microsoft Teams

## Ticket Summary

| Field | Details |
|---|---|
| Ticket ID | TEAM-008 |
| User | Amanda Taylor |
| Service | Microsoft Teams |
| Category | Client / Audio Device |
| Priority | Medium |
| Status | Resolved |

## Issue

Amanda Taylor could not use her microphone in Microsoft Teams.

## Baseline

Teams initially detected the configured audio and video devices, including:

- Internal speakers
- Iriun virtual microphone
- Iriun camera

The Teams test-call option was also available.

## Investigation

Browser site permissions for `teams.cloud.microsoft` were inspected.

Microphone permission was found blocked.

After microphone access was blocked, Teams showed the audio device fields as unavailable and presented a user-facing warning instructing the user to allow audio/video permissions from the browser address bar.

## Root Cause

Chrome microphone permission for Microsoft Teams was blocked.

## Resolution

Microphone permission for `teams.cloud.microsoft` was changed back to Allow.

Teams was then refreshed and the audio device became available again.

## Verification

After remediation:

- Browser microphone permission showed allowed.
- Teams detected the microphone again.
- The device configuration returned to its working state.
- Teams test-call functionality was available.

## Evidence

![Device Baseline](../Screenshots/10-Troubleshooting/86-TEAM-008-Device-Baseline.png)

![Microphone Permission Blocked](../Screenshots/10-Troubleshooting/87-TEAM-008-Microphone-Permission-Blocked.png)

![Microphone Issue Reproduced](../Screenshots/10-Troubleshooting/88-TEAM-008-Microphone-Issue-Reproduced.png)

![Microphone Permission Restored](../Screenshots/10-Troubleshooting/89-TEAM-008-Microphone-Permission-Restored.png)

![Resolution Verified](../Screenshots/10-Troubleshooting/90-TEAM-008-Device-Access-Resolution-Verified.png)

## Support Skills Demonstrated

- Teams client troubleshooting
- Browser permission troubleshooting
- Microphone and audio device support
- Issue reproduction
- End-user remediation
