//
//  BandCellViewController.m
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "BandCellViewController.h"
#import "UIImageView+WebCache.h"

@implementation BandCellViewController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// Add title
		title = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, self.contentView.bounds.size.width, 95)];
		title.font = [UIFont boldSystemFontOfSize:16.0f];
		[self addSubview:title];
		
		// Add image
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 75)];
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setBounds:CGRectMake(10, 10, 100, 75)];
		[imageView setClipsToBounds:true];
		[self addSubview:imageView];
    }
    return self;
}

- (BandModel *)band
{
	return [self band];
}

-(void)setBand:(BandModel*)myBand
{
	band = myBand;
	
	// Set title
	[title setText:band.name];
	
	// Set image
	[imageView setImageWithURL:[NSURL URLWithString:band.imageSmall]
			  placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
