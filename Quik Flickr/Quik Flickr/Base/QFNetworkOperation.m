//
//  QFNetworkOperation.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFNetworkOperation.h"
#import "QFOperationQueue.h"

@interface QFNetworkOperation ()

@property (unsafe_unretained, nonatomic) id delegate;
@property (assign, nonatomic) SEL selector;

@end

@implementation QFNetworkOperation

- (id)initWithDelegate:(id)delegate andSelector:(SEL)selector
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _selector = selector;
    }
    return self;
}

- (void)notifyDelegateOfTermination
{
    if (!self.isCancelled && [_delegate respondsToSelector:_selector]) {
        /*
         this throws a warning - that performSelector can cause a leak. This
         is because ARC cannot enforce proper memory management without knowing
         the exact selector name (some methods, by convention, return objects
         whose memory must be managed). So, caveat emptor, here, but that's not
         what this performSelector should be doing anyways...
         */
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [_delegate performSelectorOnMainThread:_selector
                                    withObject:self
                                 waitUntilDone:YES];
        
        #pragma clang diagnostic pop
    }
}

- (void)run
{
    [self runInQueue:[QFOperationQueue shared]];
}

- (void)runInQueue:(NSOperationQueue *)queue
{
    [queue addOperation:self];
}

@end
