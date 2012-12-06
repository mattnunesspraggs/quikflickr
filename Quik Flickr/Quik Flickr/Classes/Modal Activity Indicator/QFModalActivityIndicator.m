//
//  QFModalActivityIndicator.m
//  Quik Flickr
//
//  Created by Matthew on 12/4/12.
//  Copyright (c) 2012 Matthew Nunes. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "QFModalActivityIndicator.h"

static NSTimeInterval animationDuration = .5f;

@interface QFModalActivityIndicator ()

@property (unsafe_unretained, nonatomic) IBOutlet UIView *spinnerView;

@end

@implementation QFModalActivityIndicator

+ (QFModalActivityIndicator *)modalActivityIndicator
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ModalActivityIndicator" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    _spinnerView.layer.cornerRadius = 10.f;
}

- (void)didMoveToSuperview
{
    [self hideWithAnimation:NO];
    self.frame = [self.superview bounds];
}

- (void)showWithAnimation:(BOOL)animated
{
    [self.superview bringSubviewToFront:self];
    
    if (animated) {
        [UIView beginAnimations:@"Show ModalActivityIndicator" context:nil];
        [UIView setAnimationDuration:animationDuration];
    }
    
    self.alpha = 1.f;
    
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)hideWithAnimation:(BOOL)animated
{
    if (animated) {
        [UIView beginAnimations:@"Hide ModalActivityIndicator" context:nil];
        [UIView setAnimationDuration:animationDuration];
    }
    
    self.alpha = 0.f;
    
    if (animated) {
        [UIView commitAnimations];
        [self.superview performSelector:@selector(sendSubviewToBack:) withObject:self afterDelay:animationDuration];
    }
    else {
        [self.superview sendSubviewToBack:self];
    }
}

@end
