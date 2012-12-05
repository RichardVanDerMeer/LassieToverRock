//
//  TwitterViewController.h
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "TweetCell.h"

@interface TwitterViewController : UITableViewController
    @property (strong, nonatomic) id timeline;
@end
