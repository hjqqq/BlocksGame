//
//  BlocksGameViewController.m
//  BlocksGame
//
//  Created by Maneesh Goel on 9/5/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "BlocksGameViewController.h"
#import "BlocksGameView.h"
#import "GameObject.h"

@interface BlocksGameViewController ()
@property (strong) GameObject *gameObject;
@property (strong) BlocksGameView *blocksGameView;
@end

@implementation BlocksGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view = [[BlocksGameView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.blocksGameView = (BlocksGameView *)self.view;
        self.gameObject = [GameObject new];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPosition = [[touches anyObject] locationInView:self.view];
    NSLog(@"touch at %f, %f", touchPosition.x, touchPosition.y);
    //check if touch is inside shape, return shape's position and color
    int xPosition = (int)touchPosition.x / 40;
    int yPosition = (480-(int)(touchPosition.y))/40;
    NSLog(@"check grid for shape at location: %d, %d",xPosition , yPosition);
    [self.gameObject handleTouchAtX:xPosition andY:yPosition];
    self.blocksGameView.viewGrid = self.gameObject.grid;
    [self.view setNeedsDisplay];
}

-(void)viewWillAppear:(BOOL)animated {
    self.blocksGameView.viewGrid = self.gameObject.grid;
    [self.view setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
