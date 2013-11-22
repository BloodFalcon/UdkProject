//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Weapon 2
//////////////////////////

class BFEP2Weap extends UDKWeapon;

// Name of the socket which represents the muzzle socket
var(Weapon) const Name MuzzleSocketName;
// Particle system representing the muzzle flash
var(Weapon) const ParticleSystemComponent MuzzleFlash;
// Projectile classes that this weapon fires. DisplayName lets the editor show this as WeaponProjectiles
var(Weapon) const array< class<Projectile> > Projectiles<DisplayName=Weapon Projectiles>;
// Sounds to play back when the weapon is fired
var(Weapon) const array<SoundCue> WeaponFireSounds;

//SINGLE SHOT OR AUTOFIRE
/*simulated function bool StillFiring(byte FireMode)
{
        if(CurrentFireMode == 0)
        {
                StopFire(CurrentFireMode);
	        return false;
	}
	else
	{
	        return ( PendingFire(FireMode) );
	}
}*/


//Set weapon position on equipping
simulated function TimeWeaponEquipping()
{
        AttachWeaponTo(Instigator.Mesh,'EP2_Left_Gun');
        super.TimeWeaponEquipping();
}


//set which socket the weapon should be attached to
simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional Name SocketName)
{
        MeshCpnt.AttachComponentToSocket(Mesh,'EP2_Left_Gun');
}

//set weapons position
simulated event SetPosition(UDKPawn Holder)
{
        local SkeletalMeshComponent compo;
        local SkeletalMeshSocket socket;
        local Vector FinalLocation;

        compo = Holder.Mesh;

        if (compo != none)
        {
                socket = compo.GetSocketByName('EP2_Left_Gun');

                if (socket != none)
                {
                        FinalLocation = compo.GetBoneLocation(socket.BoneName);
                }
        }

        SetLocation(FinalLocation);
        SetRotation(compo.Rotation);
}


//INSTANT FIRE SHOT
/*simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{
        WorldInfo.MyDecalManager.SpawnDecal(DecalMaterial'T_FX.DecalMaterials.M_FX_BloodDecal_FadeViaDissolving', // UMaterialInstance used for this decal.
                                            Impact.HitLocation, // Decal spawned at the hit location.
                                            rotator(-Impact.HitNormal), // Orient decal into the surface.
                                            128, 128, // Decal size in tangent/binormal directions.
                                            256, // Decal size in normal direction.
                                            false, // If TRUE, use "NoClip" codepath.
                                            FRand() * 360, // random rotation
                                            Impact.HitInfo.HitComponent // If non-NULL, consider this component only. 
                                            );
}*/

//AUTOFIRE SHOT
simulated event vector GetPhysicalFireStartLoc(optional vector AimDir)
{
        local SkeletalMeshComponent compo;
        local SkeletalMeshSocket socket;

        compo = SkeletalMeshComponent(Mesh);

        if (compo != none)
        {
                socket = compo.GetSocketByName('EP2_Left_Gun');

                if (socket != none)
                {
                        return compo.GetBoneLocation(socket.BoneName);
                }
        }
}


defaultproperties
{
        FiringStatesArray(0)=WeaponFiring
        WeaponFireTypes(0)=EWFT_Projectile
		WeaponProjectiles(0)=class'UdkProject.BFProjectile3'
        FireInterval(0)=0.5
        Spread(0)=0

//      GUN MESH
        Begin Object class=SkeletalMeshComponent Name=MyMesh
                SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
                HiddenGame=true
                HiddenEditor=true
        End object
        Mesh=MyMesh
        Components.Add(MyMesh)
}