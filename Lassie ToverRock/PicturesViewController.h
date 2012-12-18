//
//  PicturesViewController.h
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 30-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullImageViewController.h"

@interface PicturesViewController : UIViewController
{
	UIScrollView *rootView;
	NSMutableArray *pictures;
	int currentImageIndex;
	FullImageViewController *image;
}
@end
