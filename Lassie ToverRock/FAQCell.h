//
//  FAQCell.h
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQModel.h"

@interface FAQCell : UITableViewCell
{
	FAQModel *faq;
	UILabel *question;
}

-(FAQModel*)faq;
-(void)setFAQ:(FAQModel*)myFAQ;

@end
