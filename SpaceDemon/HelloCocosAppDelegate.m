//
//  HelloCocosAppDelegate.m
//  HelloCocos
//
//  Created by Mohammad Azam on 10/17/10.
//  Copyright HighOnCoding 2010. All rights reserved.
//

#import "HelloCocosAppDelegate.h"
#import "cocos2d.h"
#import "GameScene.h"


#import "HomeScene.h" 

@implementation HelloCocosAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	CC_DIRECTOR_INIT();
	
	// Obtain the shared director in order to...
	CCDirector *director = [CCDirector sharedDirector];
	
	// Sets landscape mode
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	
	// Turn on display FPS
	[director setDisplayFPS:NO];
	
	// Turn on multiple touches
	EAGLView *view = [director openGLView];
	[view setMultipleTouchEnabled:YES];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];	



	[[CCDirector sharedDirector] runWithScene: [GameScene scene]];
}


- (void)applicationWillResignActive:(UIApplication *)application {


	
	// this should be used when someone calls 
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	BOOL isPaused = [[CCDirector sharedDirector] isPaused];
	
	if([scene isKindOfClass:[GameScene class]]) 
	{
				if(!isPaused) 
				{
					// this code is not tested! wondering how to test a phone call interruption! 
					
					GameScene *layer = (GameScene *) [scene getChildByTag:999]; 
					
					Environment *env = [Environment initWithLayer:layer]; 
					[env pauseGame:nil]; 
					
				}
	}
	
	NSLog(@"application has become inactive!");
	

	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	
	BOOL isPaused = [[CCDirector sharedDirector] isPaused]; 
	
	if(isPaused) 
		[[CCDirector sharedDirector] pause];
	
	else 
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
