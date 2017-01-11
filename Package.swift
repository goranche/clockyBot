import PackageDescription

let package = Package(
	name: "clockyBot",
	dependencies: [
		.Package(url: "https://github.com/goranche/SlackBot.git", majorVersion: 0)
	]
)
