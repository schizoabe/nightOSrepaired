@wrapMethod(WeaponRosterGameController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(WeaponRosterGameController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeQuestVisibilityNOS();
  }

@addMethod(WeaponRosterGameController)
  protected cb func ComputeQuestVisibilityNOS() -> Void {
    this.GetRootWidget().SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideItem);
  }



@addMethod(CrouchIndicatorGameController)
  protected cb func OnInitialize() -> Bool {
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(CrouchIndicatorGameController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeQuestVisibilityNOS();
  }

@addMethod(CrouchIndicatorGameController)
  protected cb func ComputeQuestVisibilityNOS() -> Void {
    this.GetRootWidget().SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideItem);
  }