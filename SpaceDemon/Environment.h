//
//  Environment.h
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "SimpleAudioEngine.h" 
#import "Spaceship.h" 

#import "PauseLayer.h" 



@interface Environment : BaseEntity {

	CCLayer *layer; 

}

-(void) setup;
-(void) drawLives:(int) lives; 
-(void) preloadSounds; 
-(void) displayGameOverMessage; 

@property (nonatomic,retain) CCLayer *layer; 

-(void) drawPauseButtons; 





@end
