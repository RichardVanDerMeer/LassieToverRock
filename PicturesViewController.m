//
//  PicturesViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "PicturesViewController.h"

@interface PicturesViewController ()

@end

@implementation PicturesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"Fotos.png"]];
		[tbi setTitle:@"Foto's"];
		self.title = @"Foto's";
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
