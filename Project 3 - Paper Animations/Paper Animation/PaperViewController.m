//
//  PaperViewController.m
//  Paper Animation
//
//  Created by Joey Hiller on 6/18/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "PaperViewController.h"

@interface PaperViewController ()
@property (strong, nonatomic) IBOutlet UIView *headlinesView;
- (IBAction)onHeadlinesPan:(UIPanGestureRecognizer *)sender;

// Set universal vars
@property (assign, nonatomic) CGPoint headlinesTouchOffset;

@end

@implementation PaperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHeadlinesPan:(UIPanGestureRecognizer *)sender {
    
    CGPoint panPosition = [sender locationInView:self.view];
    
    CGPoint panVelocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.headlinesTouchOffset = CGPointMake(panPosition.x - self.headlinesView.center.x, panPosition.y - self.headlinesView.center.y);
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"viewdidPan %f %f", panPosition.x, panPosition.y);
//        NSLog(@"vel %f", panVelocity.y);
        
        self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y));
        //If past top
        if (self.headlinesView.center.y < self.view.center.y) {
            self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y)*exp(-2)+250.0);
        }
        else {
            self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y));
        }
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture has ended with velocity %f", panVelocity.y);
        // Swipe down, continue to bottom
        if (panVelocity.y >= 500) {
            [UIView animateWithDuration:(panVelocity.y/10000.0) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, 800);
            } completion:nil];
        }
        // Swipe up, Return to center
        else if (panVelocity.y <= -500) {
            [UIView animateWithDuration:(panVelocity.y/-10000.0) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
            } completion:nil];
        }
        // from top, keep toward top
        else if (self.headlinesView.center.y <= self.view.center.y+200.0) {
            [UIView animateWithDuration:(.25) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
            } completion:nil];
        }
        // if past top, continue to bottom
        else if (self.headlinesView.center.y > self.view.center.y+200.0) {
            [UIView animateWithDuration:(.25) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, 800);
            } completion:nil];
        }
        
        // From center, return to center if moved upward.
        else if (self.headlinesView.center.y < self.view.center.y) {
            [UIView animateWithDuration:abs((self.headlinesView.center.y - self.view.center.y))/300.0
                                  delay:0
                 usingSpringWithDamping:.5
                  initialSpringVelocity:3
                                options:0
                             animations:^{
                                 self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
                             } completion:nil
             ];
        }
    }
    
}
@end
