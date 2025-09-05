/*
* Toutes les variables du mod
* All mod variables
*/

@addField(ElevatorFloorTerminal)
let hackType: Int32;

@addField(ElevatorFloorTerminal)
let isHacked: Bool;

@addField(ElevatorFloorTerminal)
let vehicleCooldown: Float;

@addMethod(ElevatorFloorTerminal)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(ElevatorFloorTerminal)
let onOffOneExec: Bool;

@addMethod(ElevatorFloorTerminal)
  private final func getHackTypeName() -> String {
      return "elevator";
  }

@addMethod(ElevatorFloorTerminal)
  private final func getQHackSize() -> Int32 {
      return 1;
  }


