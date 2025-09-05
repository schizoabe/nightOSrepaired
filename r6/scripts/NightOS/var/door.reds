/*
* Toutes les variables du mod
* All mod variables
*/

@addField(Door)
let hackType: Int32;

@addField(Door)
let isHacked: Bool;

@addField(Door)
let vehicleCooldown: Float;

@addMethod(Door)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(Door)
let onOffOneExec: Bool;

@addMethod(Door)
  private final func getHackTypeName() -> String {
      return "door";
  }

@addMethod(Door)
  private final func getQHackSize() -> Int32 {
      return 3;
  }


