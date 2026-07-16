# pi-hole-adblock
[![Auto Update](https://github.com/tunisiano187/pi-hole-adblock/actions/workflows/au.yml/badge.svg)](https://github.com/tunisiano187/pi-hole-adblock/actions/workflows/au.yml)[![CodeFactor](https://www.codefactor.io/repository/github/tunisiano187/pi-hole-adblock/badge)](https://www.codefactor.io/repository/github/tunisiano187/pi-hole-adblock)

This project will be used to create a list for pi-hole that has most of the spam, scam, ... addresses

That list will be updated automatically and you will be able to add it to your own instance of Pi-hole.

We will use other lists and merge them, and add exceptions.

The exceptions will create their own lists to be able to choose if you want them or not.

## Current lists imported
- [HBlock](https://hblock.molinero.dev)
- [KitsapCreator](https://github.com/KitsapCreator/pihole-blocklists)

## Usage

Add the following URL as an adlist in your Pi-hole instance (`Group Management` > `Adlists`):

```
https://raw.githubusercontent.com/tunisiano187/pi-hole-adblock/main/Lists/all.txt
```

Then run `Tools` > `Update Gravity` (or `pihole -g` from the command line) to apply it.

The individual source lists (before merging) are also available under [`Lists/`](./Lists) if you only want a subset.