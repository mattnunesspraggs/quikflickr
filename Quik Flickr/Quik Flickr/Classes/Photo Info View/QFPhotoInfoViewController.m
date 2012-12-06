//
//  QFPhotoInfoViewController.m
//  Quik Flickr
//
//  Created by Matthew on 12/5/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFPhotoInfoViewController.h"
#import "FlickrPhoto.h"

@interface QFPhotoInfoViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)doneButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QFPhotoInfoViewController

+ (QFPhotoInfoViewController *)viewController
{
    return [[[self class] alloc] initWithNibName:@"QFPhotoInfoViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Photo Info", @"Photo Info");
        self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Photo", @"Photo");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = _doneButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonTouched:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setDoneButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_tableView reloadData];
}

#pragma mark TableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *title = @"";
    NSString *value = @"";
    switch (indexPath.row) {
        case 0:
            title = NSLocalizedString(@"Title", @"Title");
            value = _photo.title;
            break;
        case 1:
            title = NSLocalizedString(@"Author", @"Author");
            value = _photo.author;
            break;
        case 2:
        {
            title = NSLocalizedString(@"Date Published", @"Date Published");
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
            NSDate *date = [dateFormatter dateFromString:_photo.published];
            [dateFormatter setDateStyle:NSDateFormatterFullStyle];
            NSString *formattedDate = [dateFormatter stringFromDate:date];
            value = formattedDate;
            break;
        }
        case 3:
            title = NSLocalizedString(@"Tags", @"Tags");
            if (![_photo.tags length]) {
                value = @" ";
            }
            else {
                value = _photo.tags;
            }
            break;
        case 4:
            title = @"";
            value = NSLocalizedString(@"View In Browser", @"View In Browser");
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        default:
            break;
    }
    
    cell.textLabel.text = value;
    cell.detailTextLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        NSURL *urlToPage = [NSURL URLWithString:_photo.link];
        [[UIApplication sharedApplication] openURL:urlToPage];
    }
}

@end
