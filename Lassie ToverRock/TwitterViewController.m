//
//  TwitterViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "TwitterViewController.h"
#import "Tweet.h"
#import "DejalActivityView.h"
#import "GAI.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"Twitter.png"]];
		[tbi setTitle:@"Twitter"];
        
        self.title = @"Praat mee";
		
		// Compose new tweet
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showTweetSheet)];
		self.navigationItem.rightBarButtonItem = rightButton;
		
        
        tweets = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-28275692-2"];
	[googleTracker trackView:@"Twitter"];
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self action:@selector(refresh)
			 forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refreshControl;

    [self fetchTimeLine];
}

- (void) viewWillAppear:(BOOL)animated
{
    
}

-(void)refresh {
	
	[self fetchTimeLine];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTimeLine
{	
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType
                                          options:nil
                                       completion:^(BOOL granted, NSError *error) {
                                           
        if(!granted){
            NSLog(@"Gebruiker geeft geen toestemming tot zijn Twitter account.");
        } else {
            NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
    
            if([twitterAccounts count] > 0){
                ACAccount *account = [twitterAccounts objectAtIndex:0];
            
                NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                [params setObject:@"#ltr2013" forKey:@"q"];
                [params setObject:@"250" forKey:@"count"];

                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];

                SLRequest *request  = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                         requestMethod:SLRequestMethodGET
                                                                   URL:url
                                                            parameters:params];
                
                [request setAccount:account];
                [request performRequestWithHandler:
                 ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     if (responseData) {
                         NSError *jsonError;
						 
                         NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                  options:NSJSONReadingMutableLeaves
                                                                                    error:&jsonError];
                         NSDictionary *items = [jsonData objectForKey:@"statuses"];
                         if (items) {
							 [tweets removeAllObjects];
                             for (NSDictionary *item in items) {
								 
								 Tweet *tweet = [[Tweet alloc] initWithTweetData:item];
								 [tweets addObject:tweet];
                             }
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [self.tableView reloadData];
                             });
                         }
                         else {
                             NSLog(@"%@", jsonError);
                         }
                     }
					 
					 [self.refreshControl endRefreshing];
                }];
            }
        }
    }];
}

- (void)showTweetSheet
{
	//  Create an instance of the Tweet Sheet
	SLComposeViewController *tweetSheet = [SLComposeViewController
										   composeViewControllerForServiceType:
										   SLServiceTypeTwitter];
	
	// Sets the completion handler.  Note that we don't know which thread the
	// block will be called on, so we need to ensure that any UI updates occur
	// on the main queue
	tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
		switch(result) {
				//  This means the user cancelled without sending the Tweet
			case SLComposeViewControllerResultCancelled:
				break;
				//  This means the user hit 'Send'
			case SLComposeViewControllerResultDone:
				break;
		}
		
		//  dismiss the Tweet Sheet
		dispatch_async(dispatch_get_main_queue(), ^{
			[self dismissViewControllerAnimated:NO completion:^{
				NSLog(@"Tweet Sheet has been dismissed.");
			}];
		});
	};
	
	//  Set the initial body of the Tweet
	[tweetSheet setInitialText:@"#ltr2013 "];
	
	/*
	//  Adds an image to the Tweet.  For demo purposes, assume we have an
	//  image named 'larry.png' that we wish to attach
	if (![tweetSheet addImage:[UIImage imageNamed:@"larry.png"]]) {
		NSLog(@"Unable to add the image!");
	}
	 */
	
	//  Add an URL to the Tweet.  You can add multiple URLs.
	if (![tweetSheet addURL:[NSURL URLWithString:@"http://lassietoverrock.nl/"]]){
		NSLog(@"Unable to add the URL!");
	}
	
	//  Presents the Tweet Sheet to the user
	[self presentViewController:tweetSheet animated:NO completion:^{
		NSLog(@"Tweet sheet has been presented.");
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (!cell) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
	}
    
    cell.tweet = [tweets objectAtIndex:indexPath.item];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 95.0f;
    
    Tweet *tweet = [tweets objectAtIndex:indexPath.item];
    
    CGSize tileSize = [tweet.bodyText sizeWithFont:[UIFont systemFontOfSize:12.0f]
                                 constrainedToSize:CGSizeMake((self.view.bounds.size.width - 90), FLT_MAX)];
    
    height = MAX(tileSize.height + 40.0f, 60);
    
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ;
}

@end
