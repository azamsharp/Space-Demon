//
//  HelloWorldLayer.h
//  HelloCocos
//
//  Created by Mohammad Azam on 10/17/10.
//  Copyright HighOnCoding 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CollisionManager.h"
#import "Demon.h" 
#import "Spaceship.h"
#import "Scoreboard.h" 
#import "Environment.h"

// HelloWorld Layer
@interface GameScene : CCLayer
{
	
	CCSprite *devil;
	CCParticleFire *fireball; 
	CollisionManager *collisionManager;
	Demon *demon; 
	Spaceship *spaceship;
	Scoreboard *scoreboard;
	Environment *env;
	int lives; 

    CCTMXTiledMap *map; 
    CCTMXLayer *backgroundLayer; 
	CGSize windowSize; 
	
	
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(BOOL) isGameOver; 


-(void) pauseGame; 



@property (nonatomic,retain) CCParticleFire *fireball; 
@property (nonatomic,retain) CollisionManager *collisionManager;
@property (nonatomic,retain) Demon *demon; 
@property (nonatomic,retain) Spaceship *spaceship; 
@property (nonatomic,retain) Scoreboard *scoreboard; 
@property (nonatomic,retain) Environment *env; 
@property (nonatomic,assign) int lives; 
@property (nonatomic,assign) CGSize windowSize; 


@end
