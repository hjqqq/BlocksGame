//
//  Shape.h
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Shape : NSObject
@property (strong) UIColor *color;
@property (strong) CALayer *shapeLayer;
-(id)initWithColor:(UIColor *)initColor;
@end
