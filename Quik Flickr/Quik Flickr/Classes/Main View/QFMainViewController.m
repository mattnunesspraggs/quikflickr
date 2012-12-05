//
//  QFMainViewController.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFMainViewController.h"
#import "QFModalActivityIndicator.h"

#import "UIImageView+loadImageFromURL.h"
#import "QFMainViewCell.h"

#import "QFGetPublicPhotoFeedOperation.h"
#import "FlickrPublicFeedResponse.h"
#import "FlickrPhoto.h"

@interface QFMainViewController () <UITableViewDataSource, UITableViewDelegate>

- (void)loadPublicPhotoFeedWithForceRefresh:(BOOL)refresh;
- (void)publicPhotoFeedReturned:(QFGetPublicPhotoFeedOperation *)op;

- (IBAction)refreshButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshBarButtonItem;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = _refreshBarButtonItem;
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self loadPublicPhotoFeedWithForceRefresh:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark Network

- (void)loadPublicPhotoFeedWithForceRefresh:(BOOL)refresh
{
    [self.activityIndicator showWithAnimation:YES];
    
    QFGetPublicPhotoFeedOperation *getFeedOp =
    [[QFGetPublicPhotoFeedOperation alloc] initWithDelegate:self
                                                andSelector:@selector(publicPhotoFeedReturned:)];
    
    getFeedOp.forceRefresh = refresh;
    [getFeedOp run];
}

- (void)publicPhotoFeedReturned:(QFGetPublicPhotoFeedOperation *)op
{
    self.flickrResponse = op.outputResponse;
    self.title = _flickrResponse.title;
    [_tableView reloadData];
    
    [self.activityIndicator hideWithAnimation:YES];
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
        
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    FlickrPhoto *photo = [_flickrResponse.items objectAtIndex:indexPath.row];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.author;
    
    [cell.imageView loadImageFromFlickrPhoto:photo];
    
    return cell;
}

@end
