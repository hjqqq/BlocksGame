//
//  GameObject.h
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BlocksGameView;

@interface GameObject : NSObject
@property (strong) NSArray *grid;
@property (strong) NSArray *colors;
-(void)handleTouchAtX:(int)xPosition andY:(int)yPosition;
-(void)addCubes;
-(id)initWithGameView:(BlocksGameView *)view;
@property int score;
@end
