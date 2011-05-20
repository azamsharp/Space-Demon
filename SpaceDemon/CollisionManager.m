//
//  CollisionManager.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "CollisionManager.h"


@implementation CollisionManager

-(BOOL) isCollided:(CCNode *)source objectUnderCollision:(CCNode *)target
{
	
	float distance = powf(source.position.x - target.position.x, 2) + powf(source.position.y - target.position.y,2); 
	distance = sqrtf(distance);
	
	if(distance <= target.contentSize.width/2) 
		return YES;
		
	return NO;
	 
}

@end
