//
//  SingleTon.m
//  CabProject Customer Latest
//
//  Created by AITL BD on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon

@synthesize FeedContentArray;




 - (id) initSingleton
{
    if ((self = [super init]))
    {
        
     }
    
    return self;
}

+ (SingleTon *) instance
{
    // Persistent instance.
    static SingleTon *_default = nil;
    
    // Small optimization to avoid wasting time after the
    // singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Allocates once with Grand Central Dispatch (GCD) routine.
    // It's thread safe.
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[SingleTon alloc] initSingleton];
                  });
#else
    // Allocates once using the old approach, it's slower.
    // It's thread safe.
    @synchronized([MySingleton class])
    {
        // The synchronized instruction will make sure,
        // that only one thread will access this point at a time.
        if (_default == nil)
        {
            _default = [[MySingleton alloc] initSingleton];
        }
    }
#endif
    return _default;
}


@end


