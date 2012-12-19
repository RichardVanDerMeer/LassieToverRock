//
//  TwitterViewCell.h
//  Lassie
//
//  Created by Matthijs Hoekstra on 05-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell: UITableViewCell
{
    UILabel *titleLabel;
    UILabel *bodyTextLabel;
    UIImageView *profilePicture;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (nonatomic, retain) Tweet *tweet;

@end
