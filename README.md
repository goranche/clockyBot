# clockyBot

An example bot created with [SlackBot](), written in Swift.

## How to start

Set your bot token in `Sources/main.swift`

Fetch the dependencies: `swift package fetch`

Build the project: `swift build` (see "Known issues")

Run it: `.build/debug/clockyBot`

## Known issues

There is a dependency on a Vapor feature that isn't publicly (in terms of protection level) available yet, but a [pull request](https://github.com/vapor/vapor/pull/786) has been submitted. (an explanation of the issue can be found [here](https://github.com/vapor/vapor/issues/785))
Until that is sorted out, you'll have to manually update the Vapor code (explained in a comment at the point where compilation will fail)
