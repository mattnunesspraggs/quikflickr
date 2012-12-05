//
//  QFModalActivityIndicator.h
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFModalActivityIndicator : UIView

+ (QFModalActivityIndicator *)modalActivityIndicator;

- (void)showWithAnimation:(BOOL)animated;
- (void)hideWithAnimation:(BOOL)animated;

@end
