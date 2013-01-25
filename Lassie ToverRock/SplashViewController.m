//
//  SplashViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "SplashViewController.h"
#import "GAI.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		// Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"Lassie.png"]];
		[tbi setTitle:@"Lassie"];
		
		// Draw the splash image
		UIImage *splashImage = [UIImage imageNamed:@"splash.png"];
		UIImageView *splashImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
		splashImageView.contentMode = UIViewContentModeScaleAspectFill;
		splashImageView.image = splashImage;
		
		[self setView:splashImageView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-28275692-2"];
	[googleTracker trackView:@"Splash"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
