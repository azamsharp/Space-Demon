//
//  HelloWorldLayer.m
//  HelloCocos
//
//  Created by Mohammad Azam on 10/17/10.
//  Copyright HighOnCoding 2010. All rights reserved.
//

// Import the interfaces
#import "GameScene.h"
#import "Environment.h" 
#import "Demon.h"
#import "Scoreboard.h" 

// HelloWorld implementation
@implementation GameScene

CCSprite *firewood; 
CGPoint p;

@synthesize fireball,scoreboard; 

@synthesize collisionManager,demon,spaceship,env,lives,windowSize;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];

	
	// add layer as a child to scene
	[scene addChild: layer];

	[layer setTag:999];
	
		
	// return the scene
	return scene;
}

-(void) loadTileMap
{
    map = [CCTMXTiledMap tiledMapWithTMXFile:@"space_demon_background.tmx"];
    
    backgroundLayer = [map layerNamed:@"background"];
    
    [backgroundLayer runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
    
    [self addChild:map];
}

-(void) step:(ccTime) dt 
{
    if(backgroundLayer.position.y < -800) 
    {
        [backgroundLayer setPosition:ccp(0,-32)];
         [backgroundLayer runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
    }
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		self.lives = 3; 
        
        [self loadTileMap];
		
		collisionManager = [[CollisionManager alloc] init];
		
		CGSize windowSize = [[CCDirector sharedDirector] winSize];
				
		isTouchEnabled_ = YES;
		isAccelerometerEnabled_ = YES; 
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0/60.0)];
		
		[self addSpaceshipToGame];
				
		// demon 
		self.demon = [[Demon alloc] initWithSpriteFileName:@"demon1.png" currentLayer:self];
		self.demon.sprite.position = ccp(windowSize.width/2,windowSize.height - demon.sprite.contentSize.height); 
		[self addChild:demon.sprite];
		
		// setup the environment = sea of fire 
		self.env = [[Environment alloc] initWithLayer:self];
		[self.env setup];
		[self.env drawLives:self.lives]; 
		
		// setup scoreboard
		self.scoreboard = [[Scoreboard alloc] initWithScoreAndLayer:0 currentLayer:self];
		[self.scoreboard display]; 
		
		[self.demon start];
		
		[self schedule:@selector(checkIfSpaceshipIsHit)];
        
        [self schedule:@selector(step:)];
		
	}
	
	return self;
}

// pause the game 
-(void) pauseGame 
{
	
}




-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	static float prevX = 5, prevY = 0; 
	
#define kFilterFactor 0.05f;
	int movementSpeed = 20; 
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- 0.05f) *prevX; 
															
	prevX = accelX; 
	float speed = -100 * -accelX;
	if(self.spaceship) 
	{
		 
		if(speed > movementSpeed)
			speed = movementSpeed; 
		else if(speed < -movementSpeed) 
			speed = -movementSpeed; 
		

		
		[self.spaceship.sprite setPosition:ccp(self.spaceship.sprite.position.x + speed, self.spaceship.sprite.position.y)];
		
		
	}
	
	

		if((accelX > 0 || self.spaceship.sprite.position.x > self.spaceship.sprite.textureRect.size.width/2) 
		   && (accelX < 0 || self.spaceship.sprite.position.x < 320 - self.spaceship.sprite.textureRect.size.width /2))
		   
		{
		
			[self.spaceship.sprite setPosition:ccp(self.spaceship.sprite.position.x + speed, self.spaceship.sprite.position.y)];
		}
}




-(BOOL) isGameOver 
{
	return self.lives == 0; 
}

-(void) addSpaceshipToGame 
{
	if([self isGameOver]) 
	{
		[env displayGameOverMessage]; 
	}
	else 
	{
	
	if(self.spaceship != nil) 
	{
		[self removeChild:self.spaceship.sprite cleanup:YES];
		self.spaceship.sprite = nil;
	}
	
	
	CGSize windowSize = [[CCDirector sharedDirector] winSize];
	// space ship
	self.spaceship = [[Spaceship alloc] initWithSpriteFileName:@"spaceship.png" currentLayer:self];


		
	// give few seconds of immortality to the re-spawn spaceship 
	[self.spaceship.sprite runAction:[CCBlink actionWithDuration:3.0 blinks:10]];	
		

	spaceship.sprite.position = ccp(windowSize.width/2,spaceship.sprite.contentSize.height); 
	[self addChild:spaceship.sprite]; 	
	}
}

-(void) checkIfSpaceshipIsHit
{
	if(self.spaceship.isImmortal) return; 
	

	// spaceship hit by a demon 
	if([collisionManager isCollided:self.demon.sprite objectUnderCollision:spaceship.sprite]
	   || ([collisionManager isCollided:self.demon.fireball objectUnderCollision:spaceship.sprite]) ) 
	{

		[self.env removeLifeByTag:self.lives];

		self.lives -= 1; 
		
		[self.spaceship hit];
		
		[self performSelector:@selector(addSpaceshipToGame) withObject:nil afterDelay:5.0];
		
	}
		
	}


-(void) checkIfDemonIsHit
{	
	
	if([collisionManager isCollided:self.spaceship.laser objectUnderCollision:demon.sprite])
	{
		[self.demon hit]; 
	
	}
	

}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
	
	// not using anymore since we are using the accelerometer to move the spaceship 
	[spaceship move:location]; 
	
	float distance = pow(self.spaceship.sprite.position.x - location.x, 2) + pow(self.spaceship.sprite.position.y - location.y, 2); 
	distance = sqrt(distance); 
	
	if(distance <= 50) 
	{	
		[self.spaceship fire];
		
		if(self.demon.sprite != nil) 
		{
		[self schedule:@selector(checkIfDemonIsHit)];	
		}
			
	}
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
