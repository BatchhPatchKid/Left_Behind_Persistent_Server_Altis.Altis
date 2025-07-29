params ["_faction"];

if (_faction == "Bandit") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Yo what's up survivor. I'm suprised you're taking a job from me, %1. Hoepfully you're up to the task",(name player)]; };
	if (_rndConv == 1) then {hint format ["Nah man. You don't look strong enough for my missions. Take it at your risk, %1",(name player)]; };
	if (_rndConv == 2) then {hint format ["Whatchu lookin' at bub. Take the mission if you really want it"]; };
};	
if (_faction == "BB") then {
	_rndConv = floor (random 7);
	if (_rndConv == 0) then {hint format ["Yo what's up, %1. Glad to see you're here for a mission. We've got a surplus of them for sure.",(name player)]; };
	if (_rndConv == 1) then {hint format ["You ever think about how the gang just started from a couple of maniacs on Altis? Crazy when you think about it."]; };
	if (_rndConv == 2) then {hint format ["I heard the Russian Federation is in Livonia. I'd keep a look out for digital camo tents since that's what they primarily use.",(name player)]; };
	if (_rndConv == 3) then {hint format ["I've been hearing a lot more rumors about the US military taking action in the area. I'd keep your head on a swivel, %1, since they kill just about any survivor no matter how friendly due to something the Boonie Boys did years ago.",(name player)]; };
	if (_rndConv == 4) then {hint format ["If you ever get a task to help out some sheep farmers, please don't kill the sheep farmers. It'll further destroy our reputation with them."]; };
	if (_rndConv == 5) then {hint format ["You hear that we've moved our operations all the way out to Tanoa %1? New Horizion is pretty friendly there, too bad they're lunatics mostly everywhere else.",(name player)]; };
	if (_rndConv == 6) then {hint format ["I heard that the Boonie Boys leader is in town. Apparently he's on his way back to Altis. Absolutely insane idea considering how many nukes went off there just 9 years ago.",(name player)]; };
}; 
if (_faction == "DT") then {
	_rndConv = floor (random 8);
	if (_rndConv == 0) then {hint format ["Praise be Poseidon. Don't you agree %1?",(name player)]; };
	if (_rndConv == 1) then {hint format ["It's sad that our homeland of Altis was nuked 9 years ago. I heard a large team was getting ready to embark on a journey back there. I just hope I can join along, what about you, %1?",(name player)]; };
	if (_rndConv == 2) then {hint format ["Praise be Zeus. Too bad he can't give us electricty just for even a day"]; };
	if (_rndConv == 3) then {hint format ["Praise be Athena and her beauty. Just between you and me, I like to pray to her in my free time the most. What about you, %1?",(name player)]; };
	if (_rndConv == 4) then {hint format ["Praise be Hermes. Loved that guy on Futurama."]; };
	if (_rndConv == 5) then {hint format ["Praise be Ares. Just between you and me, %1, he's my favorite",(name player)]; };
	if (_rndConv == 6) then {hint format ["Praise be Hades"]; };
	if (_rndConv == 7) then {hint format ["Praise be Apollo"]; };
};
if (_faction == "NH") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Let nature decide who shall survive, that's all I gotta say."]; };
	if (_rndConv == 1) then {hint format ["Just between you and me, I just like this faction so I can wear a shemag. They look sick"]; };
	if (_rndConv == 2) then {hint format ["Praise be the apocalypse."]; };
	if (_rndConv == 3) then {hint format ["Praise be the Wanderer. Have you ever seen him %1? Sometimes I see him in my sleep.",(name player)]; };
};
if (_faction == "PF") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["GOD DAMN YOU LOOKIN' MIGHTY TASTY %1! I hope to god that you can fulfill your mission our we're having you for dinner.",(name player)]; };
	if (_rndConv == 1) then {hint format ["Damn I'm hungry. Maybe I should have Dave later. He was lookin' mighty weak on the last patrol."]; };
	if (_rndConv == 2) then {hint format ["You want a mission from us? Really?",(name player)]; };	
};
if (_faction == "RC") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["It's gonna take a lot of guts to complete one of our missions. I just hope you got the firepower %1.",(name player)]; };
	if (_rndConv == 1) then {hint format ["You know why we're called the Raven's Cloak %1? No idea, but it sounds cool.",(name player)]; };
	if (_rndConv == 2) then {hint format ["Just some free info for a warrior like you, %1, no PMC or military has their best interests for us. We got to look out for each other.",(name player)]; };
	if (_rndConv == 3) then {hint format ["Although we may be a bunch of bandits, we look out for each other more than any organization. At least most of the time.",(name player)]; };
};
if (_faction == "TRB") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Ever heard of the Wagner Group? We're like them but less funded."]; };
	if (_rndConv == 1) then {hint format ["We will own the wasteland, just you wait. If you do enough for us, we just might let you live in our world %1.",(name player)]; };
	if (_rndConv == 2) then {hint format ["It's a shame that the Russian Army doesn't support us, but at this point, we might be just as powerful as they are."]; };
};
if (_faction == "US") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Everything we do here is confidential. Consider yourself lucky, %1, that we're letting you help us.",(name player)]; };
	if (_rndConv == 1) then {hint format ["There's a new mission for you, %1. Take it and leave. We'll be watching.",(name player)]; };
	if (_rndConv == 2) then {hint format ["Col. Castle has worked with people like you before. I just hope it doesn't end in the same way.",(name player)]; };
};
if (_faction == "SU") then {
	_rndConv = floor (random 8);
	if (_rndConv == 0) then {hint format ["What's up %1! Long time no see man.",(name player)]; };
	if (_rndConv == 1) then {hint format ["We got some new contracts for ya, %1. Nothing too bad except for a couple.",(name player)]; };
	if (_rndConv == 2) then {hint format ["I'm pretty sure Phil took my wet wipes from my bag. What a bastard. If you see him, give him a piece of my mind will ya, %1?",(name player)]; };
	if (_rndConv == 3) then {hint format ["GOD DAMN! It's too cold outside to day. I'd suggest wearing something warm for your contract."]; };
	if (_rndConv == 4) then {hint format ["Just some friendly adivce. Never trust an Elk call out there in those woods, you will not find any alive Elk out there."]; };
	if (_rndConv == 5) then {hint format ["Whatever you do, never go into an anomalous zone alone. Death sentence for sure, and never a quick one."]; };
	if (_rndConv == 6) then {hint format ["Be careful going into faction controlled area. There are usually more bandits per town, and they usually don't take too kindly to strangers."]; };
	if (_rndConv == 7) then {hint format ["If you ask me. Screw taking contracts, and just stay here for a few weeks. No need risking your life for some bucks."]; };
};
if (_faction == "RU") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Добро пожаловать товарищ. Бери контракт и уходи."]; };
	if (_rndConv == 1) then {hint format ["Добро пожаловать товарищ. Бери контракт и уходи, от тебя пахнет дерьмом %1.",(name player)]; };
	if (_rndConv == 2) then {hint format ["Добро пожаловать, товарищ, не стесняйтесь брать миссию. У нас много."]; };
};
if (_faction == "ROA") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Keep everything in this room between you and me or suffer the consequences, %1.",(name player)]; };
	if (_rndConv == 1) then {hint format ["Take a contract and leave. No questions, %1.",(name player)]; };
	if (_rndConv == 2) then {hint format ["Take a mission and leave, we'll be watching. Always watching"]; };
};
if (_faction == "PMC") then {
	hint format ["Greetings, survivor #%1. Come take a contract.",(random 1000)];
};
if (_faction == "ALF") then {
	_rndConv = floor (random 4);
	if (_rndConv == 0) then {hint format ["Mornin' survivor, or whatever the hell the time is.",(name player)];};
	if (_rndConv == 1) then {hint format ["You trackin' that you're in ALF territory survivor? Awfully risky of ya %1",(name player)]; };
	if (_rndConv == 2) then {hint format ["Welcome to the office, %1. Ya know one day the ALF is going to own all of this? Just you wait, %1",(name player)]; };
	if (_rndConv == 3) then {hint format ["Take a contract, %1. Goodluck, anything we task out is something we don't want to handle.",(name player)]; };
};
if (_faction == "WO") then {
	_rndConv = floor (random 3);
	if (_rndConv == 0) then {hint format ["Guten Morgen, Überlebender. Nehmen Sie einen Vertrag für unseren Anführer an.",(name player)];};
	if (_rndConv == 1) then {hint format ["Guten Tag, %1. Haben Sie darüber nachgedacht, wie großartig unser Anführer ist? Das habe ich auf jeden Fall. Heute schon bis zu 16 Mal",(name player)]; };
	if (_rndConv == 2) then {hint format ["Ein beschissener Tag draußen, nicht wahr? Zum Glück, dass du jetzt hier bist, %1,ist es noch schlimmer.",(name player)]; };
};