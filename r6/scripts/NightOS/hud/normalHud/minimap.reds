@wrapMethod(MinimapContainerController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);
  }

@addMethod(MinimapContainerController)
  protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
    this.ComputeMinimapVisibilityNOS();
  }

@addMethod(MinimapContainerController)
  protected cb func ComputeMinimapVisibilityNOS() -> Void {
    this.m_rootWidget.SetVisible(!(this.GetOwnerEntity() as PlayerPuppet).forceHideMinimap);
  }

public class UpdateElementEvent extends Event {}

@addMethod(scannerGameController)
protected cb func OnUpdateElement(evt: ref<UpdateElementEvent>) -> Bool {
    if (this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift {
      this.GetRootWidget().SetVisible(true);
    }

    this.user.SetText((this.GetOwnerEntity() as PlayerPuppet).ForkliftUserName);
    this.signal.SetText((this.GetOwnerEntity() as PlayerPuppet).ForkliftSignal);
    this.isup.SetText((this.GetOwnerEntity() as PlayerPuppet).ForkliftUp);
    this.energy.SetText((this.GetOwnerEntity() as PlayerPuppet).ForkliftEnergy);

    this.hintwtext.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.hintstext.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.hintftext.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.hintf.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.hints.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.hintw.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.forklift_hud.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.header_hud.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.user.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.auth.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.authType.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.signal.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.energy.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
    this.isup.SetVisible((this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift);
  }

@addField(scannerGameController)
let forklift_hud: ref<inkImage>; 

@addField(scannerGameController)
let hintf: ref<inkImage>; 

@addField(scannerGameController)
let hintw: ref<inkImage>; 

@addField(scannerGameController)
let hints: ref<inkImage>; 


@addField(scannerGameController)
let header_hud: ref<inkImage>; 

@addField(scannerGameController)
let user: ref<inkText>; 

@addField(scannerGameController)
let auth: ref<inkText>; 

@addField(scannerGameController)
let authType: ref<inkText>; 

@addField(scannerGameController)
let signal: ref<inkText>; 

@addField(scannerGameController)
let energy: ref<inkText>; 

@addField(scannerGameController)
let isup: ref<inkText>; 

@addField(scannerGameController)
let hintftext: ref<inkText>; 

@addField(scannerGameController)
let hintstext: ref<inkText>; 

@addField(scannerGameController)
let hintwtext: ref<inkText>; 

@wrapMethod(scannerGameController)
  protected cb func OnInitialize() -> Bool {
    wrappedMethod();
    (this.GetOwnerEntity() as PlayerPuppet).RegisterInputListener(this);

    this.hintf = new inkImage();
    this.hintf.SetAtlasResource(r"base/gameplay/gui/common/input/icons_keyboard.inkatlas");
    this.hintf.SetTexturePart(n"kb_f");
    this.hintf.SetInteractive(false);
    this.hintf.SetHAlign(inkEHorizontalAlign.Right);
    this.hintf.SetVAlign(inkEVerticalAlign.Bottom);
    this.hintf.SetAnchorPoint(new Vector2(13.5, -22.0));
    this.hintf.SetFitToContent(true);
    this.hintf.Reparent(this.GetRootCompoundWidget());
    this.hintf.SetMargin(0, 0, 0, 0);

    this.hintftext = new inkText();
    this.hintftext.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.hintftext.SetFontStyle(n"Semi-Bold");
    this.hintftext.SetFontSize(50);
    this.hintftext.SetLetterCase(textLetterCase.UpperCase);
    this.hintftext.SetText("Up/Down Lift");
    this.hintftext.SetFitToContent(true);
    this.hintftext.SetHAlign(inkEHorizontalAlign.Center);
    this.hintftext.SetVAlign(inkEVerticalAlign.Center);
    this.hintftext.SetTintColor(new HDRColor(1.0, 1.0, 1.0, 1.0));
    this.hintftext.SetSize(new Vector2(15, 4.5));
    this.hintftext.SetTranslation(new Vector2(-775.0, 1412));
    this.hintftext.Reparent(this.GetRootCompoundWidget());

    this.hints = new inkImage();
    this.hints.SetAtlasResource(r"base/gameplay/gui/common/input/icons_keyboard.inkatlas");
    this.hints.SetTexturePart(n"kb_s");
    this.hints.SetInteractive(false);
    this.hints.SetHAlign(inkEHorizontalAlign.Right);
    this.hints.SetVAlign(inkEVerticalAlign.Bottom);
    this.hints.SetAnchorPoint(new Vector2(13.5, -20.5));
    this.hints.SetFitToContent(true);
    this.hints.Reparent(this.GetRootCompoundWidget());
    this.hints.SetMargin(0, 0, 0, 0);

    this.hintstext = new inkText();
    this.hintstext.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.hintstext.SetFontStyle(n"Semi-Bold");
    this.hintstext.SetFontSize(50);
    this.hintstext.SetLetterCase(textLetterCase.UpperCase);
    this.hintstext.SetText("Backward");
    this.hintstext.SetFitToContent(true);
    this.hintstext.SetHAlign(inkEHorizontalAlign.Center);
    this.hintstext.SetVAlign(inkEVerticalAlign.Center);
    this.hintstext.SetTintColor(new HDRColor(1.0, 1.0, 1.0, 1.0));
    this.hintstext.SetSize(new Vector2(15, 4.5));
    this.hintstext.SetTranslation(new Vector2(-775.0, 1315));
    this.hintstext.Reparent(this.GetRootCompoundWidget());

    this.hintw = new inkImage();
    this.hintw.SetAtlasResource(r"base/gameplay/gui/common/input/icons_keyboard.inkatlas");
    this.hintw.SetTexturePart(n"kb_w");
    this.hintw.SetInteractive(false);
    this.hintw.SetHAlign(inkEHorizontalAlign.Right);
    this.hintw.SetVAlign(inkEVerticalAlign.Bottom);
    this.hintw.SetAnchorPoint(new Vector2(13.5, -19.0));
    this.hintw.SetFitToContent(true);
    this.hintw.Reparent(this.GetRootCompoundWidget());
    this.hintw.SetMargin(0, 0, 0, 0);

    this.hintwtext = new inkText();
    this.hintwtext.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.hintwtext.SetFontStyle(n"Semi-Bold");
    this.hintwtext.SetFontSize(50);
    this.hintwtext.SetLetterCase(textLetterCase.UpperCase);
    this.hintwtext.SetText("Forward");
    this.hintwtext.SetFitToContent(true);
    this.hintwtext.SetHAlign(inkEHorizontalAlign.Center);
    this.hintwtext.SetVAlign(inkEVerticalAlign.Center);
    this.hintwtext.SetTintColor(new HDRColor(1.0, 1.0, 1.0, 1.0));
    this.hintwtext.SetSize(new Vector2(15, 4.5));
    this.hintwtext.SetTranslation(new Vector2(-775.0, 1215));
    this.hintwtext.Reparent(this.GetRootCompoundWidget());

    this.forklift_hud = new inkImage();
    this.forklift_hud.SetAtlasResource(r"base/gameplay/gui/fullscreen/loading/forklift_hud.inkatlas");
    this.forklift_hud.SetTexturePart(n"forklift");
    this.forklift_hud.SetInteractive(false);
    this.forklift_hud.SetHAlign(inkEHorizontalAlign.Right);
    this.forklift_hud.SetVAlign(inkEVerticalAlign.Bottom);
    this.forklift_hud.SetAnchorPoint(new Vector2(0.73, 0.615));
    this.forklift_hud.SetFitToContent(true);
    this.forklift_hud.Reparent(this.GetRootCompoundWidget());
    this.forklift_hud.SetMargin(0, 0, 0, 0);

    this.header_hud = new inkImage();
    this.header_hud.SetAtlasResource(r"base/gameplay/gui/fullscreen/loading/header_hud.inkatlas");
    this.header_hud.SetTexturePart(n"header");
    this.header_hud.SetInteractive(false);
    this.header_hud.SetHAlign(inkEHorizontalAlign.Right);
    this.header_hud.SetVAlign(inkEVerticalAlign.Bottom);
    this.header_hud.SetAnchorPoint(new Vector2(-0.8, 1.095));
    this.header_hud.SetFitToContent(true);
    this.header_hud.Reparent(this.GetRootCompoundWidget());
    this.header_hud.SetMargin(0, 0, 0, 0);

    this.user = new inkText();
    this.user.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.user.SetFontStyle(n"Semi-Bold");
    this.user.SetFontSize(50);
    this.user.SetLetterCase(textLetterCase.UpperCase);
    this.user.SetText("User: ############");
    this.user.SetFitToContent(true);
    this.user.SetHAlign(inkEHorizontalAlign.Center);
    this.user.SetVAlign(inkEVerticalAlign.Center);
    this.user.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.user.SetSize(new Vector2(100.0, 32.0));
    this.user.SetTranslation(new Vector2(1600, -150.0));
    this.user.Reparent(this.GetRootCompoundWidget());

    this.auth = new inkText();
    this.auth.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.auth.SetFontStyle(n"Semi-Bold");
    this.auth.SetFontSize(50);
    this.auth.SetLetterCase(textLetterCase.UpperCase);
    this.auth.SetText("Authorization: Administrator");
    this.auth.SetFitToContent(true);
    this.auth.SetHAlign(inkEHorizontalAlign.Center);
    this.auth.SetVAlign(inkEVerticalAlign.Center);
    this.auth.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.auth.SetSize(new Vector2(100.0, 32.0));
    this.auth.SetTranslation(new Vector2(1600, -100.0));
    this.auth.Reparent(this.GetRootCompoundWidget());

    this.authType = new inkText();
    this.authType.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.authType.SetFontStyle(n"Semi-Bold");
    this.authType.SetFontSize(50);
    this.authType.SetLetterCase(textLetterCase.UpperCase);
    this.authType.SetText("Login Interface: Neuronal");
    this.authType.SetFitToContent(true);
    this.authType.SetHAlign(inkEHorizontalAlign.Center);
    this.authType.SetVAlign(inkEVerticalAlign.Center);
    this.authType.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.authType.SetSize(new Vector2(100.0, 32.0));
    this.authType.SetTranslation(new Vector2(1600, -50.0));
    this.authType.Reparent(this.GetRootCompoundWidget());

    this.signal = new inkText();
    this.signal.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.signal.SetFontStyle(n"Semi-Bold");
    this.signal.SetFontSize(50);
    this.signal.SetLetterCase(textLetterCase.UpperCase);
    this.signal.SetText("Signal: 100%");
    this.signal.SetFitToContent(true);
    this.signal.SetHAlign(inkEHorizontalAlign.Center);
    this.signal.SetVAlign(inkEVerticalAlign.Center);
    this.signal.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.signal.SetSize(new Vector2(100.0, 32.0));
    this.signal.SetTranslation(new Vector2(1600, 50));
    this.signal.Reparent(this.GetRootCompoundWidget());

    this.energy = new inkText();
    this.energy.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.energy.SetFontStyle(n"Semi-Bold");
    this.energy.SetFontSize(50);
    this.energy.SetLetterCase(textLetterCase.UpperCase);
    this.energy.SetText("Battery: 100%");
    this.energy.SetFitToContent(true);
    this.energy.SetHAlign(inkEHorizontalAlign.Center);
    this.energy.SetVAlign(inkEVerticalAlign.Center);
    this.energy.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.energy.SetSize(new Vector2(100.0, 32.0));
    this.energy.SetTranslation(new Vector2(1600, 100));
    this.energy.Reparent(this.GetRootCompoundWidget());

    this.isup = new inkText();
    this.isup.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    this.isup.SetFontStyle(n"Semi-Bold");
    this.isup.SetFontSize(50);
    this.isup.SetLetterCase(textLetterCase.UpperCase);
    this.isup.SetText("Is Lift Up: Yes");
    this.isup.SetFitToContent(true);
    this.isup.SetHAlign(inkEHorizontalAlign.Center);
    this.isup.SetVAlign(inkEVerticalAlign.Center);
    this.isup.SetTintColor(new HDRColor(0.321569, 0.866667, 0.87451, 1.0));
    this.isup.SetSize(new Vector2(100.0, 32.0));
    this.isup.SetTranslation(new Vector2(1600, 150));
    this.isup.Reparent(this.GetRootCompoundWidget());
  }

@replaceMethod(scannerGameController)
  private final func ShowScanner(show: Bool) -> Void {
    if !(this.GetOwnerEntity() as PlayerPuppet).doesPlayerControlAForkLift {
      let uiBlackboard: ref<IBlackboard>;
      if NotEquals(this.m_isShown, show) {
        this.m_isShown = show;
        uiBlackboard = this.GetBlackboardSystem().Get(GetAllBlackboardDefs().UI_Scanner);
        uiBlackboard.SetBool(GetAllBlackboardDefs().UI_Scanner.UIVisible, show);
        if show {
          GameObjectEffectHelper.StartEffectEvent(this.m_playerPuppet, n"focus_mode");
          GameInstance.GetUISystem(this.m_gameInstance).RequestNewVisualState(n"inkScanningState");
        } else {
          GameObjectEffectHelper.BreakEffectLoopEvent(this.m_playerPuppet, n"focus_mode");
          GameInstance.GetUISystem(this.m_gameInstance).RestorePreviousVisualState(n"inkScanningState");
        };
      };
      this.m_scannerProgressMain.SetVisible(show);
      this.GetRootWidget().SetVisible(show);
      this.forklift_hud.SetVisible(false);
      this.header_hud.SetVisible(false);
      this.user.SetVisible(false);
      this.auth.SetVisible(false);
      this.authType.SetVisible(false);
      this.signal.SetVisible(false);
      this.energy.SetVisible(false);
      this.isup.SetVisible(false);
    }
  }

@replaceMethod(scannerGameController)
  protected cb func OnScannerHudSpawned(widget: ref<inkWidget>, userData: ref<IScriptable>) -> Bool {
    let rootWidget: wref<inkCompoundWidget> = this.GetRootWidget() as inkCompoundWidget;
    this.m_scannerBorderMain = widget as inkCompoundWidget;
    this.m_scannerBorderController = this.m_scannerBorderMain.GetController() as scannerBorderLogicController;
    this.m_scannerFullScreenOverlay = this.m_scannerBorderMain.GetWidget(n"fullscreenHeavyOverlay");
    this.m_scannerProgressMain = rootWidget.GetWidget(n"module") as inkCompoundWidget;
    this.m_center_frame = this.m_scannerBorderMain.GetWidget(n"crosshair\\center_frame") as inkImage;
    let i: Int32 = 0;
    while i < 18 {
      ArrayPush(this.m_squares, this.m_scannerBorderMain.GetWidget(StringToName("crosshair\\dots_square\\square" + IntToString(i + 1))) as inkImage);
      ArrayPush(this.m_squaresFilled, this.m_scannerBorderMain.GetWidget(StringToName("crosshair\\dots_filled\\square" + IntToString(i + 1))) as inkImage);
      i += 1;
    };
  }