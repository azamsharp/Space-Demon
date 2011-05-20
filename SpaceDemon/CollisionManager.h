//
//  CollisionManager.h
//  HelloCocos
//
//  Created by Mohammad Azam on 12/14/10.
//  Copyright 2010 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CollisionManager : NSObject {

}

-(BOOL) isCollided:(CCNode *) source objectUnderCollision:(CCNode *) target; 


@end
