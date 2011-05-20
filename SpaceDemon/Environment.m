//
//  Environment.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "Environment.h"
#import "Scoreboard.h" 


@implementation Environment 

@synthesize layer;

-(Environment *) initWithLayer:(CCLayer *) l
{
	self = [super init]; 
	self.layer = l; 


	

	return self; 
}

-(void) displayGameOverMessage
{

	CGSize windowSize = [[CCDirector sharedDirector] winSize];



	CCLabelTTF *label = [[CCLabelTTF alloc] initWithString:@"Game Over" fontName:@"Marker Felt" fontSize:26];
	label.position = ccp(windowSize.width/2, windowSize.height/2); 
	[self.layer addChild:label];
	
}

-(void) preloadSounds
{
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"fireball.png"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"laser.wav"];
	
}

-(void) removeLifeByTag:(int) tag
{
	if(tag > 0) 
	{
	NSLog(@"removeLifeByTag tag = %d",tag);
	[self.layer removeChildByTag:tag cleanup:YES];
	}
}


-(void) pauseGame:(id) sender 
{
	BOOL isPaused = [[CCDirector sharedDirector] isPaused];
	
	if(!isPaused) 
	{
		// pause the game
		ccColor4B c = {100,100,0,100}; 
		PauseLayer *pauseLayer = [[[PauseLayer alloc] initWithColor:c] autorelease]; 
		[self.layer.parent addChild:pauseLayer z:10 tag:100]; 
		[[CCDirector sharedDirector] pause];
			
	}
	
}


-(void) drawPauseButtons
{
	CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"red_button.png" selectedImage:@"red_button.png" target:self selector:@selector(pauseGame:)];
		
	CCMenu *menu = [CCMenu menuWithItems:menuItem1,nil]; 
	menu.position = ccp(windowSize.width - menuItem1.contentSize.width,windowSize.height - menuItem1.contentSize.height); 
	[self.layer addChild:menu];
}


-(void) drawLives:(int) lives 
{
	// draw the lives 
	int x = 0; 
	
	for (int i=1; i<=lives; i++) {

		CCSprite *life = [CCSprite spriteWithFile:@"small_spaceship.png"];
		[life setTag:i];
		life.position = ccp(x + life.contentSize.width,windowSize.height - life.contentSize.height); 
		[self.layer addChild:life];
		x = x + life.contentSize.width; 
	}
	
}

-(void) setup 
{
	
	 int x=0; 
	 int y = 0; 
	 
		 
		
		 
		 
	// preload sounds
	[self preloadSounds];

	
		// draw pause and play buttons 
	[self drawPauseButtons]; 


	
}

@end
