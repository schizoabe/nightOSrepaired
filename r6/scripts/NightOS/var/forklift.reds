/*
* Toutes les variables du mod
* All mod variables
*/

@addField(forklift)
let hackType: Int32;

@addField(forklift)
let isHacked: Bool;

@addField(forklift)
let vehicleCooldown: Float;

@addMethod(forklift)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addMethod(forklift)
  private final func getHackTypeName() -> String {
      return "forklift";
  }

@addMethod(forklift)
  private final func getQHackSize() -> Int32 {
      return 3;
  }

 
@addMethod(ForkliftControllerPS)
  protected func ExecuteAction() -> Void {
    let currentAction: ref<ScriptableDeviceAction>;
    if !this.IsDistracting() && this.m_forkliftSetup.m_hasDistractionQuickhack {
      currentAction = this.ActionQuickHackDistraction();
      currentAction.SetObjectActionID(t"DeviceAction.MalfunctionClassHack");
      currentAction.SetDurationValue(this.GetDistractionDuration(currentAction));
      currentAction.SetInactiveWithReason(this.IsON(), "LocKey#7005");
      currentAction.ProcessRPGAction(this.GetGameInstance());
    };
  }