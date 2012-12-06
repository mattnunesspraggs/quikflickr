//
//  QFGetPublicPhotoFeedOperation.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFGetPublicPhotoFeedOperation.h"
#import "FlickrPublicFeedResponse.h"
#import "SBJson.h"

@interface QFGetPublicPhotoFeedOperation ()

- (void)parseResponseData;

@end

@implementation QFGetPublicPhotoFeedOperation

- (void)main
{
    static NSString *urlString = @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1]";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequestCachePolicy cachePolicy = (_forceRefresh ?
                                           NSURLRequestReloadIgnoringLocalCacheData :
                                           NSURLRequestUseProtocolCachePolicy);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:cachePolicy
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
        
        [self parseResponseData];
    }
    
    [self notifyDelegateOfTermination];
}

- (void)parseResponseData
{
    if ([self wasSuccessful]) {
        NSString *jsonString = [[NSString alloc] initWithData:self.responseData
                                                     encoding:NSUTF8StringEncoding];
        
        // surprise! Flickr sends down b0rked JSON sometimes... inccorectly
        // escaped apostrophes. This fixes it.
        NSMutableString *string = [NSMutableString stringWithString:jsonString];
        [string replaceOccurrencesOfString:@"\\'"
                                withString:@"\'"
                                   options:NSCaseInsensitiveSearch
                                     range:NSMakeRange(0, [jsonString length])];
        jsonString = [NSString stringWithString:string];
        
        NSDictionary *jsonObject = [jsonString JSONValue];
        self.outputResponse = [FlickrPublicFeedResponse instanceFromDictionary:jsonObject];
    }
}

@end
