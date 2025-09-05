/*
* Toutes les variables du mod
* All mod variables
*/


@addField(PlayerPuppet)
let QHUpload: Bool;

@addField(PlayerPuppet)
let isInScene: Bool;

@addField(PlayerPuppet)
let doesPlayerControlAForkLift: Bool;

@addField(PlayerPuppet)
let ForkliftUserName: String;

@addField(PlayerPuppet)
let ForkliftSignal: String;

@addField(PlayerPuppet)
let ForkliftUp: String;

@addField(PlayerPuppet)
let ForkliftEnergy: String;

@addField(forklift)
let energy: Int32;

@addField(PlayerPuppet)
let canStopSlowDown: Bool;

@wrapMethod(forklift)
  protected cb func OnGameAttached() -> Bool {
    wrappedMethod();
    this.energy = 100;
  }