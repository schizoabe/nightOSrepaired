
@addField(PlayerPuppet)
let forceHideHealth: Bool;

@addField(PlayerPuppet)
let forceHideMinimap: Bool;

@addField(PlayerPuppet)
let forceHideQuest: Bool;

@addField(PlayerPuppet)
let forceHideItem: Bool;

@addField(PlayerPuppet)
let forceHideWidget: Bool; 

@addField(PlayerPuppet)
let forceHideHint: Bool; 

@addField(PlayerPuppet)
let forceShowHud: Bool; 

@wrapMethod(PlayerPuppet)
protected cb func OnGameAttached() -> Bool {
  wrappedMethod();
  this.forceHideHealth = false;
  this.forceHideMinimap = false;
  this.forceHideQuest = false;
  this.forceHideItem = false;
  this.forceHideWidget = false;
  this.forceHideHint = false;
  this.forceShowHud = false;
}

@wrapMethod(healthbarWidgetGameController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(healthbarWidgetGameController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeMinimapVisibilityNOS();
  }

@addMethod(healthbarWidgetGameController)
  protected cb func ComputeMinimapVisibilityNOS() -> Void {
    this.GetRootWidget().SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideHealth);
  }