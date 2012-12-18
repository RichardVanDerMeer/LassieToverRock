//
//  FAQDetailViewController.m
//  Lassie
//
//  Created by Richard van der Meer on 18-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "FAQDetailViewController.h"

@interface FAQDetailViewController ()

@end

@implementation FAQDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		
		question = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 20)];
		question.font = [UIFont boldSystemFontOfSize:20.0f];
		[question setEditable:false];
		[rootView addSubview:question];
		
		answer = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width - 20, 100)];
		answer.font = [UIFont boldSystemFontOfSize:16.0f];
		[answer setEditable:false];
		[rootView addSubview:answer];
		
		[self setView:rootView];
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
	
	// Set view title
	self.title = faq.question;

	// Set question
	[question setText:faq.question];
	[question sizeToFit];
	[question setBounds:CGRectMake(10, 10, self.view.bounds.size.width - 20, question.bounds.size.height)];
	CGRect frame = question.frame;
	frame.size.height = question.contentSize.height;
	question.frame = frame;
		
	// Set description
	[answer setText:faq.answer];
	[answer sizeToFit];
	frame = answer.frame;
	frame.size.height = answer.contentSize.height;
	frame.origin.y = question.frame.size.height + 10;
	answer.frame = frame;
	
	// Recalculate frame size
	[rootView setContentSize:CGSizeMake(self.view.bounds.size.width, answer.contentSize.height + 20 + question.contentSize.height)];
	
	// Add external link
	if (![faq.URL isEqualToString:@""]) {
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Website" style:UIBarButtonItemStylePlain target:self action:@selector(gotoWebsite)];
		
		self.navigationItem.rightBarButtonItem = rightButton;
	}
}

-(void)gotoWebsite
{
	if (faq.URL != @"") {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:faq.URL]];
	}
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
