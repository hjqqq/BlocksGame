//
//  BlocksGameView.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "BlocksGameView.h"
#import "Shape.h"
#import <QuartzCore/QuartzCore.h>

@interface BlocksGameView()

@property (strong) UILabel *scoreLabel;
@property (strong) UILabel *timeLabel;

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
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        self.scoreLabel.backgroundColor = [UIColor clearColor];
        self.scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        self.scoreLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.scoreLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.bounds.size.width, 60)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        self.timeLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.timeLabel];
        self.timeLeft = 30;
        self.viewScore = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    //draw score
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.viewScore];
//    
//    //draw time
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %d", self.timeLeft];
//    
//    CGFloat startX = 0;
//    CGFloat startY = self.bounds.size.height - self.cubeWidth;
//    for (NSMutableArray *array in self.viewGrid) {
//        for (Shape *shape in array) {
//            [shape.color set];
//            CGContextFillRect(ctx, CGRectMake(startX, startY, self.cubeWidth, self.cubeWidth));
//            startY-=self.cubeWidth;
//        }
//        startX +=self.cubeWidth;
//        startY=self.bounds.size.height - self.cubeWidth;
//    }
}


@end
