//
//  UIImageView+loadImageFromURL.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "UIImageView+loadImageFromURL.h"
#import "QFOperationQueue.h"
#import "QFImageLoadOperation.h"
#import "FlickrPhoto.h"

@implementation UIImageView (loadImageFromURL)

- (void)loadImageFromFlickrPhoto:(FlickrPhoto *)photo
{
    [self loadImageFromFlickrPhoto:photo usingQueue:[QFOperationQueue shared]];
}

- (void)loadImageFromFlickrPhoto:(FlickrPhoto *)photo
                      usingQueue:(NSOperationQueue *)queue
{
    if (photo.image) {
        [self setImage:photo.image];
        [self fadeIn];
    }
    else {
        self.image = [UIImage imageNamed:@"questionmark"];
    
        QFImageLoadOperation *imageLoad = [[QFImageLoadOperation alloc] initWithDelegate:self andSelector:@selector(imageLoaded:)];
        imageLoad.inputPhoto = photo;
        [imageLoad runInQueue:queue];
    }
}

- (void)loadImageFromURL:(NSURL *)url
{
    self.image = [UIImage imageNamed:@"questionmark"];
    [self fadeIn];
    
    QFImageLoadOperation *imageLoad = [[QFImageLoadOperation alloc] initWithDelegate:self andSelector:@selector(imageLoaded:)];
    imageLoad.inputURL = url;
    [imageLoad run];
}

- (void)imageLoaded:(QFImageLoadOperation *)op
{
    if (op.successful && op.outputImage) {
        
        [UIView animateWithDuration:0.2f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (op.outputImage) {
                self.image = op.outputImage;
            }
            
            [self fadeIn];
        }];
        
    }
}

- (void)fadeIn
{
    [UIView animateWithDuration:0.4f animations:^{
        self.alpha = 1;
    }];
}

@end
