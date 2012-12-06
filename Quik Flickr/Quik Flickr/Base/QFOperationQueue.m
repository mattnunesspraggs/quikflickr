//
//  QFOperationQueue.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFOperationQueue.h"

static QFOperationQueue *sharedInstance = nil;

@implementation QFOperationQueue

+ (QFOperationQueue *)shared
{
    @synchronized(self)
    {
        if (!sharedInstance) {
            sharedInstance = [[QFOperationQueue alloc] init];
        }
        return sharedInstance;
    }
}

@end
