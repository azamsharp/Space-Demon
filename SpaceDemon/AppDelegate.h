//
//  AppDelegate.h
//  SpaceDemon
//
//  Created by Mohammad Azam on 5/19/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameScene.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
