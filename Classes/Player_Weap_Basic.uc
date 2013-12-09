//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Weapon 1
//////////////////////////

class Player_Weap_Basic extends UDKWeapon;

// Name of the socket which represents the muzzle socket
var(Weapon) const Name MuzzleSocketName;
// Particle system representing the muzzle flash
var(Weapon) const ParticleSystemComponent MuzzleFlash;
// Projectile classes that this weapon fires. DisplayName lets the editor show this as WeaponProjectiles
var(Weapon) const array< class<Projectile> > Projectiles<DisplayName=Weapon Projectiles>;
// Sounds to play back when the weapon is fired
var(Weapon) const array<SoundCue> WeaponFireSounds;
//var Player_Weap_Red OurPartner;
//var ParticleSystem AbsorbBeam;

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
        AttachWeaponTo(Instigator.Mesh,'Nose_WP');
        super.TimeWeaponEquipping();
}


//set which socket the weapon should be attached to
simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional Name SocketName)
{
        MeshCpnt.AttachComponentToSocket(Mesh,'Nose_WP');
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
                socket = compo.GetSocketByName('Nose_WP');

                if (socket != none)
                {
                        FinalLocation = compo.GetBoneLocation(socket.BoneName);
                }
        }

        SetLocation(FinalLocation);
        SetRotation(compo.Rotation);
}

simulated event vector GetPhysicalFireStartLoc(optional vector AimDir)
{
        local SkeletalMeshComponent compo;
        local SkeletalMeshSocket socket;

        compo = SkeletalMeshComponent(Mesh);

        if (compo != none)
        {
                socket = compo.GetSocketByName('Nose_WP');

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
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile
	WeaponProjectiles(0)=class'UdkProject.BF_Proj_Basic'
	WeaponProjectiles(1)=class'UdkProject.BF_Proj_Absorb'
	FireInterval(0)=.3
	FireInterval(1)=.1
	Spread(0)=0
	Spread(1)=0
	//AbsorbBeam = ParticleSystem'BloodFalcon.ParticleSystem.AbsorbBeam_Particle'
//      GUN MESH
    Begin Object class=SkeletalMeshComponent Name=MyMesh
            SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
            HiddenGame=true
            HiddenEditor=true
    End object
    Mesh=MyMesh
    Components.Add(MyMesh)
}

