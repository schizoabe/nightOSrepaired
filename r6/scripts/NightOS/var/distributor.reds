/*
* Toutes les variables du mod
* All mod variables
*/

@addField(VendingMachine)
let hackType: Int32;

@addField(VendingMachine)
let isHacked: Bool;

@addField(VendingMachine)
let vehicleCooldown: Float;

@addMethod(VendingMachine)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(VendingMachine)
let onOffOneExec: Bool;

@addMethod(VendingMachine)
  private final func getHackTypeName() -> String {
      return "VendingMachine";
  }

@addMethod(VendingMachine)
  private final func getQHackSize() -> Int32 {
      return 2;
  }


