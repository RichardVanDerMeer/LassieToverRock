//
//  PicturesViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "PicturesViewController.h"
#import "UIImageView+WebCache.h"
#import "ThumbnailView.h"

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
		self.title = @"Foto's 2012";
		[tbi setTitle:@"Foto's"];
		
		rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		[self setView:rootView];
		
		pictures = [[NSMutableArray alloc] init];
		
		currentImageIndex = 0;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	// Fetch JSON of all images
	NSData *pictureData = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://www.lassietoverrock.nl/app/images.php"]];
	
	NSDictionary *json = nil;
	if (pictureData) {
		json = [NSJSONSerialization
				JSONObjectWithData:pictureData
				options:NSJSONWritingPrettyPrinted
				error:nil];
	}
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateUIWithDictionary: json];
	});

}

-(void)updateUIWithDictionary:(NSDictionary*)json {
	@try {
		int left;
		int top;
		for (int i = 0; i < [json[@"images"] count]; i++) {
			
			left = ((i % 3) * 105) + 5;
			top = ((i / 3) * 105) + 5;
			
			// Add image
			ThumbnailView *imageView = [[ThumbnailView alloc] initWithFrame:CGRectMake(left, top, 100, 100)];
			[imageView setContentMode:UIViewContentModeScaleAspectFill];
			[imageView setBounds:CGRectMake(10, 10, 100, 100)];
			[imageView setClipsToBounds:true];
			[rootView addSubview:imageView];
			[imageView setImageWithURL:[NSURL URLWithString: json[@"images"][i][@"imageSmall"]]
					  placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
			imageView.imageLarge = json[@"images"][i][@"imageLarge"];
			
			
			imageView.userInteractionEnabled = YES;
			
			UITapGestureRecognizer *tapGR;
			tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
			tapGR.numberOfTapsRequired = 1;
			[imageView addGestureRecognizer:tapGR];
			
			[pictures addObject:imageView];
			
		}
		
		// Recalculate frame size
		[rootView setContentSize:CGSizeMake(self.view.bounds.size.width, top + 105)];
		
		// Init detail view
		image = [[FullImageViewController alloc] init];
		[image setPictures:pictures];
	}
	@catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:@"Fout"
                                    message:@"Kan de afbeeldingen niet ophalen"
                                   delegate:nil
                          cancelButtonTitle:@"Sluiten"
                          otherButtonTitles: nil] show];
        NSLog(@"Exception: %@", exception);
    }
}

// Add a delegate method to handle the tap and do something with it.
-(void)handleTap:(UITapGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateEnded) {
		[self.navigationController pushViewController:image animated:YES];
		[image showPictures];
		currentImageIndex = [pictures indexOfObject:sender.view];
		[image gotoPage:currentImageIndex];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
