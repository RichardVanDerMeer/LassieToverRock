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
    // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *) _tweet{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, (self.contentView.bounds.size.width - 90), 14)];
    titleLabel.text = _tweet.username;
    titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    // titleLabel.backgroundColor = [UIColor blueColor];
    
    CGSize tileSize = [_tweet.bodyText sizeWithFont:[UIFont systemFontOfSize:12.0f]
                                 constrainedToSize:CGSizeMake((self.contentView.bounds.size.width - 90), FLT_MAX)];

    bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 19, (self.contentView.bounds.size.width - 90), tileSize.height)];
    bodyTextLabel.text = _tweet.bodyText;
    bodyTextLabel.font = [UIFont systemFontOfSize:12.0f];
    bodyTextLabel.numberOfLines = 0;
    bodyTextLabel.adjustsFontSizeToFitWidth = NO;
    // bodyTextLabel.backgroundColor = [UIColor redColor];

    profilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, (tileSize.height + 24.0f))];
    [profilePicture setContentMode:UIViewContentModeScaleAspectFill];
    [profilePicture setBounds:CGRectMake(0, 0, 80, (tileSize.height + 24.0f))];
    [profilePicture setClipsToBounds:true];
    [profilePicture setImage:_tweet.profileImage];
    [profilePicture setBackgroundColor:[UIColor redColor]];

    [self addSubview:profilePicture];
    [self addSubview:titleLabel];
    [self addSubview:bodyTextLabel];
}

@end
