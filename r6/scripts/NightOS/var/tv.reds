/*
* Toutes les variables du mod
* All mod variables
*/

@addField(TV)
let hackType: Int32;

@addField(TV)
let isHacked: Bool;

@addField(TV)
let vehicleCooldown: Float;

@addMethod(TV)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addMethod(TV)
  private final func getHackTypeName() -> String {
      return "TV";
  }

@addMethod(TV)
  private final func getQHackSize() -> Int32 {
      return 4;
  }


