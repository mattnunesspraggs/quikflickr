//
//  QFViewController.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "Reachability.h"
#import "QFAppDelegate.h"
#import "QFViewController.h"
#import "QFOperationQueue.h"
#import "QFModalActivityIndicator.h"

@interface QFViewController ()

- (void)reachabilityChanged:(NSNotification *)notification;

@end

@implementation QFViewController

- (void)dealloc
{
    [_operationQueue cancelAllOperations];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.operationQueue = [[QFOperationQueue alloc] init];
        [_operationQueue setSuspended:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name: kReachabilityChangedNotification
                                                   object: nil];
        
        QFAppDelegate *appDelegate = (QFAppDelegate *)[UIApplication sharedApplication].delegate;
        self.currentReachability = [appDelegate currentReachability];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _activityIndicator = [QFModalActivityIndicator modalActivityIndicator];
    [self.view addSubview:_activityIndicator];
    
    // configure UI, start networking...
    [self reachabilityChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_operationQueue setSuspended:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_operationQueue setSuspended:NO];
    [super viewDidDisappear:animated];
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    self.currentReachability = [notification object];
    [self reachabilityChanged];
}

- (void)reachabilityChanged
{
    NetworkStatus netStatus = [self.currentReachability currentReachabilityStatus];
    self.currentNetworkStatus = netStatus;
    
    if (netStatus == NotReachable) {
        [_operationQueue setSuspended:YES];
    }
    else {
        [_operationQueue setSuspended:NO];
    }
}

@end
