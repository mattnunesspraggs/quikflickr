//
//  QFPhotoViewController.h
//  Quik Flickr
//
//  Created by Matthew on 12/5/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFViewController.h"
#import "FlickrPhoto.h"

@interface QFPhotoViewController : QFViewController

+ (QFPhotoViewController *)viewController;

@property (nonatomic, strong) FlickrPhoto *photo;

@end
