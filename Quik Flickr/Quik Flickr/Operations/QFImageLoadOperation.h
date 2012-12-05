//
//  QFImageLoadOperation.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFNetworkOperation.h"

@class FlickrPhoto;
@interface QFImageLoadOperation : QFNetworkOperation

@property (strong, nonatomic) FlickrPhoto *inputPhoto;
@property (strong, nonatomic) NSURL *inputURL;

@property (strong, nonatomic) UIImage *outputImage;

@end
