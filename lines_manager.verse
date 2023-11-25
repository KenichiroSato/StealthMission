
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.


duration := enum{Short, Long}

line := struct:
    Character : texture
    Sentence : texture
    Duration : duration

# A Verse-authored creative device that can be placed in a level
lines_manager := class(creative_device):

    @editable Scene1Trigger : mutator_zone_device = mutator_zone_device{}

    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    var IsStarted: logic = false

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Scene1Trigger.AgentEntersEvent.Subscribe(OnScene1)

    OnScene1(Agent: agent):void =
        if (IsStarted = true):
            return
        set IsStarted = true
        spawn{StartScene1(Agent)}

    StartScene1(Agent: agent)<suspends>:void =
        # player_uiを取得
        if (Player := player[Agent], PlayerUI := GetPlayerUI[Player]):

            for(Index : int = 0..Scene1LinesList.Length - 1 ):
                if (Line := Scene1LinesList[Index]):
                    NewUI := CreateMyUI(Line)
                    PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.None})
                    Sleep(GetDuration(Line.Duration))
                    PlayerUI.RemoveWidget(NewUI)
            set IsStarted = false

    GetDuration<private>(Duration: duration):float =
        if (Duration = duration.Short):
            return 3.0
        else:
            return 6.0

    # UI作成
    CreateMyUI(Line: line): canvas=
         # キャンバスウィジェット
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot: #Character
                    Anchors := anchors{Minimum := vector2{X := 0.1, Y := 0.2}, Maximum := vector2{X := 0.1, Y := 0.2} }
                    Offsets := margin{Top := 50.0, Left := 10.0, Bottom := 0.0, Right := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    ZOrder := 0
                    SizeToContent := true
                    Widget := texture_block:
                        DefaultImage := Line.Character
                        DefaultDesiredSize := vector2{X := 200.0, Y := 200.0} 
                canvas_slot: #Sentence
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.2}, Maximum := vector2{X := 0.5, Y := 0.2} }
                    Offsets := margin{Top := 0.0, Left := 20.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := texture_block:
                        DefaultImage := Line.Sentence
                        DefaultDesiredSize := vector2{X := 1280.0, Y := 170.4} 
        return MyCanvas

    DeleteMyUI(Message : widget_message) : void=      
        if:
            PlayerUI := GetPlayerUI[Message.Player]
            MyUI := MaybeMyUIPerPlayer[Message.Player]?
        then:
            # プレイヤー画面から作成したUIを削除
            PlayerUI.RemoveWidget(MyUI)
 
            # データ上のプレイヤーに紐づくUIを削除(false)
            if (set MaybeMyUIPerPlayer[Message.Player] = false){}
 
    Scene1LinesList : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s1_10_c_arrived, Duration := duration.Short},
        line {Character := assets.noah, Sentence := assets.s1_12_n_yesCommander, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_14_c_goOverMission, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_15_c_sereniaDeveloping, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_16_c_breakCeasefire, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_18_c_launchStrike, Duration := duration.Long},
        line {Character := assets.noah, Sentence := assets.s1_20_n_howTreacherous, Duration := duration.Short},
        line {Character := assets.noah, Sentence := assets.s1_22_n_reallyAttack, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_24_c_makesPossible, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_26_c_yourMission, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_28_c_destryWeapon, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_30_c_preventStrike, Duration := duration.Short},
        line {Character := assets.noah, Sentence := assets.s1_32_c_goodLuck, Duration := duration.Short}
    }
