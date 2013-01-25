//
//  AboutViewController.m
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "AboutViewController.h"
#import "GAI.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"Lassie.png"]];
		self.title = @"Over Lassie";
        [tbi setTitle:@"Over Lassie"];
		
		
		rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		
		
		
		
		UIImage *aboutImage = [UIImage imageNamed:@"about.jpg"];
		aboutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
		aboutImageView.contentMode = UIViewContentModeScaleAspectFit;
		aboutImageView.image = aboutImage;
		[rootView addSubview:aboutImageView];
		
		about = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, self.view.bounds.size.height)];
		about.font = [UIFont boldSystemFontOfSize:16.0f];
		[about setEditable:false];
		[rootView addSubview:about];
		
		[self setView:rootView];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-28275692-2"];
	[googleTracker trackView:@"About"];
	
	NSData *programmaData = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://www.lassietoverrock.nl/app/static.php"] options:NSDataReadingUncached error:nil];
	
	NSDictionary *json = nil;
	if (programmaData) {
		json = [NSJSONSerialization
				JSONObjectWithData:programmaData
				options:NSJSONWritingPrettyPrinted
				error:nil];
	}
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateUIWithDictionary: json];
	});
	
	
}

-(void)updateUIWithDictionary:(NSDictionary*)json {
	@try {
		for (int i = 0; i < [json[@"about"] count]; i++) {
			[about setText:json[@"about"][i][@"text"]];
			[about sizeToFit];
			CGRect frame = about.frame;
			frame.size.height = about.contentSize.height;
			frame.origin.y = aboutImageView.frame.size.height;
			about.frame = frame;
			[rootView setContentSize:CGSizeMake(self.view.bounds.size.width, about.frame.origin.y + about.frame.size.height)];
			
		}
	}
	@catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:@"Fout"
                                    message:@"Kan het programma niet ophalen"
                                   delegate:nil
                          cancelButtonTitle:@"Sluiten"
                          otherButtonTitles: nil] show];
        NSLog(@"Exception: %@", exception);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
