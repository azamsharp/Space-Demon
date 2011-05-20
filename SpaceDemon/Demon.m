//
//  Demon.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "Demon.h"

@implementation Demon

@synthesize sprite,layer,fireball,spaceship;

-(Demon *) initWithSpriteFileName:(NSString *) imagePath currentLayer:(CCLayer *) l
{
	self = [super init];	
	self.sprite = [CCSprite spriteWithFile:imagePath];
	self.layer = l;
	return self; 
}

-(void) hit 
{
	//[self destroy];
	
	// demon is hit 
	id rotateByAction = [CCRotateBy actionWithDuration:1.0 angle:360];
	id callback = [CCCallFunc actionWithTarget:self selector:@selector(removeDemonFromSceneCallback:)];
	
	[self.sprite runAction:[CCSequence actions:rotateByAction,nil]];
	
}

-(void) destroy
{
	CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init]; 
	[explosion setTotalParticles:10];
	[explosion setAutoRemoveOnFinish:YES];
	[explosion setEndSize:-1];
	[explosion setLife:2];
	[explosion setDuration:1];
	explosion.position = self.sprite.position; 
	
	[self.layer addChild:explosion];
	
	[self.layer removeChild:self.sprite cleanup:YES];
	self.sprite = nil;
}

-(void) fire 
{
	[[SimpleAudioEngine sharedEngine] playEffect:@"fireball.wav"];
	
	
	if(fireball != nil) 
	{
		[layer removeChild:fireball cleanup:YES];
		fireball = nil; 
	}
	 
	
		fireball = [[CCParticleSun alloc] init]; 
	[fireball setStartSize:5];
		[fireball setAutoRemoveOnFinish:TRUE];
		
		fireball.position = sprite.position; 
		
		id moveToAction = [CCMoveTo actionWithDuration:2.0 position:ccp(sprite.position.x,-100)];
		id callback = [CCCallFunc actionWithTarget:self selector:@selector(fire)];
		
		[fireball runAction:[CCSequence actions:moveToAction,callback,nil]];
		
		[self.layer addChild:fireball];
		
}

// make the demon move randomly on the screen
-(void) start
{
		
	int x = arc4random() % (int) windowSize.width; 
	int y = arc4random() % (int) windowSize.height;
	
	id moveToAction = [CCMoveTo actionWithDuration:2.0 position:ccp(x,y)];
	id callback = [CCCallFunc actionWithTarget:self selector:@selector(start)];
	
	[self.sprite runAction:[CCSequence actions:moveToAction,callback,nil]];
	
	// start firing 
	[self fire]; 
	
}

@end
