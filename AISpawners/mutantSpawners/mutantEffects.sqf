params ["_faction","_player"];

[_faction, _player] spawn {
	params ["_faction","_player"];
	switch (_faction) do {
		case "411": {
			PBright = 1;
			PCon = 1;
			PColor = 0;
			PRGB = 1;
			PWhite = 1.1;
			PCDark = 0.4;
			PColorDark = 0.2;
			PRGBC = 0.5;
			
			while {((PBright < PWhite) or (PColor < PColorDark) or (PCon > PCDark) or (PRGB > PRGBC))} do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;
				
				if (PColor < PColorDark) then {
					PColor = PColor + 0.01;
				};
				
				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 1, 1, PRGB], [0.75, 0.25, 0, 1.0]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;
				
				if (PBright < PWhite) then {
					PBright = PBright + 0.005;
				};
				
				if (PCon > PCDark) then {
					PCon = PCon - 0.05;
				};
				
				if (PRGB > PRGBC) then {
					PRGB = PRGB - 0.1;
				};
				
				sleep 0.003;
			};
		};
		case "Abom": {
			PBright = 1;
			PCon = 1;
			PBrightC = 0.85;
			PConC = 0.3;
			
			while {((PBright > PBrightC) or (PCon > PConC))} do {
				"colorCorrections" ppEffectAdjust [PBright, PCon, -0.002, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.4, 0.6], [0.199, 0.587, 0.114, 0.0]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;
				
				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				
				if (PCon > PConC) then {
					PCon = PCon - 0.01;
				};
				
				sleep 0.001;
			};
		};
		case "Mind": {
			PColor = 0;
			while {PColor < 0.4} do {
				"ColorInversion" ppEffectAdjust [Pcolor, Pcolor, Pcolor]; 
				"ColorInversion" ppEffectEnable TRUE; 
				"ColorInversion" ppEffectCommit 0;
				PColor = PColor + 0.005;
				sleep 0.003;
			};
		};	
		case "Rake": {
			PBright = 1;
			PCon = 1;
			PColor = 0;
			PWhite = 1.6;
			PCDark = 0.5;
			PColorDark = 0.2;

			while {((PBright < PWhite) or (PColor < PColorDark) or (PCon > PCDark))} do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;

				if (PColor < PColorDark) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [1, 1, 1, 0], [1, 1, 1, 0.5], [0.75, 0.25, 0, 1.0]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright < PWhite) then {
					PBright = PBright + 0.0125;
				};

				if (PCon > PCDark) then {
					PCon = PCon - 0.00625;
				};

				sleep 0.003;
			};	
		};
		case "Shadow": {
			PBright = 1;
			PCon = 1;
			PRGB = 1;

			PBrightC = 0.60;
			PConC = 0.6;
			PR = 0.35;

			while {((PBright > PBrightC) or (PCon > PConC) or (PRGB > PR))} do {
				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.2, 0.2, 1.0, -0.1], [1, 1, 0.9, PRGB], [0.5, 0.3, 1.0, -0.1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.01;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.01;
				};

				sleep 0.001;
			};		
		};
		case "Snatch": {
			PBright = 1;
			PCon = 1;
			PRGB = 1;
			PColor = 0;
			PBrightC = 0.85;
			PConC = 0.7;
			PR = 0.3;
			PColorC = 0.2;

			while {((PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (PRGB > PR))} do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;
				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0, 0, 0, 0], [0, 0.5, 0, 0.7], [0.95, PRGB, PRGB, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;
				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};	
		};
		case "Statue": {
			PBright = 1;
			PCon = 1;
			PRGB = 1;
			PColor = 0;
			PBrightC = 0.80;
			PConC = 0.6;
			PR = 0.3;
			PColorC = 0.01;

			while {((PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (PRGB > PR))} do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;
				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.95, 0, 0, 0], [0.95, PRGB, PRGB, 0.5], [0.95, PRGB, PRGB, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;
				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};

			hint format ["A feeling of imminent death comes over %1", name player];		
		};
		case "Vamp": {
			PBright = 1;
			PCon = 1;
			PRGB = 1;

			PBrightC = 0.8;
			PConC = 0.8;
			PR = 0;

			while { (PBright > PBrightC) or (PCon > PConC) or (PRGB > PR) } do {
				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [1, 1, 1, 0], [1, 1, 1, PRGB], [0.75, 0.25, 0, 1.0]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.01;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.01;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};	
		};
		case "Various": {
			hint format ["A terrible feeling comes over %1", name _player];
			PBright = 1;
			PCon = 1;
			PRGB = 1;
			PColor = 0;

			PBrightC = 0.80;
			PConC = 0.6;
			PR = 0.3;
			PColorC = 0.01;

			while { (PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (PRGB > PR) } do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;

				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.95, 0, 0, 0], [0.95, PRGB, PRGB, 0.5], [0.95, PRGB, PRGB, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};	
		};
		case "Hellspawn": {
			hintSilent format ["An awful feeling of imminent dread comes over you, %1. You fear your time has come to an end...", name _player];
			PBright = 1;
			PCon = 1;
			PRGB = 1;
			PColor = 0;

			PBrightC = 0.80;
			PConC = 0.6;
			PR = 0.3;
			PColorC = 0.01;

			while { (PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (PRGB > PR) } do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;

				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.95, 0, 0, 0], [0.95, PRGB, PRGB, 0.5], [0.95, PRGB, PRGB, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};	
		};
		case "Goliath": {
			hintSilent format ["An unspeakable feeling of horror comes over you, %1. It is as if the personification of death awaits you nearby...", name _player];
			PBright = 1;
			PCon = 1;
			PRGB = 1;
			PColor = 0;

			PBrightC = 0.80;
			PConC = 0.6;
			PR = 0.3;
			PColorC = 0.01;

			while { (PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (PRGB > PR) } do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;

				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.95, 0, 0, 0], [0.95, PRGB, PRGB, 0.5], [0.95, PRGB, PRGB, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (PRGB > PR) then {
					PRGB = PRGB - 0.05;
				};

				sleep 0.001;
			};	
		};
		case "Wend": {
			PBright = 1;
			PBDark = 0.65;
			PCon = 1;
			PCDark = 0.45;

			while { PBright > PBDark or PCon > PCDark } do {
				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0, 0, 0, 1]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBDark) then {
					PBright = PBright - 0.01;
				};
				if (PCon > PCDark) then {
					PCon = PCon - 0.01;
				};

				sleep 0.001;
			};		
		};
		case "demon": {
			hint format ["A demonicly cold feeling comes over %1", name player];
			PBright = 1;
			PCon = 1;
			RED = 1;
			GREEN = 1;
			BLUE = 1;
			PColor = 0;

			PBrightC = 0.8;
			PConC = 0.8;
			REDC = .4;
			GREENC = .5;
			BLUEC = .8;
			PColorC = 0.01;

			while { (PBright > PBrightC) or (PColor < PColorC) or (PCon > PConC) or (RED > REDC) or (GREEN > GREENC) or (BLUE > BLUEC)} do {
				"ColorInversion" ppEffectAdjust [PColor, PColor, PColor];
				"ColorInversion" ppEffectEnable TRUE;
				"ColorInversion" ppEffectCommit 0;

				if (PColor < PColorC) then {
					PColor = PColor + 0.01;
				};

				"colorCorrections" ppEffectAdjust [PBright, PCon, 0, [0.95, 0, 0, 0], [RED, GREEN, BLUE, 0.5], [0.2, 0.5, 0.5, 0.0]];
				"colorCorrections" ppEffectEnable TRUE;
				"colorCorrections" ppEffectCommit 0;

				if (PBright > PBrightC) then {
					PBright = PBright - 0.0125;
				};
				if (PCon > PConC) then {
					PCon = PCon - 0.00625;
				};
				if (RED > REDC) then {
					RED = RED - 0.05;
				};
				if (GREEN > GREENC) then {
					GREEN = GREEN - 0.05;
				};
				if (BLUE > BLUEC) then {
					BLUE = BLUE - 0.05;
				};

				sleep 0.001;
			};	
			
		};
	};
};