//
//  LocationViewController.m
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "LocationViewController.h"
#import "GAI.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"location.png"]];
        [tbi setTitle:@"Locatie"];
		self.title = @"Locatie";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-28275692-2"];
	[googleTracker trackView:@"Locatie"];
	
	UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 40)];
	[title setFont:[UIFont boldSystemFontOfSize:16.0f ]];
	[title setEditable:false];
	[title setText:@"De Schalmei"];
	[self.view addSubview:title];
	
	UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width - 20, 80)];
	[description setFont:[UIFont systemFontOfSize:12.0f]];
	[description setEditable:false];
	[description setText:@"Van Weerden Poelmanstraat 11\n9254 CS Hurdegaryp\n0511 472126"];
	[self.view addSubview:description];
	
	// Draw the splash image
	UIImage *schalmeiImage = [UIImage imageNamed:@"schalmei.jpg"];
	UIImageView *schalmeiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 340, self.view.bounds.size.width, 300)];
	schalmeiImageView.contentMode = UIViewContentModeScaleToFill;
	schalmeiImageView.image = schalmeiImage;
	[self.view addSubview:schalmeiImageView];
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
