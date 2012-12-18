//
//  FullImageViewController.h
//  Lassie
//
//  Created by Richard van der Meer on 05-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullImageViewController : UIViewController <UIScrollViewDelegate>
{
	UIScrollView *rootView;
	NSMutableArray *pictures;
	NSMutableArray *pictureViews;
	int currentPage;
}
@property (nonatomic) NSString *imageLarge;
-(void)setPictures:(NSMutableArray*)myPictures;
-(void)showPictures;
-(void)gotoPage:(int)page;
-(void)viewImage:(int)page;
@end
