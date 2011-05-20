//
//  BaseEntity.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/15/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "BaseEntity.h"
#import "cocos2d.h" 

@implementation BaseEntity

@synthesize windowSize; 

-(BaseEntity *) init 
{
	self = [super init]; 
	self.windowSize = [[CCDirector sharedDirector] winSize];
	return self; 
}

@end
