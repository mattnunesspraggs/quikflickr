//
//  QFPhotoViewController.m
//  Quik Flickr
//
//  Created by Matthew on 12/5/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "Reachability.h"
#import "QFPhotoViewController.h"
#import "QFPhotoInfoViewController.h"
#import "UIImageView+loadImageFromURL.h"

@interface QFPhotoViewController ()

- (void)updateInterface;
- (void)infoButtonTouched:(UIButton *)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *imageActivityIndicator;

@end

@implementation QFPhotoViewController

+ (QFPhotoViewController *)viewController
{
    return [[[self class] alloc] initWithNibName:@"QFPhotoViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    // set up the custom info button
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonTouched:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.navigationItem.rightBarButtonItem = infoBarButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateInterface];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setActivityIndicator:nil];
    [self setImageActivityIndicator:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)infoButtonTouched:(UIButton *)sender
{
    QFPhotoInfoViewController *infoView = [QFPhotoInfoViewController viewController];
    infoView.photo = _photo;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:infoView];

    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:navigationController animated:YES];
}

- (void)updateInterface
{
    self.title = _photo.title;
    [_imageView loadImageFromFlickrPhoto:_photo usingQueue:self.operationQueue];
}

- (void)reachabilityChanged
{
    [super reachabilityChanged];
    
    if (self.currentNetworkStatus == NotReachable) {
        [_imageActivityIndicator stopAnimating];
        if (!_photo.image) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                                message:@"There is no connection, and the Flickr photo cannot be loaded. Try connecting to the network and trying again."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    else {
        [_imageActivityIndicator startAnimating];
    }
}

@end
