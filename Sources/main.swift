import Foundation
import SlackBot
import Vapor

#if os(Linux)
let workingDirectory = "./"
#else
let workingDirectory: String = {
	let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
	let path = "/\(parent)/../"
	return path
}()
#endif

let configDirectory = workingDirectory + "Config/"
let config = try Settings.Config(prioritized: [.commandLine, .directory(root: configDirectory + "secrets"), .directory(root: configDirectory)])

guard let botToken = config["bot-config", "token"]?.string else {
	throw SlackBot.SlackBotError.missingConfig
}

// MARK: - The actual bot code

let slackBot = SlackBot(withToken: botToken, environment: .development)

slackBot.onStateChange = { slackBot in
	print("slackBot \(slackBot.botName ?? "") changed state to \(slackBot.state)")
}

slackBot.onMessage = { slackBot, slackMessage in
	print("Received message from \(slackMessage.user?.realName ?? "<>") on channel \(slackMessage.channel?.name ?? "<>"):\n\t\(slackMessage.text)")

	if slackMessage.amMentioned {
		print("Why can't they just leave me alone?!?")
		slackMessage.reply(with: "Hey there, <@\(slackMessage.userId)>")
	}

	if slackMessage.text.contains("closeUp") {
		slackBot.disconnect {}
	}
}

slackBot.connect { slackBot, error in
	if let error = error {
		print("error connecting: \(error)")
	}
}
