/*
- Gestion du menu quickhack
- Quickhack menu management
*/

@addMethod(RPGManager)
  public final static func GetPlayerQuickHackListWithQualityNOS(player: wref<PlayerPuppet>) -> array<PlayerQuickhackData> {
    let actions: array<wref<ObjectAction_Record>>;
    let i: Int32;
    let i1: Int32;
    let itemRecord: wref<Item_Record>;
    let parts: array<SPartSlots>;
    let quickhackData: PlayerQuickhackData;
    let quickhackDataEmpty: PlayerQuickhackData;
    let systemReplacementID: ItemID;
    let quickhackDataArray: array<PlayerQuickhackData> = player.GetCachedQuickHackList();
    if ArraySize(quickhackDataArray) > 0 {
      return quickhackDataArray;
    };
    systemReplacementID = EquipmentSystem.GetData(player).GetActiveItem(gamedataEquipmentArea.SystemReplacementCW);
    itemRecord = RPGManager.GetItemRecord(systemReplacementID);
    if EquipmentSystem.IsCyberdeckEquipped(player) {
      itemRecord.ObjectActions(actions);
      i = 0;
      while i < ArraySize(actions) {
        quickhackData = quickhackDataEmpty;
        quickhackData.actionRecord = actions[i];
        quickhackData.quality = itemRecord.Quality().Value();
        ArrayPush(quickhackDataArray, quickhackData);
        i += 100;
      };
      parts = ItemModificationSystem.GetAllSlots(player, systemReplacementID);
      i = 0;
      while i < ArraySize(parts) {
        ArrayClear(actions);
        itemRecord = RPGManager.GetItemRecord(parts[i].installedPart);
        if IsDefined(itemRecord) {
          itemRecord.ObjectActions(actions);
          i1 = 0;
          while i1 < ArraySize(actions) {
            if Equals(actions[i1].ObjectActionType().Type(), gamedataObjectActionType.DeviceQuickHack) || Equals(actions[i1].ObjectActionType().Type(), gamedataObjectActionType.PuppetQuickHack) {
              quickhackData = quickhackDataEmpty;
              quickhackData.actionRecord = actions[i1];
              quickhackData.quality = itemRecord.Quality().Value();
              ArrayPush(quickhackDataArray, quickhackData);
            };
            i1 += 100;
          };
        };
        i += 100;
      };
    };
    ArrayClear(actions);
    itemRecord = RPGManager.GetItemRecord(EquipmentSystem.GetData(player).GetActiveItem(gamedataEquipmentArea.Splinter));
    if IsDefined(itemRecord) {
      itemRecord.ObjectActions(actions);
      i = 0;
      while i < ArraySize(actions) {
        if Equals(actions[i].ObjectActionType().Type(), gamedataObjectActionType.DeviceQuickHack) || Equals(actions[i].ObjectActionType().Type(), gamedataObjectActionType.PuppetQuickHack) {
          quickhackData = quickhackDataEmpty;
          quickhackData.actionRecord = actions[i];
          ArrayPush(quickhackDataArray, quickhackData);
        };
        i += 100;
      };
    };
    RPGManager.RemoveDuplicatedHacks(quickhackDataArray);
    PlayerPuppet.ChacheQuickHackList(player, quickhackDataArray);
    return quickhackDataArray;
  }



public class QHackSystemNOS {

let QHUpload: Bool;
let ta: array<String>;


public final func doesPlayerHaveEnough(player: wref<PlayerPuppet>, cost: Int32) -> Bool {
  let casted: Float = Cast(cost);
  if GameInstance.GetStatPoolsSystem(player.GetGame()).GetStatPoolValue(Cast(player.GetEntityID()), gamedataStatPoolType.Memory, false) >= casted {
    return true;
  }else{
    return false;
  }
}

public final func sendCommand(target: wref<GameObject>, player: wref<PlayerPuppet>, commands: array<ref<QuickhackData>>, shouldShow: Bool) -> Void {
  let quickSlotsManagerNotification: ref<RevealInteractionWheel> = new RevealInteractionWheel();
  quickSlotsManagerNotification.lookAtObject = target;
  quickSlotsManagerNotification.shouldReveal = shouldShow;
  quickSlotsManagerNotification.commands = commands;
  GameInstance.GetUISystem(player.GetGame()).QueueEvent(quickSlotsManagerNotification);
}

public final func createCustomQHackCommand(target: wref<GameObject>, player: wref<PlayerPuppet>, isLocked: Bool, nameOfHack: String, descriptionOfHack: String, costOfHack: Int32) -> ref<QuickhackData> {
  let command = new QuickhackData();
  let newCommand: ref<QuickhackData>;
  let QHList: array<PlayerQuickhackData> = RPGManager.GetPlayerQuickHackListWithQualityNOS(player);
  let clearance: ref<Clearance>; let context: GetActionsContext = (player.GetPS() as PlayerPuppetPS).GenerateContext(gamedeviceRequestType.Remote, clearance, GameInstance.GetPlayerSystem(player.GetGame()).GetLocalPlayerControlledGameObject(), player.GetEntityID());
  let action: ref<PuppetAction> = (player.GetPS() as PlayerPuppetPS).GetAction(QHList[1].actionRecord);
  let actionRecord: wref<ObjectAction_Record> = action.GetObjectActionRecord();
  let puppetAction: ref<PuppetAction> = (player.GetPS() as PlayerPuppetPS).GetAction(QHList[1].actionRecord); puppetAction.SetExecutor(context.processInitiatorObject); puppetAction.RegisterAsRequester(player.GetEntityID()); puppetAction.SetUp((player.GetPS() as PlayerPuppetPS));
  
  newCommand = new QuickhackData();
  newCommand.m_quality = QHList[1].quality;
  newCommand.m_costRaw = costOfHack;
  newCommand.m_networkBreached = false;
  newCommand.m_category = actionRecord.HackCategory();
  newCommand.m_type = actionRecord.ObjectActionType().Type();
  newCommand.m_actionOwner = player.GetEntityID();
  newCommand.m_isInstant = true;
  newCommand.m_ICELevel = player.GetICELevel();
  newCommand.m_ICELevelVisible = true;
  newCommand.m_title = nameOfHack;
  newCommand.m_isLocked = isLocked;
  newCommand.m_actionOwnerName = StringToName(target.GetDisplayName());
  newCommand.m_cost = costOfHack;
  newCommand.m_description = descriptionOfHack;
  newCommand.m_icon = actionRecord.ObjectActionUI().CaptionIcon().TexturePartID().GetID();
  newCommand.m_cooldown = 2.0;
  newCommand.m_duration = 10;
  newCommand.m_uploadTime = puppetAction.GetActivationTime();
  newCommand.m_action = puppetAction;
  newCommand.m_actionMatchesTarget = true;

  if !newCommand.m_isLocked { newCommand.m_isLocked = !this.doesPlayerHaveEnough(player, costOfHack); }

  return newCommand;
}


public final func revealQHackMenuTrafficLight(target: wref<TrafficLight>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  if target.GetDevicePS().IsON() { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(7), "", 1)); }else{ ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(8), "Turn on the device", 1)); }
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(9), "red", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(10), "green", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(11), "yellow", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(12), "glitching", 1));
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuExplosiveDevice(target: wref<ExplosiveDevice>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(13), "explode", 3));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(14), "explode", 3));
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuDoor(target: wref<Door>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  if target.GetDevicePS().IsSkillCheckActive() {
    /* Lock Door */   if (target.GetDevicePS() as DoorControllerPS).IsClosed() { ArrayPush(commands, this.createCustomQHackCommand(target, player, true, translation.createArray(15), "", 1)); } else { ArrayPush(commands, this.createCustomQHackCommand(target, player, true, translation.createArray(16), "", 1)); }
  }else{
    /* Lock Door */   if (target.GetDevicePS() as DoorControllerPS).IsClosed() { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(15), "", 1)); } else { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(16), "", 1)); }
  }
  /* Unlock Door */ if (target.GetDevicePS() as DoorControllerPS).m_isLocked { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(17), "", 1)); } else { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(18), "", 1)); }
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(25), "", 1));
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuFDoor(target: wref<FakeDoor>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(19), "", 1));
  
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuVendingMachine(target: wref<VendingMachine>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(27), "", 6));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(25), "", 2));

  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuElevator(target: wref<ElevatorFloorTerminal>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(20), "", 1));
  
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuForklift(target: wref<forklift>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(21), "", 3));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(25), "", 1));
  if !((target.GetController() as ForkliftController).GetPS() as ForkliftControllerPS).m_isUp { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(22), "", 1)); } else { ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(23), "", 1)); }

  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenufusebox(target: wref<FuseBox>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(24), "", 3));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(6), "", 3));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(25), "", 1));
  
  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}

public final func revealQHackMenuTV(target: wref<TV>, player: wref<PlayerPuppet>, shouldShow: Bool, isLockedDotCom: Bool) -> Bool {
  if Equals(this.QHUpload, true) { return false; };
  this.QHUpload = true;
  let commands: array<ref<QuickhackData>>;
  let translation: ref<NOSTranslation> = new NOSTranslation();

  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(12), "", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(24), "", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(26), "", 1));
  ArrayPush(commands, this.createCustomQHackCommand(target, player, isLockedDotCom, translation.createArray(25), "", 2));

  this.sendCommand(target, player, commands, shouldShow);
  this.QHUpload = false;
}
}