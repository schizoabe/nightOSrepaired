@wrapMethod(GameObject)
  protected cb func OnTakeControl(ri: EntityResolveComponentsInterface) -> Bool {
    wrappedMethod(ri);
    this.uniqueIdentifier = RandRange(0,99999999);
  }

@addField(GameObject)
let uniqueIdentifier: Int32;

@addField(PlayerPuppet)
let npcNearSystemInstance: ref<npcNearSystem>;

@wrapMethod(PlayerPuppet)
  protected cb func OnTakeControl(ri: EntityResolveComponentsInterface) -> Bool {
    wrappedMethod(ri);
    this.npcNearSystemInstance = new npcNearSystem();
  }

@addMethod(PlayerPuppet)
public func getNPCNearSystem() -> ref<npcNearSystem> { 
  return this.npcNearSystemInstance;
}

public class npcNearSystem {
  let arrayObjectToWatch: array<ref<GameObject>>;

  private func Initialize() {
    this.clearTheArray();
  }



  public func getNumberOfObjectsWatched() -> Int32 {
    return ArraySize(this.arrayObjectToWatch);
  }

  public func clearTheArray() -> Void {
    ArrayClear(this.arrayObjectToWatch);
  }

  public func objectAlreadyWatched(obj: ref<GameObject>) -> Bool {
    let i: Int32 = 0;
    if this.getNumberOfObjectsWatched() > 0 {
      while i < this.getNumberOfObjectsWatched() {
        if this.arrayObjectToWatch[i].uniqueIdentifier == obj.uniqueIdentifier {
          return true;
        }
        i += 1;
      };
    }
    return false;
  }

  public func addObject(obj: ref<GameObject>) -> Void {
    if this.objectAlreadyWatched(obj) { }else{ 
      ArrayPush(this.arrayObjectToWatch, obj);
    }
  }
}
