class BFWeapon extends UDKWeapon;

//SINGLE SHOT OR AUTOFIRE
simulated function bool StillFiring(byte FireMode)
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
}


//Set weapon position on equipping
simulated function TimeWeaponEquipping()
{
        AttachWeaponTo(Instigator.Mesh,'WeaponPoint');
        super.TimeWeaponEquipping();
}


//set which socket the weapon should be attached to
simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional Name SocketName)
{
        MeshCpnt.AttachComponentToSocket(Mesh,SocketName);
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
                socket = compo.GetSocketByName('WeaponPoint');

                if (socket != none)
                {
                        FinalLocation = compo.GetBoneLocation(socket.BoneName);
                }
        }

        SetLocation(FinalLocation);
        SetRotation(compo.Rotation);
}


//INSTANT FIRE SHOT
simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
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
}

//AUTOFIRE SHOT
simulated event vector GetPhysicalFireStartLoc(optional vector AimDir)
{
        local SkeletalMeshComponent compo;
        local SkeletalMeshSocket socket;

        compo = SkeletalMeshComponent(Mesh);

        if (compo != none)
        {
                socket = compo.GetSocketByName('MussleFlashSocket');

                if (socket != none)
                {
                        return compo.GetBoneLocation(socket.BoneName);
                }
        }
}


defaultproperties
{
        FiringStatesArray(0)=WeaponFiring
        FiringStatesArray(1)=WeaponFiring
        WeaponFireTypes(0)=EWFT_InstantHit
        WeaponFireTypes(1)=EWFT_Projectile
        WeaponProjectiles(1)=class'UdkProject.BFProjectile'
        FireInterval(0)=0.1
        FireInterval(1)=0.01
        Spread(0)=0
        Spread(1)=0

//      GUN MESH
        Begin Object class=SkeletalMeshComponent Name=GunMesh
                SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_Linkgun_3P'
                HiddenGame=FALSE
                HiddenEditor=FALSE
        End object
        Mesh=GunMesh
        Components.Add(GunMesh)
}
