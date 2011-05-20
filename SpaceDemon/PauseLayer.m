//
//  PauseLayer.m
//  SpaceDemon
//
//  Created by Mohammad Azam on 1/24/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

@synthesize windowSize; 

-(id) initWithColor:(ccColor4B)color
{
	if((self == [super initWithColor:color])) 
	{
		isTouchEnabled_ = YES; 
		
		CCMenuItemFont *menuItem1 = [CCMenuItemFont itemFromString:@"Resume" target:self selector:@selector(resumeGame:)];
		CCMenu *menu = [CCMenu menuWithItems:menuItem1,nil];
		
		[self addChild:menu];
				
	}
	
	return self; 
}

-(void) resumeGame:(id) sender 
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	
	[scene removeChildByTag:100 cleanup:YES];
	
	[[CCDirector sharedDirector] resume];
}


@end
