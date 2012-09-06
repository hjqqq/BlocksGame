//
//  GameObject.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "GameObject.h"
#import "Shape.h"

@implementation GameObject
@synthesize grid = _grid;
@synthesize colors = _colors;

-(id)init {
    self = [super init];
    if (self) {
        _colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor whiteColor], [UIColor yellowColor], [UIColor orangeColor] , nil];
        [self setupGrid];
    }
    return self;
}

-(void)setupGrid {
    self.grid = [NSArray arrayWithObjects:[NSMutableArray new], [NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],nil];
    for (NSMutableArray *array in self.grid) {
        for (int i =0; i< 8; i++) {
            int shapeColor = arc4random() % [self.colors count];
            Shape *shape = [[Shape alloc] initWithColor:[self.colors objectAtIndex:shapeColor]];
            [array addObject:shape];
        }
    }
    NSLog(@"grid is:\n %@", self.grid);
}

-(void)handleTouchAtX:(int)xPosition andY:(int)yPosition {
    NSLog(@"checking position: %d, %d", xPosition, yPosition);
    NSLog(@"count at xPosition is %d", [[self.grid objectAtIndex:xPosition] count]);
    if (xPosition > 7 || xPosition <0 ) {
        return;
    }
    if (yPosition > [[self.grid objectAtIndex:xPosition] count]-1 || yPosition <0) {
        return;
    }
    
    Shape* shapeToRemove = [[self.grid objectAtIndex:xPosition] objectAtIndex:yPosition];
    if (shapeToRemove) {
        [[self.grid objectAtIndex:xPosition] removeObject:shapeToRemove];
    }
    NSLog(@"grid is:\n %@", self.grid);
}
@end
