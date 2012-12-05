//
//  QFGetPublicPhotoFeedOperation.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFNetworkOperation.h"

@class FlickrPublicFeedResponse;
@interface QFGetPublicPhotoFeedOperation : QFNetworkOperation

@property (assign, nonatomic) BOOL forceRefresh;
@property (strong, nonatomic) FlickrPublicFeedResponse *outputResponse;

@end
