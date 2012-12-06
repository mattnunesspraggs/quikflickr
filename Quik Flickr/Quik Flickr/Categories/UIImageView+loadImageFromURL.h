//
//  UIImageView+loadImageFromURL.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QFImageLoadOperation, FlickrPhoto;
@interface UIImageView (loadImageFromURL)

- (void)loadImageFromFlickrPhoto:(FlickrPhoto *)photo;
- (void)loadImageFromFlickrPhoto:(FlickrPhoto *)photo
                      usingQueue:(NSOperationQueue *)queue;

- (void)loadImageFromURL:(NSURL *)url;
- (void)imageLoaded:(QFImageLoadOperation *)op;

- (void)fadeIn;

@end
