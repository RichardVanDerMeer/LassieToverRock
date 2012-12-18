//
//  FAQCell.m
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "FAQCell.h"

@implementation FAQCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Add title
		question = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.bounds.size.width - 20, 10)];
		question.font = [UIFont boldSystemFontOfSize:18.0f];
		[self addSubview:question];
    }
    return self;
}

- (FAQModel *)faq
{
	return [self faq];
}

-(void)setFAQ:(FAQModel *)myFAQ
{
	faq = myFAQ;
	
	// Set title
	[question setText:faq.question];
	[question sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
