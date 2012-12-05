//
//  TwitterViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "TwitterViewController.h"

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
		self.title = @"Praat mee";
		[tbi setTitle:@"Twitter"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated
{
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
                [params setObject:@"#LTR2013" forKey:@"q"];
                [params setObject:@"10" forKey:@"count"];

                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];

                SLRequest *request  = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                         requestMethod:SLRequestMethodGET
                                                                   URL:url
                                                            parameters:params];
                
                [request setAccount:account];

                [request performRequestWithHandler:
                 ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     if (responseData) {
                         //  Use the NSJSONSerialization class to parse the returned JSON
                         NSError *jsonError;
                         
                         self.timeline = [NSJSONSerialization JSONObjectWithData:responseData
                                                                             options:NSJSONReadingMutableLeaves
                                                                               error:&jsonError];
                         if (self.timeline) {
                             // We have an object that we can parse
                             NSLog(@"%@", self.timeline);
                             [self.tableView reloadData];
                         }
                         else {
                             // Inspect the contents of jsonError
                             NSLog(@"%@", jsonError);
                         }
                     }
                }];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[self.timeline objectForKey:@"statuses"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
    id tweet = [[self.timeline objectForKey:@"statuses"] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[tweet objectForKey:@"text"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
