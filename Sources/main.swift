import Foundation
import SlackBot

let slackBot = SlackBot(withToken: "<your slack bot token>", environment: .custom("showingOff"))

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
