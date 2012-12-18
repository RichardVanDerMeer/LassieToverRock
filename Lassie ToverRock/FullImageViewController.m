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

		currentPage = 0;
		
		self.title = @"Foto";
		
		rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		[rootView setPagingEnabled:YES];
		[rootView setBackgroundColor:[UIColor blackColor]];
		[rootView setDelegate:self];
		
		
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Opslaan" style:UIBarButtonItemStylePlain target:self action:@selector(downloadImage)];
		self.navigationItem.rightBarButtonItem = rightButton;
		self.view = rootView;
		
		pictureViews = [[NSMutableArray alloc] init];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)setPictures:(NSMutableArray *)myPictures{
	pictures = myPictures;	
}

-(void)showPictures
{
	[rootView setContentSize:CGSizeMake(self.view.bounds.size.width * [pictures count], self.view.bounds.size.height)];
	
	for (int i = 0; i < [pictures count]; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[rootView addSubview:imageView];
		[pictureViews addObject:imageView];
	}
}

-(void)gotoPage:(int)page
{
	CGRect frame = rootView.frame;
	frame.origin.x = frame.size.width * page;
	frame.origin.y = 0;
	currentPage = page;
	[rootView scrollRectToVisible:frame animated:NO];

	[self viewImage:currentPage];
	[self viewImage:currentPage - 1];
	[self viewImage:currentPage + 1];
}

-(void)viewImage:(int)page
{
	if (page >= 0 && page <= [pictureViews count]) {
		UIImageView *view = [pictureViews objectAtIndex:page];
		[view setImageWithURL:[NSURL URLWithString:[[pictures objectAtIndex:page] imageLarge]]];
	}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.frame.size.width;
	int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if (page < currentPage) {
		[self viewImage:page - 1];
	} else {
		[self viewImage:page + 1];
	}
	currentPage = page;
}


-(void)downloadImage
{
	
	int currentIndex = rootView.contentOffset.x / self.view.bounds.size.width;
	NSLog(@"%i", currentIndex);
	UIImageView *view = pictureViews[currentIndex];
	UIImageWriteToSavedPhotosAlbum(view.image, nil, nil, nil);
	NSLog(@"%@", view);
	
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
