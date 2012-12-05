//
//  BandViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "BandViewController.h"
#import "UIImageView+WebCache.h"

@interface BandViewController ()

@end

@implementation BandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		
		
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setClipsToBounds:true];
		[rootView addSubview:imageView];
		
		title = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, self.view.bounds.size.width - 20, 20)];
		title.font = [UIFont boldSystemFontOfSize:16.0f];
		[rootView addSubview:title];
		
		description = [[UITextView alloc] initWithFrame:CGRectMake(10, 230, self.view.bounds.size.width - 20, 100)];
		description.font = [UIFont boldSystemFontOfSize:12.0f];
		[description setEditable:false];
		description.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
		[description sizeToFit];
		[rootView addSubview:description];
			
		[self setView:rootView];
		
    }
    return self;
}

- (BandModel *)band
{
	return [self band];
}

-(void)setBand:(BandModel*)myBand
{
	band = myBand;
	
	// Set view title
	self.title = band.name;
	// Set image
	[imageView setImageWithURL:[NSURL URLWithString:band.imageLarge]
			  placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];	
	
	// Set title
	[title setText:band.name];
	
	// Set description
	[description setText:band.description];
	
	CGRect frame = description.frame;
	frame.size.height = description.contentSize.height;
	description.frame = frame;
	
	// Recalculate frame size
	[rootView setContentSize:CGSizeMake(self.view.bounds.size.width, description.contentSize.height + 230)];
	
	// Add external link
	if (![band.URL isEqualToString:@""]) {
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Website" style:UIBarButtonItemStylePlain target:self action:@selector(gotoWebsite)];
		
		self.navigationItem.rightBarButtonItem = rightButton;
	}
}

-(void)gotoWebsite
{
	if (band.URL != @"") {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:band.URL]];
	}

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
