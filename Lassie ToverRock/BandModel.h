//
//  bandModel.h
//  Lassie ToverRock
//
//  Created by Richard van der Meer on 29-11-12.
//  Copyright (c) 2012 Richard van der Meer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BandModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *URL;
@property (nonatomic) NSString *imageSmall;
@property (nonatomic) NSString *imageLarge;

@end