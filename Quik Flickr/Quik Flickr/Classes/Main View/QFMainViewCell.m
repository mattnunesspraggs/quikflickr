//
//  QFMainViewCell.m
//  Quik Flickr
//
//  Created by Matthew on 12/5/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import "QFMainViewCell.h"

@implementation QFMainViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // overriding layoutSubviews because
    // it's nigh-on impossible to set the
    // width of a table cell's imageView
    
    CGRect newFrame = self.imageView.frame;
    newFrame.size.width = 44.f;
    self.imageView.frame = newFrame;
    
    CGRect labelFrame = self.textLabel.frame;
    labelFrame.size.width = self.frame.size.width - 54.f;
    labelFrame.origin.x = 54.f;
    labelFrame.size.width -= 20;
    self.textLabel.frame = labelFrame;
    
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.size.width = self.frame.size.width - 54.f;
    detailFrame.origin.x = 54.f;
    detailFrame.size.width -= 20;
    self.detailTextLabel.frame = detailFrame;
}

@end
