# Relay

Guild chat enhancement AddOn for World of Warcraft.

## Installation

### Release

Releases will be provided manually at a later date. Here's how to install them:

1. Download the ZIP archive
2. Extract to you WoW folder
    * Ex. `C:\\Program Files (x86)\\World of Warcraft\\Interface\\AddOns`
3. Enable in-game

### Development

```bash
# Clone the latest repository
git clone --recursive https://github.com/EnsignPayton/Relay.git
```

Now, copy the Relay folder to the WoW directory listed above.

## Features

The following features may be toggled on or off individually. (WIP)

* Echo - Allow guild members to talk through your character by relaying their message through guild chat.
* AutoGrats - Automatically congratulate guild members for receiving achievements.

The following are designed to share information between guild members without having to manually inspect or ask a guild member. They can all be toggled through three states: **Vocal**, which responds to the request in guild chat, **Silent**, which responds silently, and **Disabled**, which does not respond at all.

* Play Time
* Level/Experience
* Reputation (With a perticular faction)
* Achievement Points
* Achievement Status (Of a particular achievement)
* Gear (GearScore or average item level)

## Design

This AddOn makes heavy use of inter-addon communication through **AceComm**.

Message parameters are space-delimited in the message body.

The format for messages are as follows:

|Feature|Header|Sub-Header|Data|Notes|
|---|---|---|---|---|
|Echo Command|`Relay`|`Echo`|Message Text|
|Play Time Request|`Relay`|`TimeQ`
|Play Time Response|`Relay`|`TimeR`|`Total Level`|Play time in seconds
|Experience Request|`Relay`|`ExpQ`
|Experience Response|`Relay`|`ExpR`|`Level Current Max`
|Achievement Points Request|`Relay`|`ApsQ`
|Achievement Points Response|`Relay`|`ApsR`|`Points`
|Achievement Status Request|`Relay`|`AchQ`|`AchievementID`
|Achievement Status Response|`Relay`|`AchR`|`AchievementID Status`| true or false
|Gear Request|`Relay`|`GearQ`|`Type`|`GS` or `IL`
|Gear Response|`Relay`|`GearR`|`Type Value`

[AddOn Message API Reference](http://wowprogramming.com/docs/api/SendAddonMessage)

## To-Do

* Fix play time
* GearScore/Item Level integration
* Reputation command
* Configuration for all options
