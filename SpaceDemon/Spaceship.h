//
//  Spaceship.h
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "BaseEntity.h"
#import "SimpleAudioEngine.h" 

@interface Spaceship : BaseEntity {

	CCSprite *sprite; 
	CCParticleMeteor *laser; 
	CCLayer *layer; 
	CCParticleSmoke *smoke;	


	BOOL isImmortal;

}

-(void) move:(CGPoint) location; 
-(void) fire; 
-(void) destroyLaser; 
-(void) hit; 
-(void) generateSmoke; 
-(void) destroy;


@property (nonatomic,retain) CCSprite *sprite; 
@property (nonatomic,retain) CCParticleMeteor *laser; 
@property (nonatomic,retain) CCLayer *layer; 
@property (nonatomic,retain) CCParticleSmoke *smoke;
@property (nonatomic,retain) CCParticleFire *explosion; 
@property (nonatomic,assign) BOOL isImmortal; 



@end
