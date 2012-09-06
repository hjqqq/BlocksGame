//
//  BlocksGameView.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "BlocksGameView.h"
#import "Shape.h"

@interface BlocksGameView()
@property int cubeWidth;
@end

@implementation BlocksGameView
@synthesize viewGrid = _viewGrid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.cubeWidth = self.bounds.size.width / 8;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat startX = 0;
    CGFloat startY = self.bounds.size.height - self.cubeWidth;
    for (NSMutableArray *array in self.viewGrid) {
        for (Shape *shape in array) {
            [shape.color set];
            CGContextFillRect(ctx, CGRectMake(startX, startY, self.cubeWidth, self.cubeWidth));
            startY-=self.cubeWidth;
        }
        startX +=self.cubeWidth;
        startY=self.bounds.size.height - self.cubeWidth;
    }
}


@end
