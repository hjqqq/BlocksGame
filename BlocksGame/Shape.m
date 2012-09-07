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

-(id)initWithColor:(UIColor *)initColor andPosition:(CGPoint)position andSize:(int)size andView:(UIView*)view {
    self = [super init];
    if (self) {
        NSLog(@"creating shape! size is %d, color is %@, position is %f, %f", size, initColor, position.x, position.y);
        _color = initColor;
        self.layer = [CALayer new];
        self.layer.position = position;
        self.layer.delegate = self;
        self.layer.bounds = CGRectMake(0, 0, size, size);
        [view.layer addSublayer:self.layer];
        [self.layer setNeedsDisplay];
        //NSLog(@"Created shape!");
    }
    return self;
}

-(void)destroy {
    [CATransaction begin];
    [CATransaction setAnimationDuration:.1];
    [CATransaction setCompletionBlock:^(void) {
        [self.layer removeFromSuperlayer];
    }];
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.duration = 0.1;
    [self.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    [CATransaction commit];
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"drawing shape!");
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    CGContextFillRect(ctx, layer.bounds);
}

-(NSString *)description {
    return [NSString stringWithFormat:@"C:%@", self.color];
}

@end
