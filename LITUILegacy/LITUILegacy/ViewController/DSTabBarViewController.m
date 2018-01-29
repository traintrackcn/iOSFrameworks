//
//  DSTabBarViewController.m
//  DirectSale
//
//  Created by Sean Guo on 5/10/12.
//  Copyright (c) 2012 Voxeo. All rights reserved.
//

#import "DSTabBarViewController.h"

@interface DSTabBarViewController ()

// Private Properties:
@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;

@end

@implementation DSTabBarViewController

@synthesize navigationBarPanGestureRecognizer = _navigationBarPanGestureRecognizer;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//	self.view.backgroundColor = [AGStyleCoordinator backgroundColorForKey:@"content-dark"];
	
    // Check if we have a revealButton already.

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
