//
//  Tweet.h
//  Lassie
//
//  Created by Matthijs Hoekstra on 11-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *tweetID;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *bodyText;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSDictionary *data;

- (id) initWithTweetData:(NSDictionary*) tweetData;

@end
