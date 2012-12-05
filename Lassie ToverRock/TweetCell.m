//
//  TwitterViewCell.m
//  Lassie
//
//  Created by Matthijs Hoekstra on 05-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, (self.contentView.bounds.size.width - 50), 30)];
        titleLabel.text = @"@matthijsh";
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		[self addSubview:titleLabel];
       
        contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 30, (self.contentView.bounds.size.width - 50), 60)];
        contentTextView.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.";
        contentTextView.font = [UIFont systemFontOfSize:12.0f];
        contentTextView.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
		[self addSubview:contentTextView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
