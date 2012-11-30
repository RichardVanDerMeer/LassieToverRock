//
//  SplashViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "SplashViewController.h"

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
		UIImage *splashImage = [UIImage imageNamed:@"splash.jpg"];
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
