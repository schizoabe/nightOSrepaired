@addMethod(VehicleObject)
public func pushVehicle(speed: Float, upSpeed: Float) -> Void {
  let direction: Vector4 = this.GetWorldForward();
  let directionUp: Vector4 = this.GetWorldUp();
  let vehiclePosition: Vector4 = this.GetWorldPosition();
  let impulse: Vector4;
  let ev: ref<PhysicalImpulseEvent>;
  ev = new PhysicalImpulseEvent();
  
  impulse.X = (direction.X * speed) + (directionUp.X * upSpeed);
  impulse.Y = (direction.Y * speed) + (directionUp.Y * upSpeed);
  impulse.Z = (direction.Z * speed) + (directionUp.Z * upSpeed);

  ev.worldPosition.X = vehiclePosition.X + (direction.X * speed) + (directionUp.X * upSpeed);
  ev.worldPosition.Y = vehiclePosition.Y + (direction.Y * speed) + (directionUp.Y * upSpeed);
  ev.worldPosition.Z = vehiclePosition.Z + (direction.Z * speed) + (directionUp.Z * upSpeed);

  ev.worldImpulse = new Vector3(impulse.X, impulse.Y, impulse.Z);
  this.QueueEvent(ev);
}