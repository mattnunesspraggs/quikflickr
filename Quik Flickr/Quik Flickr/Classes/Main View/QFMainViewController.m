//
//  QFMainViewController.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "Reachability.h"

#import "QFMainViewController.h"
#import "QFPhotoViewController.h"
#import "QFModalActivityIndicator.h"

#import "UIImageView+loadImageFromURL.h"
#import "QFMainViewCell.h"

#import "QFOperationQueue.h"
#import "QFGetPublicPhotoFeedOperation.h"
#import "FlickrPublicFeedResponse.h"
#import "FlickrPhoto.h"

@interface QFMainViewController () <UITableViewDataSource, UITableViewDelegate>

- (void)loadPublicPhotoFeedWithForceRefresh:(BOOL)refresh;
- (void)publicPhotoFeedReturned:(QFGetPublicPhotoFeedOperation *)op;

- (IBAction)refreshButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshBarButtonItem;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) QFGetPublicPhotoFeedOperation *getFeedOp;
@property (strong, nonatomic) FlickrPublicFeedResponse *flickrResponse;

@end

@implementation QFMainViewController

+ (QFMainViewController *)viewController
{
    return [[[self class] alloc] initWithNibName:@"QFMainViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Photos", @"Photos");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = _refreshBarButtonItem;
    [self loadPublicPhotoFeedWithForceRefresh:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRefreshBarButtonItem:nil];
    [self setTableView:nil];
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

#pragma mark Network

- (void)reachabilityChanged
{
    [super reachabilityChanged];
    
    NetworkStatus netStatus = [self.currentReachability currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        _refreshBarButtonItem.enabled = NO;
        
        if (_getFeedOp) {
            [_getFeedOp cancel];
            [self.activityIndicator hideWithAnimation:YES];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Lost"
                                                                message:@"The connection was lost, and the Flickr feed cannot be loaded."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
    else {
        if (!_flickrResponse) {
            [self loadPublicPhotoFeedWithForceRefresh:NO];
        }
        
        _refreshBarButtonItem.enabled = YES;
    }
}

- (void)loadPublicPhotoFeedWithForceRefresh:(BOOL)refresh
{
    if (!_getFeedOp) {
        if (self.currentNetworkStatus != NotReachable) {
            [self.activityIndicator showWithAnimation:YES];
            
            self.getFeedOp = [[QFGetPublicPhotoFeedOperation alloc] initWithDelegate:self
                                                                         andSelector:@selector(publicPhotoFeedReturned:)];
            
            _getFeedOp.forceRefresh = refresh;
            [_getFeedOp run];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                                message:@"There is no connection, and the Flickr feed cannot be loaded. Try connecting to the network and refreshing the photo list."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)publicPhotoFeedReturned:(QFGetPublicPhotoFeedOperation *)op
{
    if (op.wasSuccessful && op.outputResponse) {
        self.flickrResponse = op.outputResponse;
        [_tableView reloadData];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Flickr Feed Error"
                                                            message:@"The Flickr feed could not be loaded."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    [self.activityIndicator hideWithAnimation:YES];
    self.getFeedOp = nil;
}

- (IBAction)refreshButtonTouched:(id)sender {
    [self loadPublicPhotoFeedWithForceRefresh:YES];
}

#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_flickrResponse.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[QFMainViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    FlickrPhoto *photo = [_flickrResponse.items objectAtIndex:indexPath.row];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.author;
    
    [cell.imageView loadImageFromFlickrPhoto:photo
                                  usingQueue:self.operationQueue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhoto *photo = [_flickrResponse.items objectAtIndex:indexPath.row];
    
    if (photo.image || (!photo.image && self.currentNetworkStatus != NotReachable)) {
        QFPhotoViewController *viewController = [QFPhotoViewController viewController];
        viewController.photo = photo;
        
        [[QFOperationQueue shared] cancelAllOperations];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                            message:@"There is no connection, and the Flickr photo cannot be loaded. Try connecting to the network and trying again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
