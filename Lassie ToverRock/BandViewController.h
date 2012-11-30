//
//  BandViewController.h
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandModel.h"

@interface BandViewController : UIViewController
{
	BandModel *band;
	UIScrollView *rootView;
	UIImageView *imageView;
	UILabel *title;
	UITextView *description;
}
-(BandModel*)band;
-(void)setBand:(BandModel*)myBand;
@end
