DP = {}





DP.Categories = {
    {name = 'rozmowa', label = '💬 Rozmowa'},
    {name = 'siedzenie', label = '🪑 Siedzenie', sub = {
        {name = 'siedzenie1', label = '🪑 Siedzenie na ziemi'},
        {name = 'siedzenie2', label = '🧎 Siedzenie na krześle'},
    }},
    {name = 'reakcja', label = '🤯 Reakcje'},
    {name = 'opieranie', label = '✋ Opieranie'},
    {name = 'lezenie', label = '🛏️ Leżenie'},
    {name = 'stanie', label = '🧍 Stanie'},
    {name = 'prace', label = '💼 Prace', sub = {
        {name = 'police', label = '👮 Policyjne'},
        {name = 'medyczne', label = '👨‍⚕️ Medyczne'},
        {name = 'mechanik', label = '🔧 Mechanik'},
    }},
    {name = 'sport', label = '🥊 Sport'},
    {name = 'taniec', label = '🕺 Tańce'},
    {name = 'innekate', label = '❔ Inne', sub = {
        {name = 'inne', label = '➕ Pozostałe'},
        {name = 'gangi', label = '🎭 Gangi'},
        {name = 'przedmioty', label = '📌 Przedmioty'},
        {name = 'pojazd', label = '🚗 Pojazdy'},
        {name = '+18', label = '<font color="#FF0000">+18</font>'},
    }},
}

DP.Expressions = {
   ["Zły"] = {"Expression", "mood_angry_1"},
   ["Pijany"] = {"Expression", "mood_drunk_1"},
   ["Oniemiały"] = {"Expression", "pose_injured_1"},
   ["Porażony"] = {"Expression", "electrocuted_1"},
   ["Naburmuszony"] = {"Expression", "effort_1"},
   ["Naburmuszony2"] = {"Expression", "mood_drivefast_1"},
   ["Naburmuszony3"] = {"Expression", "pose_angry_1"},
   ["Wesoły"] = {"Expression", "mood_happy_1"},
   ["Kontuzjowany"] = {"Expression", "mood_injured_1"},
   ["Radosny"] = {"Expression", "mood_dancing_low_1"},
   ["Otwarte usta"] = {"Expression", "smoking_hold_1"},
   ["Nie mruga"] = {"Expression", "pose_normal_1"},
   ["Przymknięte oko"] = {"Expression", "pose_aiming_1"},
   ["Zszokowany"] = {"Expression", "shocked_1"},
   ["Zszokowany2"] = {"Expression", "shocked_2"},
   ["Sen"] = {"Expression", "mood_sleeping_1"},
   ["Sen2"] = {"Expression", "dead_1"},
   ["Sen3"] = {"Expression", "dead_2"},
   ["Zadowolony"] = {"Expression", "mood_smug_1"},
   ["Podejrzliwy"] = {"Expression", "mood_aiming_1"},
   ["Zestresowany"] = {"Expression", "mood_stressed_1"},
   ["Foch"] = {"Expression", "mood_sulk_1"},
   ["Dziwak"] = {"Expression", "effort_2"},
   ["Dziwak2"] = {"Expression", "effort_3"},
}

DP.Walks = {
	["Ranny"] = {"move_m@injured"},
  ["Przychlast"] = {"move_m@alien"},
  ["Opancerzony"] = {"anim_group_move_ballistic"},
  ["Arogancka"] = {"move_f@arrogant@a"},
  ["Odważny"] = {"move_m@brave"},
  ["Codzienny"] = {"move_m@casual@a"},
  ["Codzienny2"] = {"move_m@casual@b"},
  ["Codzienny3"] = {"move_m@casual@c"},
  ["Codzienny4"] = {"move_m@casual@d"},
  ["Codzienny5"] = {"move_m@casual@e"},
  ["Codzienny6"] = {"move_m@casual@f"},
  ["Pretensjonalny"] = {"move_f@chichi"},
  ["Pewny"] = {"move_m@confident"},
  ["Glina"] = {"move_m@business@a"},
  ["Glina2"] = {"move_m@business@b"},
  ["Glina3"] = {"move_m@business@c"},
  ["Pijany"] = {"move_m@drunk@a"},
  ["Pijany2"] = {"move_m@drunk@slightlydrunk"},
  ["Pijany3"] = {"move_m@buzzed"},
  ["Pijany4"] = {"move_m@drunk@verydrunk"},
  ["Kobieca"] = {"move_f@femme@"},
  ["Kozaczek"] = {"move_characters@franklin@fire"},
  ["Kozaczek2"] = {"move_characters@michael@fire"},
  ["Kozaczek3"] = {"move_m@fire"},
  ["Pośpiech"] = {"move_f@flee@a"},
  ["Gangster"] = {"move_p_m_one"},
  ["Gangster1"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["W rytm"] = {"anim@move_m@grooving@"},
  ["Strażnik"] = {"move_m@prison_gaurd"},
  ["Zakuty"] = {"move_m@prisoner_cuffed"},
  ["Obcas"] = {"move_f@heels@c"},
  ["Obcas2"] = {"move_f@heels@d"},
  ["Wędrowca"] = {"move_m@hiking"},
  ["Hipis"] = {"move_m@hipster@a"},
  ["żul"] = {"move_m@hobo@a"},
  ["Pośpiech2"] = {"move_f@hurry@a"},
  ["Woźny"] = {"move_p_m_zero_janitor"},
  ["Woźny2"] = {"move_p_m_zero_slow"},
  ["Trucht"] = {"move_m@jog@"},
  ["Gangster6"] = {"anim_group_move_lemar_alley"},
  ["Laska"] = {"move_heist_lester"},
  ["Laska2"] = {"move_lester_caneup"},
  ["Przychlast2"] = {"move_f@maneater"},
  ["Szef"] = {"move_ped_bucket"},
  ["Flexin"] = {"move_m@money"},
  ["Ochroniarz"] = {"move_m@muscle@a"},
  ["Biznesman"] = {"move_m@posh@"},
  ["Bizneswoman"] = {"move_f@posh@"},
  ["Pośpiech3"] = {"move_m@quick"},
  ["Biegacz"] = {"female_fast_runner"},
  ["Smutny"] = {"move_m@sad@a"},
  ["Arogancki"] = {"move_m@sassy"},
  ["Arogancka2"] = {"move_f@sassy"},
  ["Przestraszona"] = {"move_f@scared"},
  ["Kobieca2"] = {"move_f@sexy@a"},
  ["Pewny2"] = {"move_m@shadyped@a"},
  ["Powolny"] = {"move_characters@jimmy@slow@"},
  ["Flexin2"] = {"move_m@swagger"},
  ["Kozaczek4"] = {"move_m@tough_guy@"},
  ["Twarda"] = {"move_f@tough_guy@"},
  ["Smieci"] = {"clipset@move@trash_fast_turn"},
  ["Smieci2"] = {"missfbi4prepp1_garbageman"},
  ["Pewny3"] = {"move_p_m_two"},
  ["Szeroki"] = {"move_m@bag"},
      -- NOWE
      ["Powolny2"] = {"MOVE_P_M_ZERO_SLOW"},
      ["Wedrownik"] = {"move_m@hiking"},
      ["Rzeznik"] = {"move_m@hurry_butch@b"},
      ["Rzeznik2"] = {"move_m@hurry_butch@c"},
      ["Smutny2"] = {"move_m@sad@b"},
      ["Smutny3"] = {"move_m@sad@c"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["zolwik5"] = {"anim@mp_player_intcelebrationpaired@m_m_fist_bump", "fist_bump_right", "zolwik3", "zolwik6", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.9,
       headingOffset =  90.1
   }},
   ["zolwik6"] = {"anim@mp_player_intcelebrationpaired@m_m_fist_bump", "fist_bump_left", "zolwik3", "zolwik5", AnimationOptions =

   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.9,
       headingOffset =  90.1
   }},
   	["zolwik3"] = {"anim@mp_player_intcelebrationpaired@f_m_fist_bump", "fist_bump_right", "zolwik2", "zolwik4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.9,
       headingOffset =  90.1
   }},
   ["zolwik4"] = {"anim@mp_player_intcelebrationpaired@f_m_fist_bump", "fist_bump_left", "zolwik 4", "zolwik3", AnimationOptions =

   {
       EmoteMoving = false,
       EmoteLoop = false,
       SyncOffsetFront = 1.5
   }},
   	["zolwik"] = {"anim@mp_player_intcelebrationpaired@f_f_fist_bump", "fist_bump_right", "zolwik", "zolwik2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = false,
       SyncOffsetFront = 0.9,
         headingOffset =  140.1
   }},
   ["zolwik2"] = {"anim@mp_player_intcelebrationpaired@f_f_fist_bump", "fist_bump_left", "zolwik", "zolwik", AnimationOptions =

   {
       EmoteMoving = false,
       EmoteLoop = false,
       SyncOffsetFront = 0.75,
       headingOffset =  -70.1
   }},




   ["uscisk"] = {"mp_ped_interaction", "handshake_guy_a", "Uścisk", "uscisk2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["uscisk2"] = {"mp_ped_interaction", "handshake_guy_b", "Uścisk 2", "uscisk", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 3000
   }},
   ["przytulas"] = {"mp_ped_interaction", "kisses_guy_a", "Przytulas", "przytulas2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["przytulas2"] = {"mp_ped_interaction", "kisses_guy_b", "Przytulas 2", "przytulas", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bracie"] = {"mp_ped_interaction", "hugs_guy_a", "Bracie", "bracie2", AnimationOptions =
   {
    EmoteMoving = false,
        SyncOffsetFront = 1.14
   }},
   ["bracie2"] = {"mp_ped_interaction", "hugs_guy_b", "Bracie 2", "bracie", AnimationOptions =
   {
    EmoteMoving = false,
        SyncOffsetFront = 1.14
   }},
     ["oral"] = {"misscarsteal2pimpsex", "pimpsex_punter", "Oral", "oral2", category = {'+18'}, AnimationOptions =
   {
    EmoteMoving = false,
    EmoteLoop = true,
        SyncOffsetFront = 0.3,
        headingOffset =  180.1
   }},
   ["oral2"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Oral 2", "oral", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteLoop = true,
        SyncOffsetFront = 0.3,
        headingOffset =  180.1
   }},
   ["nastojaka"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Seks na stojąco", "nastojaka2", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteLoop = true,
        SyncOffsetFront = 0.3,
        headingOffset =  180.1
   }},
   ["nastojaka2"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Seks na stojąco 2", "nastojaka", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteLoop = true,
        SyncOffsetFront = 0.3,
        headingOffset =  180.1
   }},


   ["podaj"] = {"mp_common", "givetake1_a", "Podaj", "podaj2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 2000
   }},
   ["podaj2"] = {"mp_common", "givetake1_b", "Podaj 2", "podaj", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "rzutbaseball"},
   ["rzutbaseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Rzut Baseball", "baseball"},
   ["napad"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Napad", "napadniety", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["napadniety"] = {"missminuteman_1ig_2", "handsup_base", "Napadnięty", "napad", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["uderz"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Uderz", "uderzony"},
   ["uderzony"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Uderzony", "uderz"},
   ["glowka"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Główka", "uderzonyglowa"},
   ["uderzonyglowa"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Uderzony głową", "glowka"},
   ["Lep2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Lep 2", "uderzonyzlepa2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["lep"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Lep", "uderzonyzlepa", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["uderzonyzlepa"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Uderzony z lepa", "lep"},
   ["uderzonyzlepa2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Uderzony z lepa 2", "lep2"},
}

DP.Dances = {
    ["drill"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "mi_dance_prop_13_v1_male^3", "Taniec Drill · Male", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill2"] = {"anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", "mi_dance_crowd_13_v2_male^1", "Taniec Drill · Male 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill3"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_17_v2_male^4", "Taniec Drill · Male 3", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill4"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_15_v2_male^4", "Taniec Drill · Male 4",category = {'taniec'}, AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill5"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_15_v2_male^5", "Taniec Drill · Male 5",category = {'taniec'}, AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill6"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_17_male^5", "Taniec Drill · Male 6", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill7"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_up", "Taniec Drill · Solo 1", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill8"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "med_center", "Taniec Drill · Solo 2", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill9"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_down", "Taniec Drill · Solo 3", category = {'taniec'},AnimationOptions =
    {
        EmoteLoop = true,
    }}, 
    ["drill10"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_center", "Taniec Drill · Solo 4",category = {'taniec'}, AnimationOptions =
    {
         EmoteLoop = true,
    }}, 
    ["drill11"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_left_down", "Taniec Taniec Drill · Solo 5", category = {'taniec'}, AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
 
    ["monkeydance"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "high_center", "Monkey Dance ", category = {'taniec'}, AnimationOptions =
    {
        EmoteLoop = true
     }},
     ["monkeydance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "high_center_down", "Monkey Dance 2 ", category = {'taniec'},AnimationOptions =
     {
         EmoteLoop = true
      }},
      ["monkeydance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "med_center_down", "Monkey Dance 3 ", category = {'taniec'},AnimationOptions =
      {
          EmoteLoop = true
       }},
     ["rightdowndance"] = {"anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", "med_right_down", "Right Down Dance Solo ", category = {'taniec'},AnimationOptions =
     {
         EmoteLoop = true
      }},
      ["lowdance"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "low_center", "Low Dance · Female ", category = {'taniec'},AnimationOptions =
     {
         EmoteLoop = true
        }},
        ["lowdance2"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "high_center", "Low Dance · Female", category = {'taniec'},AnimationOptions =
        {
         EmoteLoop = true
         }},
        ["hiphop"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_d@", "ped_a_dance_idle", "Hip Hop Dance", category = {'taniec'},AnimationOptions =
         {
            EmoteLoop = true
         }},
        ["hiphop2"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_b@", "ped_a_dance_idle", "Hip Hop Dance", category = {'taniec'},AnimationOptions =
        {
            EmoteLoop = true
          }},
         ["hiphop3"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_a@", "ped_a_dance_idle", "Hip Hop Dance", category = {'taniec'},AnimationOptions =
         {
            EmoteLoop = true
         }},





   ["tanieck"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Taniec K", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieck2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Taniec K2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieck3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Taniec K3", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecrapsy"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_down", "Rapsy", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieck4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Taniec K4", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["tanieck5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Taniec K5", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieck6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Taniec K6", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieczabawa"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@", "trans_dance_crowd_hi_to_mi_09_v1_female^1", "Taniec Zabawa", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecwczuta"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@", "trans_dance_crowd_hi_to_mi_09_v1_female^6", "Taniec Wczuta", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecwixa"] = {"special_ped@mountain_dancer@monologue_2@monologue_2a", "danceidle_hi_11_buttwiggle_b_laz", "Taniec Wixa", category = {'taniec'}, AnimationOptions =
   {
   }},
   ["taniecwixa2"] = {"anim@amb@nightclub@lazlow@hi_podium@", "mnt_dnc_angel", "Taniec Wixa 2", category = {'taniec'}, AnimationOptions =
   {
   }},
   ["wolnytaniec2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Wolny taniec 2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wolnytaniec3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Wolny taniec 3", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wolnytaniec4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Wolny taniec 4", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Taniec", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Taniec 2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Taniec 3", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Taniec 4", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecsnake"] = {"anim@mp_player_intcelebrationmale@find_the_fish", "find_the_fish", "Taniec Snake 1", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecgora"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Taniec góra", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["taniecgora2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Taniec góra 2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["taniecniesmialy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Taniec nieśmiały", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecniesmialy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Taniec nieśmiały 2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rura"] = {"mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", "Taniec na rurze", category = {'taniec', '+18'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wolnytaniec"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Wolny taniec", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Luźny taniec 9", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Taniec 6", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Taniec 7", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec8"] = {"missfbi3_sniping", "dance_m_default", "Taniec 8", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Luźny taniec", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Luźny taniec 2", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Luźny taniec 3", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Luźny taniec 4", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecjakis"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_06_base_laz", "Taniec", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecrobot"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_15_robot_laz", "Taniec Robot", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieckrectym"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_17_smackthat_laz", "Taniec Kręć tym mała", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Luźny taniec 5", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Luźny taniec 6", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniec9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Taniec 9", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tanieckurczaka"] = {"anim@mp_player_intcelebrationfemale@chicken_taunt", "chicken_taunt", "Taniec Kurczaka", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["luznytaniec8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Luźny taniec 8", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["luznytaniec7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Luźny taniec 7", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["taniec5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Taniec 5", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["tanieczeswietlikiem"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Taniec ze świetlikiem", category = {'taniec'}, AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["tanieczeswietlikiem2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Taniec ze świetlikiem 2", category = {'taniec'}, AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["tanieczeswietlikiem3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Taniec ze świetlikiem 3", category = {'taniec'}, AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["tanieczkoniem"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Taniec z koniem na kiju", category = {'taniec'}, AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tanieczkoniem2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Taniec z koniem na kiju 2", category = {'taniec'}, AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["tanieczkoniem3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Taniec z koniem na kiju 3", category = {'taniec'}, AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
    ["reakcja"] = {"random@shop_robbery_reactions@", "absolutely", "Reakcja Absolutnie",  category = {'reakcja'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1000,
    }},
    ["reakcja2"] = {"random@shop_robbery_reactions@", "anger_a",  category = {'reakcja'},"Reakcja Zły", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1000,
    }},
    ["reakcja3"] = {"random@shop_robbery_reactions@", "is_this_it",  category = {'reakcja'},"Reaction Co?", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["reakcja4"] = {"random@shop_robbery_reactions@", "screw_you",  category = {'reakcja'},"Reakcja Pierdol Sie", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1250,
    }},
    ["reakcja5"] = {"random@shop_robbery_reactions@", "shock",  category = {'reakcja'},"Reaction Ile?", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2000,
    }},
    ["niesmialy"] = {"missclothing", "good_choice_storeclerk",  category = {'stanie'},"Niesmialy", AnimationOptions =
    {
     EmoteMoving = true
    }},
    ["przymierzanie4"] = {"clothingtie", "try_tie_neutral_c",  category = {'stanie'},"Przymierzanie Ciuchów 4", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["przymierzanie5"] = {"clothingtie", "try_tie_neutral_d",  category = {'stanie'},"Przymierzanie Ciuchów 5", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["spokojnie"] = {"gestures@m@car@std@casual@ds", "gesture_easy_now",  category = {'reakcja'},"Spokojnie", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["reakcja6"] = {"gestures@m@car@std@casual@ds", "gesture_i_will",  category = {'reakcja'},"Reakcja Ja zrobię", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["nie4"] = {"gestures@m@car@std@casual@ds", "gesture_no_way", category = {'rozmowa'}, "Nie 4", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["bye"] = {"gestures@f@standing@casual", "gesture_bye_hard",  category = {'rozmowa'},"Bye", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1250,
    }},
    ["hello"] = {"gestures@f@standing@casual", "gesture_hello",  category = {'rozmowa'},"Hello", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1500,
    }},
      ["reakcja7"] = {"mp_cp_welcome_tutgreet", "greet",  category = {'reakcja'},"Reakcja Super!", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["fakepunch"] = {"missarmenian2", "fake_punch_walk_by_lamar",  category = {'gangi'},"Fake Punch", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 5000,
    }},
       ["nie5"] = {"missheist_jewel", "damn",  category = {'rozmowa'},"Nie 5", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1000,
    }},
      ["reakcja8"] = {"missheist_jewel", "im_telling_you",  category = {'reakcja'},"Reakcja Mowie Ci!", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1000,
    }},
    ["nie6"] = {"missheist_jewel", "despair",  category = {'rozmowa'},"Nie 6", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1000,
    }},
    ["poddanie2"] = {"missheist_jewel", "manageress_kneel_loop", category = {'inne', 'gangi'}, "Poddanie 2", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["bangbang"] = {"anim@mp_player_intcelebrationfemale@bang_bang", category = {'inne', 'gangi'},"bang_bang", "Bang Bang", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
       ["buty"] = {"clothingshoes", "try_shoes_positive_d", category = {'stanie'},"Przymierzanie Butów", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
     ["buty2"] = {"clothingshoes", "try_shoes_positive_c", category = {'stanie'},"Przymierzanie Butów 2", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},

     ["mycietwarzy"] = {"missmic2_washing_face", "michael_washing_face", category = {'stanie'},"Mycie Twarzy", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 5000,
    }},
     ["poddanie3"] = {"misstrevor1", "ortega_outro_loop_ort", category = {'inne', 'gangi'},"Poddanie · Ostatni dzien", AnimationOptions =
    {
     EmoteLoop = true,
    }},
     ["podnies"] = {"pickup_object", "pickup_low", category = {'inne'},"Podnieś", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["rozciaganie5"] = {"switch@franklin@bed", "stretch_long", category = {'sport'},"Rozciaganie 5", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["zbieraniesie"] = {"switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit", category = {'inne'},"Getting Ready", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["buty3"] = {"move_clown@p_m_two_idles@", "fidget_look_at_outfit", category = {'stanie'},"Przymierzanie Butów 3", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 6000,
    }},
    ["sranie"] = {"switch@trevor@on_toilet", "trev_on_toilet_loop", category = {'inne'},"Sranie", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 5000,
    }},
    ["sranie2"] = {"timetable@trevor@on_the_toilet", "trevonlav_struggleloop", category = {'inne'},"Sranie 2", AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 5000,
    }},
    ["poddanie4"] = {"amb@code_human_cower@male@base", "base", category = {'inne', 'gangi'},"Poddanie 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tylrece2"] = {"anim@amb@world_human_valet@formal_right@base@", category = {'inne'},"base_a_m_y_vinewood_01", "Ręce z tyłu 2", AnimationOptions =
    {
     EmoteMoving = true,
     EmoteLoop = true,
    }},
    ["lezeniebrzuch"] = {"amb@world_human_sunbathe@male@front@base", "base", category = {'lezenie'},"Leżenie na brzuchu", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["rece10"] = {"anim@scripted@carmeet@tun_meet_ig2_race@", "base", category = {'stanie'},"Ręce 10", AnimationOptions =
    {
        EmoteLoop = true,
        AllowedInCar = true,
        EmoteMoving = true,
    }},
    ["kucanie3"] = {"anim@amb@carmeet@checkout_car@male_a@idles", "idle_b", category = {'inne'},"Kucanie 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["zerkanie"] = {"anim@amb@carmeet@checkout_car@male_c@idles", "idle_a", category = {'rozmowa'},"Zerkanie", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["kucanie4"] = {"anim@amb@carmeet@checkout_car@female_d@base", "base", "Kucanie 4", category = {'inne'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["telpisanie2"] = {"anim@amb@carmeet@take_photos@male_a@base", "base", category = {'inne'},"Pisanie na telefonie 2", AnimationOptions =
    {
        EmoteMoving = false,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["telpisanie3"] = {"anim@amb@carmeet@take_photos@female_b@base", "base", category = {'inne'},"Pisanie na telefonie 3", AnimationOptions =
    {
        EmoteMoving = false,  
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},

    ["jogging"] = {"move_f@jogger", "idle", "Jogging",category = {'sport'}, AnimationOptions =
    {
        EmoteDuration = 2500,
        EmoteMoving = true,
    }},
    ["reakcja9"] = {"mini@triathlon", "wot_the_fuck", "Reakcja WTF",category = {'reakcja'}, AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["reakcja10"] = {"mini@triathlon", "u_cant_do_that", "Reakcja Nie Ma Szans", category = {'reakcja'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 1500,
    }},
    ["rozgrzewka2"] = {"mini@triathlon", "ig_2_gen_warmup_01", "Rozgrzewka 2",category = {'sport'}, AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
    }},
    ["rozgrzewka3"] = {"mini@triathlon", "ig_2_gen_warmup_02", "Rozgrzewka 3", category = {'sport'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
    }},
    ["rozgrzewka4"] = {"mini@triathlon", "jog_idle_f", "Rozgrzewka 4",category = {'sport'}, AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
    }},
    ["rozgrzewka5"] = {"mini@triathlon", "jog_idle_e", "Rozgrzewka 5",category = {'sport'}, AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
    }},
    ["rko3"] = {"missheistfbi3b_ig8_2", "cpr_loop_paramedic", "RKO 3", category = {'medyczne', 'inne'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["nieprzytomny6"] = {"missheistfbi3b_ig8_2", "cower_loop_victim", "Nieprzytomny 6", category = {'medyczne', 'lezenie'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drugdealer"] = {"amb@world_human_drug_dealer_hard@male@base", "base", "Drug Dealer", category = {'rozmowa','stanie'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["doping2"] = {"amb@world_human_strip_watch_stand@male_c@idle_a", "idle_b", "Doping 2", category = {'sport','rozmowa'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sprawdzanie2"] = {"amb@world_human_bum_wash@male@high@base", "base", "Sprawdzanie 2", category = {'police'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
    }},
    ["reakcja11"] = {"oddjobs@towingpleadingbase", "base", "Reakcja No Way", category = {'reakcja'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["reakcja12"] = {"oddjobs@bailbond_hobohang_out_street_c", "idle_c", "Reakcja Tell Something", category = {'reakcja'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["rozgladaniesie2"] = {"oddjobs@assassinate@old_lady", "looking_for_help", "Rozgladanie sie 2", category = {'inne'},AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 5000,
    }},
    ["lokiec4"] = {"anim@veh@lowrider@std@ds@arm@music@hiphopidle_a", "idle", "Lokiec 4", category = {'pojazd'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteLoop = true,
     AllowedInCar = true
    }},
    ["siedzenie10"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Smutne siedzenie 10", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lopata"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Łopata", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        Prop = 'prop_tool_shovel006',
        PropBone = 28422,
        PropPlacement = {0.0, 0.1, -0.6, 0.0, 0.0, 180.0},
    }},
    ["kucanie5"] = {"missheistdockssetup1ig_10@base", "talk_pipe_base_worker1", "Kucanie 5", category = {'siedzenie2'},AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["kucanie6"] = {"anim@amb@drug_field_workers@weeding@male_a@base", "base", "Kucanie 6", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},

    ["picie2"] = {"amb@world_human_drinking_fat@beer@male@base", "base", "Picie 2", category = {'inne'},AnimationOptions =
    {
        Prop = 'prop_cs_beer_bot_40oz_03',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["telopieranie"] = {"amb@world_human_leaning@male@wall@back@mobile@base", "base", "Opieranie z telefonem", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    }},
    ["dzieki"] = {"random@arrests", "thanks_male_05", "Dzięki", category = {'reakcja'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["telpisanie4"] = {"amb@world_human_stand_mobile_fat@male@text@base", "base", "Pisanie na telefonie 4", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    }},
    ["zapinanie"] = {"timetable@trevor@skull_loving_bear", "skull_loving_bear", "Jebanie od tyłu", category = {'+18'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["krzeslo7"] = {"timetable@reunited@ig_10", "isthisthebest_jimmy", "Krzesło 7", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["krzeslo8"] = {"timetable@michael@on_sofabase", "sit_sofa_base", "Krzesło 8", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["krzeslo9"] = {"timetable@trevor@smoking_meth@base", "base", "Krzesło 9", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["zgon"] = {"timetable@tracy@ig_7@base", "base", "Zgon", category = {'siedzenie2'},AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["stanie12"] = {"amb@world_human_bum_standing@twitchy@base", "base", "Stanie 12", category = {'stanie'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
    }},
 
    ["stanie13"] = {"anim@amb@casino@hangout@ped_male@stand@03b@base", "base", "Stanie 13", category = {'stanie'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
    }},






    
    ["pudlo2"] = {"mp_am_hold_up", "purchase_beerbox_shopkeeper", "Pudlo 2", category = {'przedmioty'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 2500,
    }},
    ["detektyw"] = {"amb@code_human_police_investigate@idle_b", "idle_f", "Detektyw", category = {'police', 'stanie'},AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 7000,
    }},

    ["zegarek2"] = {"amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", "Check Watch · Male", category = {'stanie'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1250,
    }},
    ["zbieranie"] = {"amb@prop_human_movie_bulb@idle_a", "idle_a", "Zbieranie", category = {'police', 'stanie'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2500,
    }},
    ["gangaim"] = {"combat@aim_variations@1h@gang", "aim_variation_b", "Celowanie · Gang", category = {'gangi'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
    }},
    ["cycki"] = {"mini@strip_club@backroom@", "stripper_b_backroom_idle_b", "Cycki", category = {'+18'},AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 6000,
    }},
    ["czyszczenie nogi"] = {"mini@strip_club@backroom@", "stripper_c_leadin_backroom_idle_a", "Czyszczenie Nogi", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 6000,
    }},

    
    ["cycki2"] = {"mini@strip_club@idles@stripper", "stripper_idle_05", "Cycki 2", category = {'+18'},AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 6000,
    }},
    ["selfie5"] = {"cellphone@self", "selfie", "Selfie 5", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["selfie6"] = {"cellphone@self@franklin@", "west_coast", "Selfie 6", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["selfie3"] = {"cellphone@self@michael@", "finger_point", "Selfie 3", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["selfie4"] = {"cellphone@self@franklin@", "chest_bump", "Selfie 4", category = {'inne'},AnimationOptions =
    {
        EmoteMoving = true,
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["selfie"] = {"cellphone@self@trevor@", "throat_slit", "Selfie", category = {'inne'},AnimationOptions =
    {
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["selfie2"] = {"cellphone@self@trevor@", "proud_finger", "Selfie 2", category = {'inne'},AnimationOptions =
    {
        Prop = "prop_npc_phone_02",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["oob2"] = {"rcmfanatic3leadinoutef_3_mcs_1", "fra_outofbreath_loop", "Zmeczony 2", category = {'stanie'},AnimationOptions =
    {
     EmoteMoving = false,
     EmoteDuration = 2500,
    }},
    ["damn3"] = {"misscommon@response", "damn", "Damn 3", category = {'rozmowa'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteDuration = 2500,
    }},
    ["klotnia5"] = {"missarmenian3@simeon_tauntsidle_b", "areyounotman", "Klotnia 5", category = {'rozmowa'},AnimationOptions =
    {
     EmoteMoving = true,
     EmoteLoop = true,
    }},
    ["carsign"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@bodhi@rds@base", "idle_a", "Gang Sign · Car", category = {'gangi'},AnimationOptions =
    {
        EmoteMoving = true,
        AllowedInCar = true,
        EmoteDuration = 2500,
    }},
    ["carsign2"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@low@ds@base", "idle_a", "Gang Sign 2 · Car", category = {'gangi'},AnimationOptions =
    {
        EmoteMoving = true,
        AllowedInCar = true,
        EmoteDuration = 2500,
    }},
    ["carlowrider"] = {"anim@veh@lowrider@std@ds@arm@music@mexicanidle_a", "idle", "Lowrider · Car ", category = {'gangi'},AnimationOptions =
    {
        EmoteMoving = true,
        AllowedInCar = true,
        EmoteLoop = true,
    }},
    ["mycierak"] = {"missheist_agency3aig_23", "urinal_sink_loop", "Mycie rąk", category = {'stanie'},AnimationOptions =
    {
     EmoteMoving = true,
    }},





   ["picie"] = {"mp_player_inteat@pnq", "loop", "Picie", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   -- NOWE ANIMACJE
   ["tylrece"] = {"anim@miss@low@fin@vagos@", "idle_ped06", "Ręce do tyłu", category = {'stanie'}, category = {'stanie'}, AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
    }},
    ["zegarek"] = {"oddjobs@taxi@", "idle_a", "Zerkanie na zegarek", category = {'stanie'}, AnimationOptions =
     {
        AllowedInCar = true,
        EmoteDuration = 5000,
         EmoteMoving = true,
     }},
   ["schowek"] = {"rcmme_amanda1", "drive_mic", "Sięganie do schowka w aucie", category = {'pojazd'}, AnimationOptions =
     {
        AllowedInCar = true,
         EmoteMoving = true,
     }},
 
     ["oddawaj"] = {"mini@prostitutespimp_demands_money", "pimp_demands_money_pimp", "Oddawaj pieniądze", Aategory = {'stanie', 'inne'}, AnimationOptions =
         {
             EmoteMoving = true,
             EmoteLoop = true,
         }},
 
         ["prysznic"] = {"mp_safehouseshower@female@", "shower_idle_a", "Prysznic 1", category = {'stanie'}, category = {'stanie'}, AnimationOptions =
         {
             EmoteMoving = true,
             EmoteLoop = true,
         }},
         ["prysznic2"] = {"mp_safehouseshower@male@", "male_shower_idle_a", "Prysznic 2", category = {'stanie'}, category = {'stanie'}, AnimationOptions =
         {
             EmoteMoving = true,
             EmoteLoop = true,
         }},
         ["prysznic3"] = {"mp_safehouseshower@male@", "male_shower_idle_d", "Prysznic 3", category = {'stanie'}, category = {'stanie'}, AnimationOptions =
         {
             EmoteMoving = true,
             EmoteLoop = true,
         }},
         ["mechanik4"] = {"amb@world_human_vehicle_mechanic@male@base", "base", "Mechanik 4 - Pod Autem", category = {'mechanik'}, AnimationOptions =
         {
             EmoteLoop = true,
             EmoteMoving = false,
         }},
         ["mechanik5"] = {"amb@world_human_vehicle_mechanic@male@exit", "exit", "Mechanik 5 - Wyjscie spod Auta", category = {'mechanik'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         ["bolbrzucha"] = {"combat@damage@writheidle_a", "writhe_idle_a", "Ból brzucha", category = {'medyczne', 'lezenie'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         ["bolglowy"] = {"combat@damage@writheidle_b", "writhe_idle_f", "Ból głowy", category = {'medyczne', 'lezenie'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         ["bolnogi2"] = {"combat@damage@writheidle_b", "writhe_idle_e", "Ból nogi 2", category = {'medyczne', 'lezenie'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         ["bolplecow"] = {"anim@move_lester", "idle_a", "Ból pleców", category = {'medyczne', 'lezenie'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         ["bolnoga"] = {"missfbi5ig_0", "lyinginpain_loop_steve", "Ból nogi", category = {'medyczne', 'lezenie'}, AnimationOptions =
         {
             EmoteLoop = false,
             EmoteMoving = false,
         }},
         -----
   ["bestia"] = {"anim@mp_fm_event@intro", "beast_transform", "Bestia", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["leżenie5"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Leżenie 5", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lezenie2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Leżenie 2", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lezenie3"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Leżenie 3", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["czolganie"] = {"missfbi3_sniping", "prone_dave", "Czołganie", category = {'inne', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wskazywanie"] = {"misscarsteal3pullover", "pull_over_right", "Wskazywanie", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["stanie"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Stanie", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Stanie 8", category = {'stanie'}, AnimationOptions =
   {
    EmoteLoop = true,
   }},
   ["stanie9"] = {"friends@fra@ig_1", "base_idle", "Stanie 9", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie10"] = {"mp_move@prostitute@m@french", "idle", "Stanie 10", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["anal1"] = {"rcmpaparazzo_2", "shag_loop_a", "Anal 1", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["anal2"] = {"rcmpaparazzo_2", "shag_loop_poppy", "Anal 2", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["stanie11"] = {"random@countrysiderobbery", "idle_a", "Stanie 11", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Stanie 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Stanie 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Stanie 4", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Stanie 5", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Stanie 6", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stanie7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Stanie 7", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["czekanie3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Czekanie 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pijany"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Pijany", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pijany2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Pijany 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pijany3"] = {"missarmenian2", "standing_idle_loop_drunk", "Pijany 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gestgitara"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Gest gitary", category = {"inne"}},
   ["gestpianino"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Gest pianina", category = {"inne"}},
   ["klotnia"] = {"misscarsteal4@actor", "actor_berating_loop", "Kłótnia", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["klotnia2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Kłotnia 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["klotnia3"] = {"sdrm_mcs_2-0", "csb_bride_dual-0", "Kłotnia 3", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["klotnia4"] = {"sdrm_mcs_2-0", "csb_bride_dual-0", "Kłotnia 3 LONG", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barman"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Barman", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["buziak"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Buziak", category = {"inne"}},
   ["buziak2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Buziak 2", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["uklon"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Ukłon", category = {"rozmowa"}},
   ["dawaj"] = {"misscommon@response", "bring_it_on", "Dawaj", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["dawaj"] = {"mini@triathlon", "want_some_of_this", "Dawaj 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["glina2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Załozone Ręce", category = {'police', 'stanie', 'medyczne', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["glina3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Ręce na pasie", category = {'police', 'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rece"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Założone ręce", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Założone ręce 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["rece3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Założone ręce 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece4"] = {"random@street_race", "_car_b_lookout", "Założone ręce 4", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Założone ręce 5", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece6"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Założone ręce 6", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece7"] = {"random@shop_gunstore", "_idle", "Założone ręce 7", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece8"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Założone ręce 8", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rece9"] = {"rcmnigel1a_band_groupies", "base_m2", "Założone ręce 9", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["wskazywaniewdol"] = {"gestures@f@standing@casual", "gesture_hand_down", "Wskazywanie w dół", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["poddanie"] = {"random@arrests@busted", "idle_a", "Poddanie się", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["upadek"] = {"random@drunk_driver_1", "drunk_fall_over", "Upadek (mdlenie)", category = {"inne"}},
   ["samobojstwo"] = {"mp_suicide", "pistol", "Samobójstwo (strzał w głowę)", category = {"inne"}},
   ["samobojstwo2"] = {"mp_suicide", "pill", "Samobójstwo (przyjęcie pigułki)", category = {"inne"}},
   ["nokaut"] = {"friends@frf@ig_2", "knockout_plyr", "Nokaut", category = {"inne", "sport"}},
   ["upadek2"] = {"anim@gangops@hostage@", "victim_fail", "Upadek", category = {"inne"}},
   ["zasniecie"] = {"mp_sleep", "sleep_loop", "Zaśnięcie", category = {'gangi'}, AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["przedwalka"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Przed walką", category = {"inne", "gangi"}},
   ["przedwalka2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Przed walką 2", category = {"inne", "gangi"}},
   ["palec"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Środkowy palec", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palec2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Środkowy palec 2", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uscisk"] = {"mp_ped_interaction", "handshake_guy_a", "Uścisk dłoni", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["uscisk2"] = {"mp_ped_interaction", "handshake_guy_b", "Uścisk dłoni 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["czekanie4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Czekanie 4", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["czekanie5"] = {"missclothing", "idle_storeclerk", "Czekanie 5", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Czekanie 6", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie7"] = {"rcmnigel1cnmt_1c", "base", "Czekanie 7", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie8"] = {"rcmjosh1", "idle", "Czekanie 8", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie"] = {"rcmjosh2", "josh_2_intp1_base", "Czekanie 9", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Czekanie 10", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie11"] = {"misshair_shop@hair_dressers", "keeper_base", "Czekanie 11", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie12"] = {"amb@world_human_hang_out_street@female_arm_side@idle_a", "idle_b", "Czekanie 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wedrowiec"] = {"move_m@hiking", "idle", "Wędrowiec", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["przytulas"] = {"mp_ped_interaction", "kisses_guy_a", "Przytulas", category = {"rozmowa"}},
   ["przytulas2"] = {"mp_ped_interaction", "kisses_guy_b", "Przytulas 2", category = {"rozmowa"}},
   ["przytulas3"] = {"mp_ped_interaction", "hugs_guy_a", "Przytulas 3", category = {"rozmowa"}},
   ["inspekcja"] = {"random@train_tracks", "idle_e", "Inspekcja", category = {"inne", "police", "medyczne", "mechanik"}},
   ["entuzjazm"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Udawany entuzjazm", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jogging2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jogging 2", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jogging3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jogging 3", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jogging4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jogging 4", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jogging5"] = {"move_m@joy@a", "walk", "Jogging 5", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pajacyki"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Pajacyki", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucanie"] = {"rcmextreme3", "idle", "Kucanie", category = {'inne', 'police', 'medyczne', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucanie2"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kucanie 2", category = {'inne', 'police', 'medyczne', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pukanie"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Pukanie", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["dobijanie"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Dobijanie się", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kostki"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Strzelanie kostkami", category = {'sport', 'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["taniecrura"] = {"mp_safehouse", "lap_dance_girl", "Taniec na rurze", category = {"taniec"}},
   ["opieranie2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Opieranie 2", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Opieranie 3", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Opieranie 4", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Opieranie 5", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie6"] = {"random@street_race", "_car_a_flirt_girl", "Opieranie 6", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie7"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Opieranie o barierkę", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie8"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Opieranie o barierkę 2", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie9"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Opieranie o barierkę 3", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie10"] = {"amb@world_human_leaning@male@wall@back@legs_crossed@base", "base", "Opieranie się", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie11"] = {"amb@world_human_leaning@male@wall@back@hands_together@base", "base", "Opieranie się v2", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie12"] = {"amb@world_human_leaning@male@wall@back@foot_up@base", "base", "Opieranie się v3", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie13"] = {"missstrip_club_lea", "player_lean_rail_loop", "Opieranie się na ramionach", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie14"] = {"mp_safehousebeer@", "base_drink", "Opieranie się na rękach", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieranie15"] = {"anim@amb@nightclub@gt_idle@", "base", "Opieranie się do tyłu", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["opieraniew"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Opieranie o barierkę (wyżej)", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opieraniew2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Opieranie o barierkę (wyżej) 2", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opieraniel"] = {"timetable@mime@01_gc", "idle_a", "Opieranie lewo", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opieraniel2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Opieranie lewo 2", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opieraniel3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Opieranie lewo 3", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opieraniel4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Opieranie lewo 4", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["opieraniel5"] = {"rcmjosh2", "josh_2_intp1_base", "Opieranie lewo 5", category = {'opieranie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["ja"] = {"gestures@f@standing@casual", "gesture_me_hard", "Ja", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mechanik"] = {"mini@repair", "fixing_a_ped", "Mechanik", category = {'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
  -- ["mechanik2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mechanik 2", AnimationOptions =
   --{
   --    EmoteLoop = true,
   --}},
   ["mechanik2"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanik 2", category = {'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanik3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanik 3", category = {'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medyk2"] = {"amb@medic@standing@tendtodead@base", "base", "Medyk 2", category = {'medyczne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["medytacja"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Medytacja", category = {'siedzenie1', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["medytacja2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Medytacja 2", category = {'siedzenie1', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["medytacja3"] = {"rcmepsilonism3", "base_loop", "Medytacja 3", category = {'siedzenie1', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rock"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Rock", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nie"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Nie", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nie2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Nie 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dlubanie"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Dłubanie w  nosie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nie3"] = {"gestures@m@standing@casual", "gesture_no_way", "Nie 3", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "👌", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["zdyszany"] = {"re@construction", "out_of_breath", "Zdyszany", category = {'stanie', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["staniepolicjant"] = {"amb@code_human_wander_idles_cop@male@static", "static", "Stanie Policjant", category = {'stanie', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["staniemysliciel"] = {"rcmnigel3_idles", "base_nig", "Stanie Mysliciel", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stanieluzno"] = {"amb@world_human_stand_impatient@female@no_sign@base", "base", "Stanie Luzno", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["staniepalce"] = {"amb@world_human_cop_idles@female@base", "base", "Palce na biodra", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["drapaniejaja"] = {"mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch", "Drapanie się po pajajach", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kobiecyurok"] = {"mini@strip_club@idles@stripper", "stripper_idle_02", "Kobiecy Urok", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["masturbacja"] = {"mp_player_int_upperwank", "mp_player_int_wank_01", "Masturbacja", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["panika"] = {"rcmlastone1", "convict_idleshort", "Panika", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stanieniespokojny"] = {"amb@world_human_drug_dealer_hard@male@idle_a", "idle_c", "Stanie Niespokojny", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stanieochroniarz"] = {"amb@world_human_stand_guard@male@base", "base", "Ochroniarz", category = {'stanie', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["biodra"] = {"amb@world_human_cop_idles@male@idle_b", "idle_e", "Biodra", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["podniesienie"] = {"random@domestic", "pickup_low", "Podniesienie", category = {'inne'}, AnimationOptions =
   {
    EmoteLoop = false,
}},
   ["pchanie"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Pchanie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pchanie2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Pchanie 2", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wskazywanie"] = {"gestures@f@standing@casual", "gesture_point", "Wskazywanie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pompki"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pompki", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["doping"] = {"random@street_race", "grid_girl_race_start", "Doping", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wskazywaniewprawo"] = {"mp_gun_shop_tut", "indicate_right", "Wskazywanie w prawo", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salut"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salut", category = {'inne', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salut2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salut 2", category = {'inne', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salut3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salut 3", category = {'inne', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["przestraszony"] = {"random@domestic", "f_distressed_loop", "Przestraszony", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["przestraszony2"] = {"random@homelandsecurity", "knees_loop_girl", "Przestraszony 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["walsie"] = {"misscommon@response", "screw_you", "Wal sie", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["otrzepanie"] = {"move_m@_idles@shake_off", "shakeoff_1", "Otrzepanie", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["ranny"] = {"random@dealgonewrong", "idle_a", "Ranny", category = {'medyczne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["spanie"] = {"timetable@tracy@sleep@", "idle_c", "Spanie", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wzruszenie"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Wzruszenie", category = {'stanie'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["wzruszenie2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Wzruszenie 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["siedzenie"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Siedzenie", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie2"] = {"rcm_barry3", "barry_3_sit_loop", "Siedzenie 2", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Siedzenie 3", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Siedzenie 4", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Siedzenie 5", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Siedzenie 6", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Siedzenie 7", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Siedzenie 8", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["siedzenie9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Siedzenie 9", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslolean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Siedzenie Lean", category = {'siedzenie2'}, category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["smutnesiedzenie"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Smutne siedzenie", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przestraszonysiedzenie"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Siedzenie przestraszony", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przestraszonysiedzenie2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Siedzenie przestraszony 2", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przestraszonysiedzenie3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Siedzenie przestraszony 3", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pijanesiedzenie"] = {"timetable@amanda@drunk@base", "base", "Pijane siedzenie", category = {'siedzenie1'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslo2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Krzeslo 2", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslo3"] = {"timetable@reunited@ig_10", "base_amanda", "Krzeslo 3", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslo4"] = {"timetable@ron@ig_3_couch", "base", "Krzeslo 4", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslo5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Krzeslo 5", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslo6"] = {"timetable@maid@couch@", "base", "Krzeslo 6", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["krzeslobok"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Siadanie na krześle od boku", category = {'siedzenie2'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["brzuszki"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Brzuszki", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["energiczneklaskanie"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Energiczne klaskanie", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wolneklaskanie3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Wolne klaskanie 3", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["klaskanie"] = {"amb@world_human_cheering@male_a", "base", "Klaskanie", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wolneklaskanie"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Wolne klaskanie", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wolneklaskanie2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Wolne klaskanie 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wachanie"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Wąchanie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["strzelanie"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Strzelanie z palca", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["potkniecie"] = {"misscarsteal4@actor", "stumble", "Bół głowy", category = {'medyczne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["porazony"] = {"stungun@standing", "damage", "Porażony prądem", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lezenie"] = {"amb@world_human_sunbathe@male@back@base", "base", "Leżenie", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lezenie4"] = {"amb@world_human_sunbathe@female@back@base", "base", "Leżenie 4", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["myslenie5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", category = {'stanie'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["myslenie"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Myslenie", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["myslenie3"] = {"timetable@tracy@ig_8@base", "base", "Myslenie 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["myslenie2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Myslenie 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kciukdogory3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Kciuk do góry 3", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["kciukdogory2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Kciuk do góry 2", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kciukdogory"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Kciuk do góry", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pisanie"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Pisanie", category = {'inne', 'medyczne', 'police', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pisanie2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Pisanie 2", category = {'inne', 'medyczne', 'police', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pisanie3"] = {"mp_prison_break", "hack_loop", "Pisanie 3", category = {'inne', 'medyczne', 'police', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pisanie4"] = {"mp_fbi_heist", "loop", "Pisanie 4", category = {'inne', 'medyczne', 'police', 'mechanik'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ogrzewanie"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Ogrzewanie się", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Machanie 4", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["machanie2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Machanie 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie3"] = {"friends@fra@ig_1", "over_here_idle_a", "Machanie 3", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie"] = {"friends@frj@ig_1", "wave_a", "Machanie", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie5"] = {"friends@frj@ig_1", "wave_b", "Machanie 5", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie6"] = {"friends@frj@ig_1", "wave_c", "Machanie 6", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie7"] = {"friends@frj@ig_1", "wave_d", "Machanie 7", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["machanie8"] = {"friends@frj@ig_1", "wave_e", "Machanie 8", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["machanie9"] = {"gestures@m@standing@casual", "gesture_hello", "Machanie 9", category = {'rozmowa'}, AnimationOptions =
   {
    EmoteLoop = false,
    EmoteMoving = true,
   }},
   ["gwizdanie"] = {"taxi_hail", "hail_taxi", "Gwizdanie", category = {'inne', 'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["gwizdanie2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Gwizdanie 2", category = {'inne', 'rozmowa'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kciuk"] = {"random@hitch_lift", "idle_f", "Kciuk", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign3"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@bodhi@rps@base", "idle_a", "Gang Sign 3", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign4"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@low@ds@base", "idle_a", "Gang Sign 4", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign5"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@low@ps@base", "idle_a", "Gang Sign 5", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign6"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@std@ds@base", "idle_a", "Gang Sign 6", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign7"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@std@ps@base", "idle_a", "Gang Sign 7", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign8"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@std@rds@base", "idle_a", "Gang Sign 8", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},
   ["gangsign9"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@std@rps@base", "idle_a", "Gang Sign 9", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       AllowedInCar = true,
   }},

   ["nieprzytomny"] = {"missarmenian2", "drunk_loop", "Nieprzytomny", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nieprzytomny2"] = {"missarmenian2", "corpse_search_exit_ped", "Nieprzytomny 2", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nieprzytomny3"] = {"anim@gangops@morgue@table@", "body_search", "Nieprzytomny 3", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nieprzytomny4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Nieprzytomny 4", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nieprzytomny5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Nieprzytomny 5", category = {'lezenie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["glaskaniepsa"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Głaskanie psa", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["czolganie"] = {"move_injured_ground", "front_loop", "Czołganie się", category = {'inne', 'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przewrot2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Przewrót 2", category = {"sport"}},
   ["przewrot"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Przewrót", category = {"sport"}},
   ["slizg"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Ślizg", category = {"inne", "sport"}},
   ["slizg2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slizg 2", category = {"inne", "sport"}},
   ["slizg3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Ślizg 3", category = {"inne", "sport"}},
   ["bejsbol"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Bejsbol", category = {"inne", "sport"}},
   ["2palce"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Pódwójny środkowy palec", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["2palce2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Pódwójny środkowy palec 2", category = {'inne', 'gangi'}, AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["uklon"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Ukłon", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uklon2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Ukłon 2", category = {'rozmowa'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kluczyk"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Otwieranie pojazdów", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golf"] = {"rcmnigel1d", "swing_a_mark", "Golf", category = {"inne", "sport"}},
   ["sieganie"] = {"move_m@intimidation@cop@unarmed", "idle", "Sięganie po broń", category = {'stanie', 'police'}, AnimationOptions =
   {
       
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie"] = {"random@shop_tattoo", "_idle_a", "Czekanie", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie2"] = {"missbigscore2aig_3", "wait_for_van_c", "Czekanie 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie12"] = {"rcmjosh1", "idle", "Czekanie 12", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie13"] = {"rcmnigel1a", "base", "Czekanie 13", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czekanie14"] = {"amb@world_human_prostitute@cokehead@base", "base", "Czekanie 14", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["zmeczeniee"] = {"rcmfanatic3leadinoutef_3_mcs_1", "fra_outofbreath_loop", "Zmeczony", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["taniecerotyczny2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Taniec erotyczny 2", category = {'+18', 'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecerotyczny3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Taniec erotyczny 3", category = {'+18', 'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecerotyczny3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Taniec erotyczny 3", category = {'+18', 'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecerotyczny4"] = {"mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f", "Taniec erotyczny 4", category = {'+18', 'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taniecerotyczny5"] = {"mini@strip_club@private_dance@part1", "priv_dance_p1", "Taniec erotyczny 4", category = {'+18', 'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["policzkowac"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["uderzeniezglowy"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Uderzenie z głowy", category = {"gangi", "sport"}},
   ["taniecryby"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Taniec ryby", category = {'taniec'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pozdro"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Pozdro", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pozdro2"] = {"anim@mp_player_intupperpeace", "idle_a", "Pozdro 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["zaproszenie"] = {"mini@strip_club@lap_dance@ld_girl_a_invite", "ld_girl_a_invite", "Zaproszenie faceta", category = {'+18'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rko"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "RKO", category = {'medyczne', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rko2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "RKO 2", category = {'medyczne', 'police'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["malysz"] = {"missfbi1", "ledge_loop", "Małysz", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["samolot"] = {"missfbi1", "ledge_loop", "Samolot", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wygladanie"] = {"random@paparazzi@peek", "left_peek_a", "Wyglądanie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["blowjob"] = {"oddjobs@towing", "m_blow_job_loop", "Blowjob 1 [Pojazd +18]", category = {'+18', 'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["blowjob2"] = {"oddjobs@towing", "f_blow_job_loop", "Blowjob 2 [Pojazd +18]", category = {'+18', 'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["lokiec"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", "Zimny lokiec", category = {'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["lokiec2"] = {"anim@amb@code_human_in_car_idles@arm@generic@ds@idle_l", "idle", "Zimny lokiec2", category = {'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["lokiec3"] = {"anim@amb@code_human_in_car_idles@arm@generic@ds@idle_d", "idle", "Zimny lokiec3", category = {'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["berlo"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", "Siadanie na berlo [Pojazd +18]", category = {'+18', 'pojazd'}, AnimationOptions =
   {
    AllowedInCar = true,
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["kaszlenie"] = {"timetable@gardener@smoking_joint", "idle_cough", "Kaszlenie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rozciaganie"] = {"mini@triathlon", "idle_e", "Rozciaganie", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rozciaganie2"] = {"mini@triathlon", "idle_f", "Rozciaganie 2", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rozciaganie3"] = {"mini@triathlon", "idle_d", "Rozciaganie 3", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rozciaganie4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Rozciaganie 4", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrować"] = {"rcmfanatic1celebrate", "celebrate", "Celebrować", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uderzanie"] = {"rcmextreme2", "loop_punching", "Uderzanie", category = {'sport'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superbohater"] = {"rcmbarry", "base", "Superbohater", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superbohater2"] = {"rcmbarry", "base", "Superbohater 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kontrolaumyslu"] = {"rcmbarry", "mind_control_b_loop", "Kontrola umysłu", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kontrolaumyslu"] = {"rcmbarry", "bar_1_attack_idle_aln", "Kontrola umysłu 2", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przymierzanie"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Przymierzanie ciuchów", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przymierzanie2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Przymierzanie ciuchów 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["przymierzanie3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Przymierzanie ciuchów 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nerwowy2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nerwowy 2", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nerwowy"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nerwowy", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nerwowy3"] = {"rcmme_tracey1", "nervous_loop", "Nerwowy 3", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["odkucie"] = {"mp_arresting", "a_uncuff", "Odkuwanie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["modlenie"] = {"timetable@amanda@ig_4", "ig_4_base", "Modlenie się", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["grozic"] = {"random@atmrobberygen", "b_atm_mugging", "Grożenie", category = {'gangi'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", category = {'inne', 'police', 'medyczne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ciagniecie"] = {"random@mugging4", "struggle_loop_b_thief", "Ciągnięcie", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ptak"] = {"random@peyote@bird", "wakeup", "Ptak", category = {"inne"}},
   ["kurczak"] = {"random@peyote@chicken", "wakeup", "Kurczak", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pies"] = {"random@peyote@dog", "wakeup", "Pies", category = {"inne"}},
   ["krolik"] = {"random@peyote@rabbit", "wakeup", "Królik", category = {"inne"}},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", category = {'inne'}, AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["chlopie"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "CHLOPIE", category = {'inne'}, AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["poprawianie2"] = {"missmic4", "michael_tux_fidget", "Poprawianie 2", category = {'stanie'}, AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["recewgorze"] = {"missminuteman_1ig_2", "handsup_base", "Rece w gorze", category = {'stanie'}, AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["siku"] = {"misscarsteal2peeing", "peeing_loop", "Pee", category = {'inne'}, AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["bankomat"] = {"Scenario", "PROP_HUMAN_ATM", "Bankomat"},
   ["siedzeniebar"] = {"Scenario", "PROP_HUMAN_SEAT_BAR", "Siedzenie w barze"},
   ["grill"] = {"MaleScenario", "PROP_HUMAN_BBQ", "Grillowanie"},
   ["grzebanie"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Grzebanie w śmieciach"},
   ["spanie"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Spanie"},
   ["gratulacje"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Pogratulowanie"},
   ["podciaganie"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Podciaganie"},
   ["tablica2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Tablica 2"},
   ["glina"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Glina"},
   ["kontrolaruchu"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Kontrola ruchu"},
   ["zdjecie"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Robienie zdjec"},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
   ["ochroniarz"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Ochroniarz"},
   ["mlotek"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Młotek"},
   ["rozmowa"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Rozmowa"},
   ["niecierpliwy"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Niecierpliwy"},
   ["miotla"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Miotła"},
   ["rozgrzewka"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Rozgrzewka"},
   ["sprawdzanie"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Sprawdzanie terenu"},
   ["dmuchawa"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Dmuchawa"},
   ["opieranie"] = {"Scenario", "WORLD_HUMAN_LEANING", "Opieranie się"},
   ["opieraniebar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Opieranie się BAR"},
   ["rozgladaniesie"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Rozglądanie sie"},
   ["pokojowka"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Pokojówka"},
   ["medyk"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medyk"},
   ["muzyka"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Granie na bębnach"},
   ["notatnik2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notatnik 2"},
   ["parkometr"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parkometr"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
   ["telpisanie"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Pisanie na telefonie"},
   ["prostytutka"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostytutka"},
   ["prostytutka2"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostytutka2"},
   ["kaluza"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Kałuża"},
   ["nagrywanie"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Nagrywanie"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["krzeslo"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Siedzenie na krześle"},
   ["statula"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statuła"},
   ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
   ["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"},
   ["wlamywanie"] = {"Scenario", "WORLD_HUMAN_WELDING", "Wlamywanie"},
   ["oknozakupy"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Zakupy w oknie"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["gardlo"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Rozcinanie gardla"},
   ["gardlo2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Rozcinanie gardla 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", category = {'sport'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", category = {'sport'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["sprawdzbron"] = {"mp_corona@single_team", "single_team_intro_one", "Sprawdzenie pistoletu", category = {'inne', 'gangi', 'police'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["pakowanie"] = {"mp_am_hold_up", "purchase_beerbox_shopkeeper", "Pakowanie na naczepe", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["smierdzi"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Smierdzi", category = {'inne'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["myslenie4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Myslenie 4", category = {'stanie'}, AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["poprawianie"] = {"clothingtie", "try_tie_positive_a", "Poprawianie krawatu", category = {'stanie'}, AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["parasolka"] = {"amb@world_human_drinking@coffee@male@base", "base", "Parasolka", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["kelner"] = {"anim@heists@box_carry@", "idle", "Kelner", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_cs_silver_tray",
       PropBone = 28422,
       PropPlacement = {0.0, -0.25, -0.2, 0.0, 0.0, 0.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["tattoo"] = {"misstattoo_parlour@shop_ig_4", "tattooist_loop", "Tatuazysta", category = {'przedmioty', 'gangi'}, AnimationOptions =
   {
       Prop = "v_ilev_ta_tatgun",
       PropBone = 28422,
       PropPlacement = {0.01, 0.07, -0.05, 0.0, 0.0, -50.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

      ["spray"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", "Spray", category = {'przedmioty', 'gangi'}, AnimationOptions =
   {
     Prop = 'prop_cs_spray_can',
     PropBone = 28422,
     PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
     EmoteLoop = true,
     EmoteMoving = false,
     PtfxAsset = "scr_playerlamgraff",
     PtfxName = "scr_lamgraff_paint_spray",
     PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
     PtfxInfo = Config.Languages[Config.MenuLanguage]['spray'],
     PtfxWait = 5000,
   }},
   ["spray2"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", "Spray 2", category = {'przedmioty', 'gangi'}, AnimationOptions =
   {
     Prop = 'prop_cs_spray_can',
     PropBone = 28422,
     PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
     EmoteLoop = true,
     EmoteMoving = true,
   }},
-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["notatnik"] = {"missheistdockssetup1clipboard@base", "base", "Notatnik", category = {'przedmioty', 'mechanik', 'police', 'medyczne'}, AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pudlo"] = {"anim@heists@box_carry@", "idle", "Pudło", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["opona"] = {"anim@heists@box_carry@", "idle", "Koło", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_wheel_01",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opona2"] = {"anim@heists@box_carry@", "idle", "Koło 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_tyre_02c",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["opona3"] = {"anim@heists@box_carry@", "idle", "Koło 3", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_tyre_03a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["akumulator"] = {"anim@heists@box_carry@", "idle", "Akumulator", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "bkr_prop_meth_lithium",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["olej"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Olej", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "ng_proc_oilcan01a",
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bumper"] = {"anim@heists@box_carry@", "idle", "Bumper samochodowy", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_front_bars_01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.20, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["spoiler"] = {"anim@heists@box_carry@", "idle", "Spoiler samochodowy", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_spoiler_01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["bumper2"] = {"anim@heists@box_carry@", "idle", "Bumper samochodowy 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_front_bars_02a",
       PropBone = 28422,
       PropPlacement = {0.0, 0.2, -0.17, 0.0, 0.0, -180.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bumper3"] = {"anim@heists@box_carry@", "idle", "Bumper samochodowy 3", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_front_bumper_02a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["silnik"] = {"anim@heists@box_carry@", "idle", "silnik", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_engine_part_01a",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["drzwipojazd"] = {"anim@heists@box_carry@", "idle", "Drzwi od pojazdu", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_car_door_01",
       PropBone = 60309,
       PropPlacement = {0.315, -0.10, 0.255, -70.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["malaapteczka"] = {"anim@heists@box_carry@", "idle", "Mała Apteczka", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_ld_health_pack",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["drzwipojazd2"] = {"anim@heists@box_carry@", "idle", "Drzwi od pojazdu 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_car_door_01a",
       PropBone = 28422,
       PropPlacement = {-0.50, -0.18, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["felapojazd"] = {"anim@heists@box_carry@", "idle", "Fela", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_wheel_01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["maskapojazd"] = {"anim@heists@box_carry@", "idle", "Maska od pojazdu", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_car_bonnet_01",
       PropBone = 60309,
       PropPlacement = {0.115, -0.10, 0.255, -70.0, 270.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["maskapojazd2"] = {"anim@heists@box_carry@", "idle", "Maska od pojazdu 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_bonnet_02a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nadkole"] = {"anim@heists@box_carry@", "idle", "Nadkole samochodowe", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "imp_prop_impexp_car_panel_01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fotelpojazd"] = {"anim@heists@box_carry@", "idle", "Fotel od pojazdu", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_rub_carpart_05",
       PropBone = 60309,
       PropPlacement = {0.115, -0.10, 0.255, -70.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fotelpojazd2"] = {"anim@heists@box_carry@", "idle", "Fotel od pojazdu 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = "prop_car_seat",
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["laptop"] = {"anim@heists@box_carry@", "idle", "Laptop", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_laptop_01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.18, -0.17, 0, 0, 180.0, 1, 1, 0, 1, 1, 1},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
    }},
    ["paczka"] = {"anim@heists@box_carry@", "idle", "Paczka", category = {'przedmioty', 'medyczne'}, AnimationOptions =
    {
        Prop = "v_serv_abox_04",
        PropBone = 28422,
        PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wozek"] = {"anim@heists@box_carry@", "idle", "Wózek", category = {'przedmioty'}, AnimationOptions =
    {
        Prop = "prop_skid_trolley_2",
        PropBone = 28422,
        PropPlacement = {0.0, -0.48, -0.80, 15.0, 0, 0, 1, 1, 0, 1, 1, 1},
        EmoteLoop = true,
        EmoteMoving = true,
        canDrop = true,
    }},
    ["wozek2"] = {"anim@heists@box_carry@", "idle", "Wózek 2", category = {'przedmioty'}, AnimationOptions =
    {
        Prop = "prop_rub_trolley02a",
        PropBone = 28422,
        PropPlacement = {0.0, -0.48, -0.80, 15.0, 0, 0, 1, 1, 0, 1, 1, 1},
        EmoteLoop = true,
        EmoteMoving = true,
        canDrop = true,
   }},
   ["wozek3"] = {"anim@heists@box_carry@", "idle", "Wózek 3", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_rub_trolley01a",
       PropBone = 28422,
       PropPlacement = {0.0, -0.48, -0.80, 15.0, 0, 0, 1, 1, 0, 1, 1, 1},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
  }},
  ["narzedziabox"] = {"rcmepsilonism8", "bag_handler_idle_a", "Skrzynia z narzędziami", category = {'przedmioty', 'mechanik'}, AnimationOptions =
  {
      Prop = "prop_tool_box_04",
      PropBone = 57005,
      PropPlacement = {0.45, 0.0, 0.0, -90.0, 0.0, 90.0},
      EmoteLoop = true,
      EmoteMoving = true,
      canDrop = true,
 }},
 ["narzedziabox2"] = {"rcmepsilonism8", "bag_handler_idle_a", "Skrzynka z wiertarką", category = {'przedmioty', 'mechanik'}, AnimationOptions =
 {
     Prop = "prop_tool_box_02",
     PropBone = 57005,
     PropPlacement = {0.53, 0.0, 0.0, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["wydech"] = {"anim@heists@box_carry@", "idle", "Wydech samochodowy", category = {'przedmioty', 'mechanik'}, AnimationOptions =
 {
     Prop = "imp_prop_impexp_exhaust_01",
     PropBone = 28422,
     PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["wydech2"] = {"anim@heists@box_carry@", "idle", "Wydech samochodowy 2", category = {'przedmioty', 'mechanik'}, AnimationOptions =
 {
     Prop = "imp_prop_impexp_exhaust_02",
     PropBone = 28422,
     PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["wydech3"] = {"anim@heists@box_carry@", "idle", "Wydech samochodowy 3", category = {'przedmioty', 'mechanik'}, AnimationOptions =
 {
     Prop = "imp_prop_impexp_exhaust_04",
     PropBone = 28422,
     PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["bojkaratownicza"] = {"rcmepsilonism8", "bag_handler_idle_a", "Bojka ratownicza", category = {'przedmioty', 'medyczne'}, AnimationOptions =
 {
     Prop = "prop_beach_lg_float",
     PropBone = 57005,
     PropPlacement = {0.20, 0.0, -0.02, -90.0, 0.0, 0.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["walizka"] = {"anim@heists@narcotics@trash", "walk", "Walizka na kółkach", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_suitcase_03",
     PropBone = 57005,
     PropPlacement = {0.36, -0.45, -0.05, -50.0, -60.0, 15.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba1"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba z sklepu", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_shopping_bags01",
     PropBone = 57005,
     PropPlacement = {0.08, 0.0, -0.02, 357.0, -100.0, 15.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba2"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba z sklepu 2", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_shopping_bags02",
     PropBone = 57005,
     PropPlacement = {0.08, 0.0, -0.02, 357.0, -100.0, 15.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba3"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torebka", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_ld_handbag_s",
     PropBone = 57005,
     PropPlacement = {0.5, 0.0, -0.03, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba4"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba z sklepu 3", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "ng_proc_binbag_02a",
     PropBone = 57005,
     PropPlacement = {0.50, 0.0, 0.15, 357.0, -100.0, 15.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba5"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba z sklepu 4", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "ba_prop_battle_handbag",
     PropBone = 57005,
     PropPlacement = {0.15, 0.0, -0.03, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba6"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_med_bag_01b",
     PropBone = 57005,
     PropPlacement = {0.35, 0.0, -0.03, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
 }},
 ["torba7"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba Medyczna", category = {'przedmioty', 'medyczne', 'police'}, AnimationOptions =
 {
     Prop = "xm_prop_x17_bag_med_01a",
     PropBone = 57005,
     PropPlacement = {0.40, 0.0, -0.03, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true,
     
 }},
 ["torba8"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba z jedzeniem", category = {'przedmioty', 'medyczne', 'police'}, AnimationOptions =
 {
     Prop = "ng_proc_food_bag02a",
     PropBone = 57005,
     PropPlacement = {0.30, 0.0, -0.02, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true
 }},
 ["torba9"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba Treningowa 2", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_luggage_07a",
     PropBone = 57005,
     PropPlacement = {0.3, 0.0, -0.02, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true
 }},
 ["smieci"] = {"rcmepsilonism8", "bag_handler_idle_a", "Worek na smieci", category = {'przedmioty'}, AnimationOptions =
 {
     Prop = "prop_cs_rub_binbag_01",
     PropBone = 57005,
     PropPlacement = {0.09, 0.0, -0.03, -90.0, 0.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
     canDrop = true
   }},
    ["smieci2"] = {"rcmepsilonism8", "bag_handler_idle_a", "Worek na smieci 2", category = {'przedmioty'}, AnimationOptions =
    {
     Prop = "prop_rub_binbag_05",
     PropBone = 57005,
     PropPlacement = {0.8, 0.0, 0.22, -90.0, -20.0, 90.0},
     EmoteLoop = true,
     EmoteMoving = true,
   }},
   ["smieci3"] = {"rcmepsilonism8", "bag_handler_idle_a", "Worek na smieci 3", category = {'przedmioty'}, AnimationOptions =
   {
    Prop = "hei_prop_heist_binbag",
    PropBone = 57005,
    PropPlacement = {0.15, 0.0, -0.02, -90.0, 0.0, 90.0},
    EmoteLoop = true,
    EmoteMoving = true,
  }},
  ["wiertarka"] = {"anim@heists@fleeca_bank@drilling", "drill_straight_start", "Wiercenie wiertarką", category = {'przedmioty', 'mechanik'}, AnimationOptions =
  {
   Prop = "prop_tool_drill",
   PropBone = 57005,
   PropPlacement = {0.1, 0.04, -0.03, -90.0, 180.0, 0.0},
   EmoteLoop = true,
   EmoteMoving = true,
 }},
 ["wiertarka2"] = {"anim@heists@fleeca_bank@drilling", "drill_straight_start", "Wiertarka z udarem", category = {'przedmioty', 'mechanik'}, AnimationOptions =
 {
  Prop = "hei_prop_heist_drill",
  PropBone = 57005,
  PropPlacement = {0.15, 0.04, -0.03, -90.0, 90.0, 0.0},
  EmoteLoop = true,
  EmoteMoving = true,
  canDrop = true,
}},
   ["roza"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Róża", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["palenie2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Palenie 2", {'przedmioty', 'stanie'}, AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palenie3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Palenie 3", category = {'przedmioty', 'stanie'}, AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palenie4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Palenie 4", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["walizka2"] = {"missheistdocksprep1hold_cellphone", "static", "Walizka 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true
   }},
   ["walizka3"] = {"missheistdocksprep1hold_cellphone", "static", "Walizka 3", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
       canDrop = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Zdjecie policyjne", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kawa"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Kawa", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["piwo"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Piwo", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kubek"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Kubek", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["kanapka"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Kanapka", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["cola"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cola", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koszzowocami"] = {"anim@heists@box_carry@", "idle", "Kosz z owocami", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'apa_mp_h_acc_fruitbowl_02',
       PropBone = 28422,
       PropPlacement = {0.0, -0.20, -0.17, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koszula"] = {"rcmepsilonism8", "bag_handler_idle_a", "Koszula", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_cs_shirt_01_s',
       PropBone = 57005,
       PropPlacement = {0.20, 0.0, -0.02, -90.0, 0.0, 90.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koperta"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Koperta", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_cash_envelope_01_s',
       PropBone = 24817,
       PropPlacement = {-0.10, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["batonik"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Batonik", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wino"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wino", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["kieliszek"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Kieliszek do wina", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["szampan2"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Szampan 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cygaro"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cygaro", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cygaro2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cygaro 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["gitara"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitara", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitara2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Gitara 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitara3"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitara elektryczna", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitara4"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitara elektryczna 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitara5"] = {"rcmepsilonism8", "bag_handler_idle_a", "Gitara w ręku", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 57005,
       PropPlacement = {0.10, -0.05, -0.05, -90.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["gitara6"] = {"rcmepsilonism8", "bag_handler_idle_a", "Gitara w ręku", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24816,
       PropPlacement = {0.30, -0.2, 0.0, 0.0, 90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["ksiazka"] = {"cellphone@", "cellphone_text_read_base", "Książka", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bukiet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bukiet", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["boombox"] = {"rcmepsilonism8", "bag_handler_idle_a", "Boombox", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_boombox_01',
       PropBone = 57005,
       PropPlacement = {0.27, 0.0, -0.02, -90.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["cegla"] = {"anim@heists@box_carry@", "idle", "Cegła", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'ng_proc_brick_01a',
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["czajnik"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Czajnik", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cs_kettle_01',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["glosnik"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Głośnik", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_speaker_03',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["krasnal"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Krasnal", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_gnome3',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["futeral"] = {"rcmepsilonism8", "bag_handler_idle_a", "Futerał [Tennis]", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_tennis_bag_01_s',
       PropBone = 57005,
       PropPlacement = {0.42, 0.0, -0.02, -90.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true
   }},
   ["grillowanie"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Grill", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_bbq_4',
       PropBone = 24817,
       PropPlacement = {-0.70, 0.50, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["mis"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Miś", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pantofel"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Pantofel", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_cs_amanda_shoe',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pilkaplazowa"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Piłka plażowa", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_beachball_01',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["papiertoaletowy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Papier toaletowy", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_toilet_roll_01',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["recznik"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Ręcznik", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_beach_towel_01',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["torba10"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torba Treningowa 3", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'bkr_prop_duffel_bag_01a',
       PropBone = 57005,
       PropPlacement = {0.33, 0.0, -0.02, -90.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["torba11"] = {"rcmepsilonism8", "bag_handler_idle_a", "Torebka", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_beachbag_06',
       PropBone = 57005,
       PropPlacement = {0.40, 0.0, -0.02, -90.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["paczkaziola"] = {"anim@heists@box_carry@", "idle", "Paczka z ziołem", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'bkr_prop_weed_bigbag_03a',
       PropBone = 28422,
       PropPlacement = {0.0, -0.08, -0.17, 0.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["worekmeta"] = {"rcmepsilonism8", "bag_handler_idle_a", "Woreczek z metą", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'bkr_prop_meth_smallbag_01a',
       PropBone = 57005,
       PropPlacement = {0.27, 0.0, -0.08, 0.0, 0.0, 90.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["pila"] = {"anim@heists@fleeca_bank@drilling", "drill_straight_start", "Piła tarczowa", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = 'prop_tool_consaw',
       PropBone = 57005,
       PropPlacement = {0.1, 0.04, -0.03, -90.0, 180.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pila2"] = {"anim@heists@fleeca_bank@drilling", "drill_straight_start", "Piła do żywopłotu", category = {'przedmioty', 'mechanik'}, AnimationOptions =
   {
       Prop = 'prop_hedge_trimmer_01',
       PropBone = 57005,
       PropPlacement = {0.1, 0.04, -0.03, -180.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["plecak"] = {"move_p_m_zero_rucksack", "idle", "Plecak", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["tablica"] = {"missfam4", "base", "Tablica", category = {'przedmioty', 'police', 'medyczne', 'mechanik'}, AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["mapa"] = {"amb@world_human_tourist_map@male@base", "base", "Mapa", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["aktowka"] = {"rcmepsilonism8", "bag_handler_idle_a", "Aktówka", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_ld_case_01_lod',
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteMoving = true,
       EmoteLoop = true,
       canDrop = true,
   }},
   ["zebrak"] = {"amb@world_human_bum_freeway@male@base", "base", "Żebrak", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kamera2"] = {"missfinale_c2mcs_1", "fin_c2_mcs_1_camman", "Kamera 2", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_v_cam_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mikrofon2"] = {"missfra1", "mcs2_crew_idle_m_boom", "Mikrofon", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_v_bmike_01',
       PropBone = 28422,
       PropPlacement = {-0.08, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mikrofon"] = {"missheistdocksprep1hold_cellphone", "hold_cellphone", "Mikrofon", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_ing_microphonel_01',
       PropBone = 60309,
       PropPlacement = {0.055, 0.05, 0.0, 240.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dolary"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Dolary", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["kamera"] = {"amb@world_human_paparazzi@male@base", "base", "Kamera", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["szampan"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Szampan", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["walizka3"] = {"missheistdocksprep1hold_cellphone", "static", "Walizka 3", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", category = {'przedmioty', 'mechanik', 'police', 'medyczne'}, AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", category = {'przedmioty', 'mechanik', 'police', 'medyczne'}, AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rozmowatelefon"] = {"cellphone@", "cellphone_call_listen_base", "Rozmowa przez telefon", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telefon"] = {"cellphone@", "cellphone_text_read_base", "Telefon", category = {'przedmioty'}, AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czyszczenie"] = {"timetable@floyd@clean_kitchen@base", "base", "Czyszczenie", category = {'przedmioty', 'mechanik', 'police', 'medyczne'}, AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["czyszczenie2"] = {"amb@world_human_maid_clean@", "base", "Czyszczenie 2", category = {'przedmioty', 'mechanik', 'police', 'medyczne'}, AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}