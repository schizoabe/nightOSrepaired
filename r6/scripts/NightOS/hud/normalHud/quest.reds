@wrapMethod(QuestTrackerGameController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(QuestTrackerGameController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeQuestVisibilityNOS();
  }

@addMethod(QuestTrackerGameController)
  protected cb func ComputeQuestVisibilityNOS() -> Void {
    this.m_root.SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideQuest);
  }