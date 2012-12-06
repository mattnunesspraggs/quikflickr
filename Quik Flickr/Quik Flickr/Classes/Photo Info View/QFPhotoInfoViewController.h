//
//  QFPhotoInfoViewController.h
//  Quik Flickr
//
//  Created by Matthew on 12/5/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFViewController.h"

@class FlickrPhoto;
@interface QFPhotoInfoViewController : QFViewController

+ (QFPhotoInfoViewController *)viewController;

@property (strong, nonatomic) FlickrPhoto *photo;

@end
