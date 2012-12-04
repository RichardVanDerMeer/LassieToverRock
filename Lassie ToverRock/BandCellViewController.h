//
//  BandCellViewController.h
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandModel.h"

@interface BandCellViewController : UITableViewCell
{
	BandModel *band;
	UILabel *title;
	UIImageView *imageView;
}
-(BandModel*)band;
-(void)setBand:(BandModel*)myBand;
@end
