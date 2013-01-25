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
		dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, (self.contentView.bounds.size.width - 90), 10)];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 16, (self.contentView.bounds.size.width - 90), 14)];
		bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 32, (self.contentView.bounds.size.width - 90), 60)];
		profilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 48, 48)];
		
		[self addSubview:dateLabel];
		[self addSubview:profilePicture];
		[self addSubview:titleLabel];
		[self addSubview:bodyTextLabel];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *) _tweet{
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
	NSString *formattedDate = [formatter stringFromDate:_tweet.createdAt];
	
	dateLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
	dateLabel.font = [UIFont systemFontOfSize:10.0f];
	dateLabel.textColor = [UIColor grayColor];
	
    titleLabel.text = _tweet.username;
    titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    // titleLabel.backgroundColor = [UIColor blueColor];
    
    CGSize tileSize = [_tweet.bodyText sizeWithFont:[UIFont systemFontOfSize:12.0f]
                                 constrainedToSize:CGSizeMake((self.contentView.bounds.size.width - 90), FLT_MAX)];

    
    bodyTextLabel.text = _tweet.bodyText;
    bodyTextLabel.font = [UIFont systemFontOfSize:12.0f];
    bodyTextLabel.numberOfLines = 0;
    bodyTextLabel.adjustsFontSizeToFitWidth = NO;
	
	CGRect frame = bodyTextLabel.frame;
	frame.size.height = tileSize.height;
	frame.origin.y = 32;
	bodyTextLabel.frame = frame;
    
    [profilePicture setContentMode:UIViewContentModeScaleAspectFit];
    [profilePicture setBounds:CGRectMake(6, 6, 48, 48)];
    [profilePicture setClipsToBounds:true];
    [profilePicture setImage:_tweet.profileImage];
    [profilePicture setBackgroundColor:[UIColor redColor]];

}

@end
