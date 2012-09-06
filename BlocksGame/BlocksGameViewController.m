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
@property int cubeWidth;
@property (strong) NSTimer *gameTimer;
@property int secondsLeft;
@end

@implementation BlocksGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self resetGame];
    }
    return self;
}

-(void)handleTimer {
    //NSLog(@"timer fired!");
    self.secondsLeft--;
    if (self.secondsLeft % 3 == 0) {
        [self.gameObject addCubes];
    }
    self.blocksGameView.timeLeft = self.secondsLeft;
    [self.view setNeedsDisplay];
    if (self.secondsLeft ==0) {
        [self timeRanOut];
    }
}

-(void)timeRanOut {
    NSLog(@"time ran out!");
    [self.gameTimer invalidate];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"time's up!" message:@"too bad!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self resetGame];
}

-(void)resetGame {
    self.view = [[BlocksGameView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.cubeWidth = self.view.bounds.size.width / 8;
    self.blocksGameView = (BlocksGameView *)self.view;
    self.gameObject = [GameObject new];
    self.secondsLeft = 30;
    self.blocksGameView.viewGrid = self.gameObject.grid;
    self.blocksGameView.viewScore = self.gameObject.score;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [self.view setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPosition = [[touches anyObject] locationInView:self.view];
    NSLog(@"touch at %f, %f", touchPosition.x, touchPosition.y);
    //check if touch is inside shape, return shape's position and color
    int xPosition = (int)touchPosition.x / self.cubeWidth;
    int yPosition = (self.view.bounds.size.height-(int)(touchPosition.y))/self.cubeWidth;
    NSLog(@"check grid for shape at location: %d, %d",xPosition , yPosition);
    [self.gameObject handleTouchAtX:xPosition andY:yPosition];
    self.blocksGameView.viewGrid = self.gameObject.grid;
    self.blocksGameView.viewScore = self.gameObject.score;
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
