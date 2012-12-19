//
//  FAQViewController.m
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQModel.h"
#import "FAQCell.h"
#import "FAQDetailViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"faq.png"]];
        [tbi setTitle:@"Vragen"];
		self.title = @"Vragen";
		
		faq = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSData *programmaData = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://www.lassietoverrock.nl/app/faq.php"] options:NSDataReadingUncached error:nil];
	
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
		for (int i = 0; i < [json[@"faq"] count]; i++) {
			FAQModel *q = [[FAQModel alloc] init];
			q.question = json[@"faq"][i][@"q"];
			q.answer = json[@"faq"][i][@"a"];
			q.URL = json[@"faq"][i][@"url"];
			[faq addObject:q];
		}
		[self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [faq count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FAQCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[FAQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	FAQModel *q = [faq objectAtIndex:[indexPath row]];
	[cell setFAQ:q];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	FAQDetailViewController *faqViewController = [[FAQDetailViewController alloc] init];
	[faqViewController setFAQ:[faq objectAtIndex:indexPath.item]];
	[self.navigationController pushViewController:faqViewController animated:YES];
}

@end
