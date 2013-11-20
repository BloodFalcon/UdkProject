//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/6/2013
// Credit: 
// http://udn.epicgames.com/
// Status: Alpha
// Being Used: Yes
// Description: Camera for Blood Falcon
//////////////////////////

class BFCamera extends Camera;

/** Hardcoded vector offset we will use, rather than tweaking values in the editor's CameraProperties */
var Vector  CamOffset;

/** Hardcoded rotator offset we will use, rather than tweaking values in the editor's CameraProperties */
var Rotator CamOffsetRotation;

/*****************************************************************
* Query ViewTarget and outputs Point Of View.
* @paramOutVTViewTarget to use.
* @paramDeltaTime  Delta Time since last camera update (in seconds)
*****************************************************************/
function UpdateViewTarget(out TViewTarget OutVT,float DeltaTime)
{
  local Pawn Pawn;
  local Vector V, PotentialCameraLocation, HitLocation, HitNormal;
  local Actor  HitActor;

  /** UpdateViewTarget for the camera class we're extending from */
  Super.UpdateViewTarget(OutVT, DeltaTime);

  /** If there is an interpolation, don't update outgoing viewtarget */
  if (PendingViewTarget.Target!=None&&OutVT==ViewTarget&&BlendParams.bLockOutgoing)
  {
    return;
  }

  Pawn = Pawn(OutVT.Target);
  if (Pawn != None)
  {
    /** Hide the pawn's "extra" weapon */
    if(Pawn.Weapon!=none)
    {
      Pawn.Weapon.SetHidden(true);
    }
/*****************************************************************
* If you know the name of the bone socket you want to use, then
* replace 'WeaponPoint' with yours.
* Otherwise, just use the Pawn's eye view point as your starting 
* point.
*****************************************************************/
/**socket not found, use the other way of updating vectors */
    if(Pawn.Mesh.GetSocketWorldLocationAndRotation('WeaponPoint', OutVT.POV.Location, OutVT.POV.Rotation)==false) 
    {
      /** Start the cam location from the target eye view point */
      OutVT.Target.GetActorEyesViewPoint(OutVT.POV.Location, OutVT.POV.Rotation);
    }

    /** Force the camera to use the target's rotation */
    OutVT.Target.GetActorEyesViewPoint(V, OutVT.POV.Rotation);

    /** Add the camera offset */
    //OutVT.POV.Rotation+=CamOffsetRotation;

    /** Math for the potential camera location */
    PotentialCameraLocation=OutVT.POV.Location +(CamOffset>>OutVT.POV.Rotation);

    /** Draw a trace to see if the potential camera location will work */
    HitActor=Trace(HitLocation, HitNormal, PotentialCameraLocation, OutVT.POV.Location, true,,, 
    TRACEFLAG_BULLET);

    /**  Will the trace hit world geometry? If so then use the hit location and offset it by the hit normal */

    if (HitActor!=None&&HitActor.bWorldGeometry)
    {
      OutVT.POV.Location=HitLocation+HitNormal*16.f;
    }
    else
    {
      OutVT.POV.Location=PotentialCameraLocation;
    }
  }
}

/** Hardcoded vector & rotator values for our camera */
defaultproperties
{
   CamOffset=(x=-400.0,y=0.0,z=400.0)
   CamOffsetRotation=(Pitch=-16384)
}

