/*
* Toutes les variables du mod
* All mod variables
*/

@addField(FuseBox)
let hackType: Int32;

@addField(FuseBox)
let isHacked: Bool;

@addField(FuseBox)
let vehicleCooldown: Float;

@addMethod(FuseBox)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(FuseBox)
let onOffOneExec: Bool;

@addMethod(FuseBox)
  private final func getHackTypeName() -> String {
      return "fusebox";
  }

@addMethod(FuseBox)
  private final func getQHackSize() -> Int32 {
      return 3;
  }


