//
//  FAQDetailViewController.h
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQModel.h"

@interface FAQDetailViewController : UIViewController
{
	FAQModel *faq;
	UIScrollView *rootView;
	UITextView *question;
	UITextView *answer;
}
-(FAQModel*)faq;
-(void)setFAQ:(FAQModel*)myFAQ;
-(void)gotoWebsite;
@end
