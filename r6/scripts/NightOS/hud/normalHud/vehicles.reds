public class showHUDVehicleLift extends Event {}

public class removeHUDVehicleLift extends Event {}

@addField(inkGameController)
let inkTextOpen: ref<inkText>;

@addMethod(inkGameController)
protected cb func showHUDVehicleLift(evt: ref<showHUDVehicleLift>) -> Bool {
    if this.IsA(n"gameuiRootHudGameController") {
        this.inkTextOpen = new inkText();
        this.inkTextOpen.SetText("");
        this.inkTextOpen.SetFontFamily("base\\gameplay\\gui\\fonts\\orbitron\\orbitron.inkfontfamily");
        this.inkTextOpen.SetFontStyle(n"Bold");
        this.inkTextOpen.SetFontSize(20);
        this.inkTextOpen.SetAnchor(inkEAnchor.Centered);
        this.inkTextOpen.SetAnchorPoint(8.6, -14.8);
        this.inkTextOpen.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
        this.inkTextOpen.Reparent(this.GetRootCompoundWidget());
        this.inkTextOpen.SetVisible(true);
    };
}

@addMethod(inkGameController)
protected cb func removeHUDVehicleLift(evt: ref<removeHUDVehicleLift>) -> Bool {
    if this.IsA(n"gameuiRootHudGameController") {
        this.inkTextOpen.SetVisible(false);
    };
}

@addField(hudCarController)
let playerPuppetVehicle: ref<GameObject>;

@replaceMethod(hudCarController)
  protected cb func OnPlayerAttach(playerPuppet: ref<GameObject>) -> Bool {
    this.m_psmBlackboard = this.GetPSMBlackboard(playerPuppet);
    this.playerPuppetVehicle = playerPuppet;
    if IsDefined(this.m_psmBlackboard) {
      this.m_PSM_BBID = this.m_psmBlackboard.RegisterDelayedListenerFloat(GetAllBlackboardDefs().PlayerStateMachine.ZoomLevel, this, n"OnZoomChange");
    };
    this.m_activeVehicle = GetMountedVehicle(this.GetPlayerControlledObject());
    if IsDefined(this.m_activeVehicle) {
      this.GetRootWidget().SetVisible(true);
      this.RegisterToVehicle(true);
      this.Reset();
    };
  }

@replaceMethod(hudCarController)
  protected cb func OnMountingEvent(evt: ref<MountingEvent>) -> Bool {
    this.m_activeVehicle = GetMountedVehicle(this.GetPlayerControlledObject());
    this.m_driver = VehicleComponent.IsDriver(this.m_activeVehicle.GetGame(), this.GetPlayerControlledObject());
    this.GetRootWidget().SetVisible(false);
    this.RegisterToVehicle(true);
    this.Reset();
    GameInstance.GetUISystem(this.playerPuppetVehicle.GetGame()).QueueEvent(new showHUDVehicleLift());
  }

@replaceMethod(hudCarController)
  protected cb func OnUnmountingEvent(evt: ref<UnmountingEvent>) -> Bool {
    if !evt.request.mountData.mountEventOptions.silentUnmount {
      this.GetRootWidget().SetVisible(false);
      this.RegisterToVehicle(false);
      this.m_activeVehicle = null;
      GameInstance.GetUISystem(this.playerPuppetVehicle.GetGame()).QueueEvent(new removeHUDVehicleLift());
    };
  }