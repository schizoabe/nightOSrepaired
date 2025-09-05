@addMethod(PlayerPuppet)
public func checkForObjectInLine(sourceObject: wref<GameObject>, start: Vector4, end: Vector4) -> Bool {
    let raycastResult: TraceResult;
    let raycastSuccess: Bool;
    if GameInstance.GetSpatialQueriesSystem(sourceObject.GetGame()).SyncRaycastByCollisionGroup(start, end, n"Static", raycastResult, true, false) {
      return true;
    };
    return false;
}

@addMethod(SpatialQueriesSystem)
  public final static func HasSpaceInFronta(sourceObject: wref<GameObject>, queryDirection: Vector4, groundClearance: Float, areaWidth: Float, areaLength: Float, areaHeight: Float) -> Bool {
    let boxDimensions: Vector4;
    let boxOrientation: EulerAngles;
    let fitTestOvelap: TraceResult;
    let overlapSuccessStatic: Bool;
    let overlapSuccessVehicle: Bool;
    queryDirection.Z = 0.00;
    queryDirection = Vector4.Normalize(queryDirection);
    boxDimensions.X = areaWidth * 0.50;
    boxDimensions.Y = areaLength * 0.50;
    boxDimensions.Z = areaHeight * 0.50;
    let queryPosition: Vector4 = sourceObject.GetWorldPosition();
    queryPosition.Z += boxDimensions.Z + groundClearance;
    queryPosition += boxDimensions.Y * queryDirection;
    boxOrientation = Quaternion.ToEulerAngles(Quaternion.BuildFromDirectionVector(queryDirection));
    overlapSuccessStatic = GameInstance.GetSpatialQueriesSystem(sourceObject.GetGame()).Overlap(boxDimensions, queryPosition, boxOrientation, n"Static", fitTestOvelap);
    overlapSuccessVehicle = GameInstance.GetSpatialQueriesSystem(sourceObject.GetGame()).Overlap(boxDimensions, queryPosition, boxOrientation, n"Vehicle", fitTestOvelap);
    return !overlapSuccessStatic && !overlapSuccessVehicle;
  }