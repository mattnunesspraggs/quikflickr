//
//  QFNetworkOperation.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFNetworkOperation : NSOperation

- (id)initWithDelegate:(id)delegate andSelector:(SEL)selector;
- (void)notifyDelegateOfTermination;

- (void)run;

@property (assign, nonatomic, getter = wasSuccessful) BOOL successful;

@property (strong, nonatomic) NSHTTPURLResponse *response;
@property (strong, nonatomic) NSError *responseError;
@property (strong, nonatomic) NSData *responseData;

@end
