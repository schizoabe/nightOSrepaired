/*
* Toutes les variables du mod
* All mod variables
*/

@addMethod(ScriptedPuppet)
private final func isDrone() -> Bool {
  if Equals(this.GetNPCType(), gamedataNPCType.Drone){
    return true;
  }else{
    return false;
  }
}

@addField(ScriptedPuppet)
let isControlled: Bool;

@addField(PlayerPuppet)
let doesItControlADrone: Bool;

