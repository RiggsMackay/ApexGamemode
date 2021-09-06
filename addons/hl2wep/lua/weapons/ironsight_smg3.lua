include ( 'ironsight_base.lua' )



if SERVER then

	AddCSLuaFile( "sight_smg.lua" )

    SWEP.Weight = 5

	SWEP.AutoSwitchTo = false

	SWEP.AutoSwitchFrom = false

end



if CLIENT then

	SWEP.PrintName = "SMG 3"

	SWEP.Slot = 2

	SWEP.SlotPos = 3

	SWEP.DrawAmmo = true

	SWEP.DrawCrosshair = false

	SWEP.BounceWeaponIcon = false

end



SWEP.Author = "Nova_Canerra, TheVingard"

SWEP.Contact = "apex-roleplay.com"

SWEP.Purpose = ""

SWEP.Instructions = ""



SWEP.Category = "Apex Roleplay | HL2 Weapons"



SWEP.UseHands = false



SWEP.Base = "weapon_base"



SWEP.Spawnable = true

SWEP.AdminSpawnable = true

SWEP.HoldType = "smg";



SWEP.ViewModel = "models/apexwep/weapons/v_smg3.mdl"

SWEP.WorldModel = "models/apexwep/weapons/w_smg3.mdl"

SWEP.ViewModelFOV = 66



SWEP.Primary.ClipSize = 45

SWEP.Primary.DefaultClip = 45

SWEP.Primary.Automatic = true

SWEP.Primary.Ammo = "smg1"



SWEP.Secondary.ClipSize = -1

SWEP.Secondary.DefaultClip = -1

SWEP.Secondary.Automatic = false

SWEP.Secondary.Ammo = "none"



SWEP.Primary.Cone = 0.02



SWEP.IronSightsPos = Vector ( -5.41, -3, 2.3 )

SWEP.IronSightsAng = Vector ( 0, 0, 1 )



function SWEP:Precache()



	util.PrecacheSound( "Weapon_Pistol.Empty" )

	util.PrecacheSound( "Weapon_P90.Single" )

	util.PrecacheSound( "Weapon_SMG1.Reload" )

	util.PrecacheSound( "Weapon_SMG1.Burst" )



end



function SWEP:Initialize()



end



function SWEP:Reload()

	self:SetIronsights( false )

	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then

		self:DefaultReload( ACT_VM_RELOAD )

		self:EmitSound( "Weapon_SMG1.Reload" )

	end

end



function SWEP:ShootBullet(damage, num_bullets, aimcone)



	local bullet = {}

	bullet.Num 	= num_bullets

	bullet.Src 	= self.Owner:GetShootPos() -- Source

	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet

	bullet.Spread 	= Vector(0.065, 0.065, 0)	 -- Aim Cone

	bullet.TracerName = "Tracer"

	bullet.Tracer	= 1 -- Show a tracer on every x bullets

	bullet.Force	= 1 -- Amount of force to give to phys objects

	bullet.Damage	= 15

	bullet.AmmoType = "smg1"



	self:TakePrimaryAmmo(1)

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end



function SWEP:Think()



end



function SWEP:CanPrimaryAttack()

	if ( self:Clip1() <= 0 ) then

		self:EmitSound( "Weapon_Pistol.Empty" )

		self:SetIronsights( false )

		self:Reload()

		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

		return false

	end

	return true

end



function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack() ) then return end



		self:SetNextPrimaryFire(CurTime() + .07)

		self:EmitSound( "Weapon_P90.Single" )

		self:ShootBullet(4, 1, .04)



	if (self.Owner:Crouching()) then

		self.Owner:ViewPunch( Angle( -.5, 0, 0 ) )

	else

		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )

	end

end