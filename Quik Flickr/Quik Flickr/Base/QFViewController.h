//
//  QFViewController.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class QFModalActivityIndicator, QFOperationQueue;
@interface QFViewController : UIViewController

- (void)reachabilityChanged;

@property (strong, nonatomic) Reachability *currentReachability;
@property (assign, nonatomic) NetworkStatus currentNetworkStatus;

@property (strong, nonatomic) QFModalActivityIndicator *activityIndicator;
@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end
