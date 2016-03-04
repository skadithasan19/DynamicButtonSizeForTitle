//
//  SingleTon.h
//  CabProject Customer Latest
//
//  Created by AITL BD on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//its without comment 
@interface SingleTon : NSObject


@property(nonatomic,retain)NSArray *FeedContentArray;

+ (SingleTon *) instance;

@end
