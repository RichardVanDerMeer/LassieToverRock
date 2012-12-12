//
//  TwitterViewCell.m
//  Lassie
//
//  Created by Matthijs Hoekstra on 05-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

@synthesize tweet;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // init
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *) tweet{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, (self.contentView.bounds.size.width - 50), 30)];
    titleLabel.text = tweet.username;
    titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:titleLabel];
    
    bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, (self.contentView.bounds.size.width - 50), 60)];
    bodyTextLabel.text = tweet.bodyText;
    bodyTextLabel.font = [UIFont systemFontOfSize:12.0f];
    bodyTextLabel.numberOfLines = 0;
    bodyTextLabel.adjustsFontSizeToFitWidth = NO;
    [self addSubview:bodyTextLabel];
}

@end
