class BFProjectile extends UDKProjectile;

/*simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
  if(Other != Instigator)
  {
   Other.TakeDamage(Damage,InstigatorController,HitLocation,MomentumTransfer * Normal(Velocity), MyDamageType,, self);
  }
}*/

defaultproperties
{
        Damage=25
        MomentumTransfer=10

        Begin Object Name=CollisionCylinder
                CollisionRadius=8
                CollisionHeight=16
        End Object


        Begin Object class=DynamicLightEnvironmentComponent name=MyLightEnvironment
                bEnabled=true
        End Object
        Components.Add(MyLightEnvironment)

        Begin Object class=StaticMeshComponent name=MyMesh
                StaticMesh=StaticMesh'WP_RocketLauncher.Mesh.S_WP_Rocketlauncher_Rocket_old_lit'
                LightEnvironment=MyLightEnvironment
        End Object
        Components.Add(MyMesh)
}

