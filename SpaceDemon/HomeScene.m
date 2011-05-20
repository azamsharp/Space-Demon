//
//  HomeScreen.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/21/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "HomeScene.h"


@implementation HomeScene


+(id) scene 
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HomeScene *layer = [HomeScene node];
	
	CCParticleFire *fire = [[CCParticleFire alloc]init];
	[fire setTotalParticles:30];
	[fire setScaleX:4.0];
	[fire setScaleY:4.0];
	[fire setEmissionRate:10];
	[layer addChild:fire];
	
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
	
}

- (void)startGame:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[GameScene node]];
}

-(void) addMenu
{
	CCMenuItemFont *startNew = [CCMenuItemFont itemFromString:@"Start Game" target:self selector: @selector(startGame:)];	
	CCMenu *menu = [CCMenu menuWithItems:startNew, nil];
	[self addChild:menu];
}

-(id) init 
{
	if( (self=[super init] )) 
	{
		[self addMenu]; 
	}
	
	return self; 
}


@end
