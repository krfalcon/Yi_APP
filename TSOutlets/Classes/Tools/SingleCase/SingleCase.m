//
//  SingleCase.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/24.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "SingleCase.h"

@implementation SingleCase

@synthesize coredataOperationQueue;
@synthesize uploadOperationQueue;
@synthesize deviceToken;
@synthesize clientID;

+ (SingleCase *)singleCase
{
    static SingleCase *singleCase = nil;
    
    @synchronized(self)
    {
        if (!singleCase)
            singleCase = [[SingleCase alloc] init];
        
        singleCase.uploadOperationQueue = [[NSOperationQueue alloc] init];
        singleCase.uploadOperationQueue.maxConcurrentOperationCount = 5;
                
        return singleCase;
    }
}

@end
