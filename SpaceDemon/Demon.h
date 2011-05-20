//
//  Demon.h
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "Spaceship.h"
#import "BaseEntity.h" 
#import "SimpleAudioEngine.h" 

@interface Demon : BaseEntity {

	CCSprite *sprite;
	CCLayer *layer; 
	CCParticleSun *fireball; 

	Spaceship *spaceship; 
	
}

-(void) start; 
-(void) fire; 
-(void) hit; 
-(void) destroy; 

@property (nonatomic,retain) CCSprite *sprite; 
@property (nonatomic,retain) CCLayer *layer; 
@property (nonatomic,retain) CCParticleSun *fireball; 

@property (nonatomic,retain) Spaceship *spaceship; 

@end
