//
//  Shape.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "Shape.h"

@implementation Shape
@synthesize color = _color;

-(id)initWithColor:(UIColor *)initColor {
    self = [super init];
    if (self) {
        _color = initColor;
        self.shapeLayer = [CALayer new];
        self.shapeLayer.bounds = CGRectMake(0, 0, 40, 40);
        //NSLog(@"Created shape!");
    }
    return self;
}

-(id)init {
    //NSLog(@"init with color");
    return [self initWithColor:[UIColor whiteColor]];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"C:%@", self.color];
}

@end
