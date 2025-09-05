/*
* Toutes les variables du mod
* All mod variables
*/

@addField(TrafficLight)
let hackType: Int32;

@addField(TrafficLight)
let isHacked: Bool;

@addField(TrafficLight)
let vehicleCooldown: Float;

@addMethod(TrafficLight)
  private final func isHackableONS() -> Bool {
      return true;
  }

@addField(TrafficLight)
let onOffOneExec: Bool;


@addMethod(TrafficLight)
  private final func getHackTypeName() -> String {
      return "trafficlight";
  }

@addMethod(TrafficLight)
  private final func getQHackSize() -> Int32 {
      return 5;
  }