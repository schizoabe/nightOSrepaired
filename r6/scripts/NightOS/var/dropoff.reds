/*
* Toutes les variables du mod
* All mod variables
*/

@addField(DropPoint)
let hackType: Int32;

@addField(DropPoint)
let isHacked: Bool;

@addField(DropPoint)
let vehicleCooldown: Float;

@addField(DropPoint)
let NpcPuppetQHackSize: Int32;

@addField(DropPoint)
let moneyAmount: Int32;


@wrapMethod(DropPoint)
protected cb func OnGameAttached() -> Bool {
  wrappedMethod();
  this.moneyAmount = RandRange(100, 5000);
}

@addMethod(DropPoint)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addMethod(DropPoint)
  private final func getHackTypeName() -> String {
      return "dropoff";
  }

@addMethod(DropPoint)
  private final func getQHackSize() -> Int32 {
      return 2;
  }
