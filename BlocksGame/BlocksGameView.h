//
//  BlocksGameView.h
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlocksGameView : UIView
@property (strong) NSArray *viewGrid;
@property int viewScore;
@property int timeLeft;
@property int cubeWidth;
@end
