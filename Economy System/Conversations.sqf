params ["_faction"];

private _lines = createHashMapFromArray [
	["Bandit", [
		"Yo what's up survivor. I'm suprised you're taking a job from me, %1. Hoepfully you're up to the task",
		"Nah man. You don't look strong enough for my missions. Take it at your risk, %1",
		"Whatchu lookin' at bub. Take the mission if you really want it"
	]],
	["BB", [
		"Yo what's up, %1. Glad to see you're here for a mission. We've got a surplus of them for sure.",
		"You ever think about how the gang just started from a couple of maniacs on Altis? Crazy when you think about it.",
		"I heard the Russian Federation is in Livonia. I'd keep a look out for digital camo tents since that's what they primarily use.",
		"I've been hearing a lot more rumors about the US military taking action in the area. I'd keep your head on a swivel, %1, since they kill just about any survivor no matter how friendly due to something the Boonie Boys did years ago.",
		"If you ever get a task to help out some sheep farmers, please don't kill the sheep farmers. It'll further destroy our reputation with them.",
		"You hear that we've moved our operations all the way out to Tanoa %1? New Horizion is pretty friendly there, too bad they're lunatics mostly everywhere else.",
		"I heard that the Boonie Boys leader is in town. Apparently he's on his way back to Altis. Absolutely insane idea considering how many nukes went off there just 9 years ago."
	]],
	["DT", [
		"Praise be Poseidon. Don't you agree %1?",
		"It's sad that our homeland of Altis was nuked 9 years ago. I heard a large team was getting ready to embark on a journey back there. I just hope I can join along, what about you, %1?",
		"Praise be Zeus. Too bad he can't give us electricty just for even a day",
		"Praise be Athena and her beauty. Just between you and me, I like to pray to her in my free time the most. What about you, %1?",
		"Praise be Hermes. Loved that guy on Futurama.",
		"Praise be Ares. Just between you and me, %1, he's my favorite",
		"Praise be Hades",
		"Praise be Apollo"
	]],
	["NH", [
		"Let nature decide who shall survive, that's all I gotta say.",
		"Just between you and me, I just like this faction so I can wear a shemag. They look sick",
		"Praise be the apocalypse.",
		"Praise be the Wanderer. Have you ever seen him %1? Sometimes I see him in my sleep."
	]],
	["PF", [
		"GOD DAMN YOU LOOKIN' MIGHTY TASTY %1! I hope to god that you can fulfill your mission our we're having you for dinner.",
		"Damn I'm hungry. Maybe I should have Dave later. He was lookin' mighty weak on the last patrol.",
		"You want a mission from us? Really?"
	]],
	["RC", [
		"It's gonna take a lot of guts to complete one of our missions. I just hope you got the firepower %1.",
		"You know why we're called the Raven's Cloak %1? No idea, but it sounds cool.",
		"Just some free info for a warrior like you, %1, no PMC or military has their best interests for us. We got to look out for each other.",
		"Although we may be a bunch of bandits, we look out for each other more than any organization. At least most of the time."
	]],
	["TRB", [
		"Ever heard of the Wagner Group? We're like them but less funded.",
		"We will own the wasteland, just you wait. If you do enough for us, we just might let you live in our world %1.",
		"It's a shame that the Russian Army doesn't support us, but at this point, we might be just as powerful as they are."
	]],
	["US", [
		"Everything we do here is confidential. Consider yourself lucky, %1, that we're letting you help us.",
		"There's a new mission for you, %1. Take it and leave. We'll be watching.",
		"Col. Castle has worked with people like you before. I just hope it doesn't end in the same way."
	]],
	["SU", [
		"What's up %1! Long time no see man.",
		"We got some new contracts for ya, %1. Nothing too bad except for a couple.",
		"I'm pretty sure Phil took my wet wipes from my bag. What a bastard. If you see him, give him a piece of my mind will ya, %1?",
		"GOD DAMN! It's too cold outside to day. I'd suggest wearing something warm for your contract.",
		"Just some friendly adivce. Never trust an Elk call out there in those woods, you will not find any alive Elk out there.",
		"Whatever you do, never go into an anomalous zone alone. Death sentence for sure, and never a quick one.",
		"Be careful going into faction controlled area. There are usually more bandits per town, and they usually don't take too kindly to strangers.",
		"If you ask me. Screw taking contracts, and just stay here for a few weeks. No need risking your life for some bucks."
	]],
	["RU", [
		"Добро пожаловать товарищ. Бери контракт и уходи.",
		"Добро пожаловать товарищ. Бери контракт и уходи, от тебя пахнет дерьмом %1.",
		"Добро пожаловать, товарищ, не стесняйтесь брать миссию. У нас много."
	]],
	["ROA", [
		"Keep everything in this room between you and me or suffer the consequences, %1.",
		"Take a contract and leave. No questions, %1.",
		"Take a mission and leave, we'll be watching. Always watching"
	]],
	["ALF", [
		"Mornin' survivor, or whatever the hell the time is.",
		"You trackin' that you're in ALF territory survivor? Awfully risky of ya %1",
		"Welcome to the office, %1. Ya know one day the ALF is going to own all of this? Just you wait, %1",
		"Take a contract, %1. Goodluck, anything we task out is something we don't want to handle."
	]],
	["WO", [
		"Guten Morgen, Überlebender. Nehmen Sie einen Vertrag für unseren Anführer an.",
		"Guten Tag, %1. Haben Sie darüber nachgedacht, wie großartig unser Anführer ist? Das habe ich auf jeden Fall. Heute schon bis zu 16 Mal",
		"Ein beschissener Tag draußen, nicht wahr? Zum Glück, dass du jetzt hier bist, %1,ist es noch schlimmer."
	]]
];

if (_faction isEqualTo "PMC") exitWith {
	systemChat format ["Greetings, survivor #%1. Come take a contract.", floor (random 1000)];
};

private _arr = _lines getOrDefault [_faction, []];
if (_arr isEqualTo []) exitWith {};

private _line = selectRandom _arr;
systemChat format [_line, name player];