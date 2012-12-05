//
//  QFImageLoadOperation.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFImageLoadOperation.h"
#import "FlickrPhoto.h"

@implementation QFImageLoadOperation

- (void)main
{
    if (!_inputURL && _inputPhoto) {
        self.inputURL = [_inputPhoto publicURL];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_inputURL
                                                           cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                       timeoutInterval:10.f];
    
    [request addValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSHTTPURLResponse *response = nil;
    NSError *fetchError = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&fetchError];
    
    self.response = response;
    if (fetchError) {
        self.successful = NO;
        self.responseError = fetchError;
    }
    else {
        self.successful = YES;
        self.responseData = responseData;
        
        self.outputImage = [UIImage imageWithData:responseData];
        if (_inputPhoto) {
            _inputPhoto.image = _outputImage;
        }
    }
    
    [self notifyDelegateOfTermination];
}

@end
