//
//  Scoreboard.m
//  HelloCocos
//
//  Created by Mohammad Azam on 12/15/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import "Scoreboard.h"


@implementation Scoreboard

@synthesize scoreLabel,layer,score; 

-(Scoreboard *) initWithScoreAndLayer:(int) s currentLayer:(CCLayer *) l 
{
	self = [super init]; 
	self.score = s; 
	self.layer = l;

	return self; 
}

-(void) display
{
    /*
	scoreLabel = [CCLabel labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Marker Felt" fontSize:25];
	scoreLabel.position = ccp(windowSize.width - scoreLabel.contentSize.width,windowSize.height - scoreLabel.contentSize.height); 
	[self.layer addChild:scoreLabel];
*/
	//scoreLabel = [CCLabel labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Marker Felt" fontSize:25];
	//scoreLabel.position = ccp(windowSize.width - scoreLabel.contentSize.width,windowSize.height - scoreLabel.contentSize.height); 
	//[self.layer addChild:scoreLabel];

}

-(void) update:(int)s
{
	self.score += s; 
	[scoreLabel setString:[NSString stringWithFormat:@"%d",self.score]];

}

@end
