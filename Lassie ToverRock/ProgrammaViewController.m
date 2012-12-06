//
//  ProgrammaViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "ProgrammaViewController.h"
#import "BandModel.h"
#import "BandViewController.h"
#import "BandCellViewController.h"

@interface ProgrammaViewController ()

@end

@implementation ProgrammaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Set the TabBar item
		UITabBarItem *tbi = [self tabBarItem];
		[tbi setImage:[UIImage imageNamed:@"programma.png"]];
		[tbi setTitle:@"Programma"];
		self.title = @"Programma";
		
		// Programma dynamisch inladen
		programma = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSData *programmaData = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://www.lassietoverrock.nl/app/bands.php"] options:NSDataReadingUncached error:nil];
	
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
		for (int i = 0; i < [json[@"bands"] count]; i++) {
			BandModel *band = [[BandModel alloc] init];
			band.name = json[@"bands"][i][@"name"];
			band.description = json[@"bands"][i][@"description"];
			band.URL = json[@"bands"][i][@"url"];
			band.imageSmall = json[@"bands"][i][@"imageSmall"];
			band.imageLarge = json[@"bands"][i][@"imageLarge"];
			[programma addObject:band];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return programma.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BandCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	BandModel *band = [programma objectAtIndex:indexPath.item];
	if (!cell) {
		cell = [[BandCellViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 95)];
		cell.band = band;
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
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
	BandViewController *bandViewController = [[BandViewController alloc] init];
	[bandViewController setBand:[programma objectAtIndex:indexPath.item]];
	[self.navigationController pushViewController:bandViewController animated:YES];
}

@end
