//
//  Spaceship.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "Spaceship.h"


@implementation Spaceship




@synthesize sprite,laser,layer,smoke,explosion,isImmortal;


-(Spaceship *) initWithSpriteFileName:(NSString *) imagePath currentLayer:(CCLayer *) l
{
	self = [super init];	
	self.sprite = [CCSprite spriteWithFile:imagePath];
	self.layer = l; 
	self.isImmortal = YES; 
	
	// add a blink effect for immortality 
	[self.sprite runAction:[CCBlink actionWithDuration:3.0 blinks:10]];
	
	// make the space ship mortal after 4 seconds
	[self performSelector:@selector(makeMortal) withObject:nil afterDelay:4.0];
	
	return self; 
}

-(Spaceship *) init 
{
	self = [super init]; 
	return self; 
}


-(void) makeMortal 
{
	self.isImmortal = NO; 
}


-(void) hit 
{
	id rotateByAction = [CCRotateBy actionWithDuration:1.0 angle:360];
	id callback = [CCCallFunc actionWithTarget:self selector:@selector(destroy)];
	
	[self.sprite runAction:[CCSequence actions:rotateByAction,callback,nil]];
	[self destroy];


}

-(void) destroy 
{
	 explosion = [[CCParticleFire alloc] init]; 
	[explosion setTotalParticles:10];
	[explosion setAutoRemoveOnFinish:YES];
	[explosion setLife:5];
	[explosion setDuration:1];
	
	[explosion setEndSize:-1];
	
	explosion.position = self.sprite.position; 
	[self.layer addChild:explosion]; 
	
	// kill the ship 
	[self.layer removeChild:self.sprite cleanup:YES]; 
	
	self.sprite = nil; 
	
}

-(void) generateSmoke
{
	smoke = [[CCParticleFire alloc] init];
	[smoke setTotalParticles:10];
	smoke.position = ccp(self.sprite.position.x, smoke.contentSize.height); 
	[smoke setGravity:ccp(0,-90)];
	[self.layer addChild:smoke]; 
}

-(void) destroyLaser
{
	[self.layer removeChild:self.laser cleanup:YES]; 
	self.laser = nil; 
}

-(void) fire 
{
	[[SimpleAudioEngine sharedEngine] playEffect:@"laser.wav"];
	
	self.laser = [[CCParticleMeteor alloc] init];
	[self.laser setStartSize:-99];
	
	self.laser.position = ccp(self.sprite.position.x,self.sprite.position.y);
	[self.laser setGravity:ccp(0,-90)];
	
	[self.laser setStartSize:10];
	
	CGSize windowSize = [[CCDirector sharedDirector] winSize];
	
	id moveToAction = [CCMoveTo actionWithDuration:1.0 position:ccp(self.sprite.position.x, windowSize.height + 300)]; 
	id moveToActionDone = [CCCallFunc actionWithTarget:self selector:@selector(destroyLaser)];
	
	[self.laser runAction:[CCSequence actions:moveToAction,moveToActionDone,nil]];
	
	[self.layer addChild:self.laser];
}


-(void) move:(CGPoint)location
{
	id moveToAction = [CCMoveTo	actionWithDuration:0.5 position:ccp(location.x,sprite.position.y)];
	
	[self.sprite runAction:moveToAction];
}

@end
