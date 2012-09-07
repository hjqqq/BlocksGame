//
//  GameObject.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "GameObject.h"
#import "BlocksGameView.h"
#import "Shape.h"
@interface GameObject()
@property NSMutableArray *shapesToRemove;
@property (strong) BlocksGameView *gameView;
@end

@implementation GameObject
@synthesize grid = _grid;
@synthesize colors = _colors;

-(id)initWithGameView:(BlocksGameView *)view {
    self = [super init];
    if (self) {
        _colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor whiteColor], [UIColor yellowColor], [UIColor orangeColor] , nil];
        self.gameView = view;
        [self setupGrid];
        self.shapesToRemove = [NSMutableArray new];
        self.score = 0;
        
    }
    return self;
}

-(void)setupGrid {
    self.grid = [NSArray arrayWithObjects:[NSMutableArray new], [NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],[NSMutableArray new],nil];
    int arrayNum = 0;
    for (NSMutableArray *array in self.grid) {
        for (int i =0; i< 8; i++) {
            int shapeColor = arc4random() % [self.colors count];
            Shape *shape = [[Shape alloc] initWithColor:[self.colors objectAtIndex:shapeColor] andPosition:CGPointMake(arrayNum * self.gameView.cubeWidth + self.gameView.cubeWidth/2, self.gameView.bounds.size.height-20 - i*self.gameView.cubeWidth) andSize:self.gameView.cubeWidth andView:self.gameView];
            [array addObject:shape];
        }
        arrayNum++;
    }
    //NSLog(@"grid is:\n %@", self.grid);
}

-(void)addCubes {
//    for (NSMutableArray *array in self.grid) {
//        if (array.count < 8) {
//            if (arc4random() % 2 == 0) {
//                int shapeColor = arc4random() % [self.colors count];
//                Shape *shape = [[Shape alloc] initWithColor:[self.colors objectAtIndex:shapeColor]];
//                [array addObject:shape];
//            }
//        }
//    }
}

-(void)handleTouchAtX:(int)xPosition andY:(int)yPosition {
    //NSLog(@"checking position: %d, %d", xPosition, yPosition);
    //NSLog(@"count at xPosition is %d", [[self.grid objectAtIndex:xPosition] count]);
    if (xPosition > 7 || xPosition <0 ) {
        return;
    }
    if (yPosition > [[self.grid objectAtIndex:xPosition] count]-1 || yPosition <0) {
        return;
    }
    if ([[self.grid objectAtIndex:xPosition] count] == 0) {
        return;
    }
    [self removeShapeAtX:xPosition andY:yPosition andColor:[[[self.grid objectAtIndex:xPosition] objectAtIndex:yPosition] color]];
        //NSLog(@"grid is:\n %@", self.grid);
    //self.score += 40*[self.shapesToRemove count];
    if ([self.shapesToRemove count] >= 5) {
        self.score += 800 + self.shapesToRemove.count;
    } else if ([self.shapesToRemove count] >= 3) {
        self.score += 300;
    } else if ([self.shapesToRemove count] >= 2) {
        self.score += 50;
    } else if ([self.shapesToRemove count] == 1) {
        self.score -= 10;
    }
    NSLog(@"score is: %d", self.score);
    NSLog(@"removing %d shapes", self.shapesToRemove.count);
    for (Shape *shape in self.shapesToRemove) {
        //NSLog(@"removing shape");
        for (NSMutableArray *array in self.grid) {
            //find index of shape being removed
            
            if ([array containsObject:shape]) {
                int shapeInteger = [array indexOfObject:shape];
                [array removeObject:shape];
                [shape destroy];
                
                for (int i = shapeInteger; i< array.count; i++) {
                    Shape *movingShape = [array objectAtIndex:i];
                    movingShape.layer.position = CGPointMake(movingShape.layer.position.x, movingShape.layer.position.y + 40);
                }
                break;
            }
        }
    }
    self.shapesToRemove = [NSMutableArray new];
}

-(void)removeShapeAtX:(int)xPosition andY:(int)yPosition andColor:(UIColor *)color {
    //NSLog(@"checking at %d, %d", xPosition, yPosition);
    if ([[self.grid objectAtIndex:xPosition] count] == 0) {
        return;
    }
    Shape* shapeToRemove = [[self.grid objectAtIndex:xPosition] objectAtIndex:yPosition];

    UIColor *initialColor = color;
    //NSLog(@"Shapes Color: %@", initialColor);
    if (shapeToRemove) {
        //NSLog(@"adding %d, %d to removal array", xPosition, yPosition);
        //[self.shapesToRemove addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:xPosition], [NSNumber numberWithInt:yPosition], nil]];
        [self.shapesToRemove addObject:shapeToRemove];
        //figure out which adjacent shapes to remove
        //look 1 left
        if (xPosition > 0 &&  yPosition < [[self.grid objectAtIndex:xPosition-1] count]) {
            //NSLog(@"checking left at %d, %d", xPosition-1, yPosition);
            Shape *left = [[self.grid objectAtIndex:xPosition-1] objectAtIndex:yPosition];
            if ([[left color] isEqual:initialColor] && ![self.shapesToRemove containsObject:left]) {
                [self removeShapeAtX:xPosition-1 andY:yPosition andColor:initialColor];
            }
        }
        //look 1 up
        if (yPosition < [[self.grid objectAtIndex:xPosition] count]-1) {
            //NSLog(@"checking up at %d, %d", xPosition, yPosition+1);
            Shape *up = [[self.grid objectAtIndex:xPosition] objectAtIndex:yPosition+1];
            if ([[up color] isEqual:initialColor] && ![self.shapesToRemove containsObject:up]) {
                [self removeShapeAtX:xPosition andY:yPosition+1 andColor:initialColor];
            }
        }
        //look 1 right
        if (xPosition < 7 && yPosition <[[self.grid objectAtIndex:xPosition+1] count]) {
            //NSLog(@"checking right at %d, %d", xPosition+1, yPosition);
            Shape *right = [[self.grid objectAtIndex:xPosition+1] objectAtIndex:yPosition];
            if ([[right color] isEqual:initialColor] && ![self.shapesToRemove containsObject:right]) {
                [self removeShapeAtX:xPosition+1 andY:yPosition andColor:initialColor];
            }
        }
        //look 1 down
        if (yPosition >0 && yPosition < [[self.grid objectAtIndex:xPosition] count]) {
            //NSLog(@"checking down at %d, %d", xPosition, yPosition-1);
            Shape *down = [[self.grid objectAtIndex:xPosition] objectAtIndex:yPosition-1];
            //NSLog(@"down's color is %@", down.color);
            //NSLog(@"shapes array contains down: %@", [self.shapesToRemove containsObject:down] ? @"true" : @"false");
            if ([[down color] isEqual:initialColor] && ![self.shapesToRemove containsObject:down]) {
                [self removeShapeAtX:xPosition andY:yPosition-1 andColor:initialColor];
            }
        }
            
    }
    //remove all objects in shapesToRemove
    



    
}
@end
