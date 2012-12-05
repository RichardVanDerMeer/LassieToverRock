//
//  FullImageViewController.m
//  Lassie
//
//  Created by Richard van der Meer on 05-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "FullImageViewController.h"
#import "UIImageView+WebCache.h"

@interface FullImageViewController ()

@end

@implementation FullImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"Foto";
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Opslaan" style:UIBarButtonItemStylePlain target:self action:@selector(downloadImage)];
		self.navigationItem.rightBarButtonItem = rightButton;
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	[imageView setImageWithURL:[NSURL URLWithString:self.imageLarge]
			  placeholderImage:nil];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.view = imageView;
}

-(void)downloadImage
{
	UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
	
	[[[UIAlertView alloc] initWithTitle:@"Foto opgeslagen"
								message:@"De afbeelding is opgeslagen"
							   delegate:nil
					  cancelButtonTitle:@"Sluiten"
					  otherButtonTitles: nil] show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
