/*
* Toutes les variables du mod
* All mod variables
*/

@addField(FakeDoor)
let hackType: Int32;

@addField(FakeDoor)
let isHacked: Bool;

@addField(FakeDoor)
let vehicleCooldown: Float;

@addMethod(FakeDoor)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(FakeDoor)
let onOffOneExec: Bool;

@addMethod(FakeDoor)
  private final func getHackTypeName() -> String {
      return "fakedoor";
  }

@addMethod(FakeDoor)
  private final func getQHackSize() -> Int32 {
      return 1;
  }


