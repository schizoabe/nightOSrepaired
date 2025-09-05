/*
* Toutes les variables du mod
* All mod variables
*/

@addField(ExplosiveDevice)
let hackType: Int32;

@addField(ExplosiveDevice)
let isHacked: Bool;

@addField(ExplosiveDevice)
let vehicleCooldown: Float;

@addMethod(ExplosiveDevice)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addMethod(ExplosiveDevice)
  private final func IsSurveillanceCamera() -> Bool {
      return false;
  }

@addMethod(ExplosiveDevice)
public const func IsTurret() -> Bool {
  return false;
}

@addMethod(ExplosiveDevice)
  private final func getHackTypeName() -> String {
      return "explodecho";
  }

@addMethod(ExplosiveDevice)
  private final func getQHackSize() -> Int32 {
      return 2;
  }
