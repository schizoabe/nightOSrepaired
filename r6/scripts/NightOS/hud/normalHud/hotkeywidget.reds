@wrapMethod(HotkeysWidgetController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(HotkeysWidgetController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeQuestVisibilityNOS();
  }

@addMethod(HotkeysWidgetController)
  protected cb func ComputeQuestVisibilityNOS() -> Void {
    this.GetRootWidget().SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideWidget);
  }