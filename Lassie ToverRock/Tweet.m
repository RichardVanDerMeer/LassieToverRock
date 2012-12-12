//
//  Tweet.m
//  Lassie
//
//  Created by Matthijs Hoekstra on 11-12-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (UIImage*) profileImage
{
    if (_profileImage == nil) {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.data valueForKeyPath:@"user.profile_image_url"]]];
        _profileImage = [UIImage imageWithData:imageData];
    }
    return _profileImage;
}

- (NSString*) username
{
    if (_username == nil) {
        _username = [@"@" stringByAppendingString:[self.data valueForKeyPath:@"user.screen_name"]];
    }
    return _username;
}

- (NSString*) bodyText
{
    if (_bodyText == nil) {
        _bodyText = [self.data valueForKey:@"text"];
    }
    return _bodyText;
}

- (NSDate*) createdAt
{
    if (_createdAt == nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss z yyyy"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
        _createdAt = [dateFormatter dateFromString:[self.data valueForKey:@"created_at"]];
    }
    return _createdAt;
}

- (id) initWithTweetData:(NSDictionary *) tweetData
{
    if(self = [super init]) {
        _data = tweetData;
    }
    return self;
}

@end
