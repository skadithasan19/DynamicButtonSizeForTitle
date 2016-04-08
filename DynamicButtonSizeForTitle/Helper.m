//
//  Helper.m
//  DynamicButtonSizeForTitle
//
//  Created by Md Adit Hasan on 4/7/16.
//  Copyright © 2016 Adit. All rights reserved.
//

#import "Helper.h"

@implementation Helper


+ (CGSize)sizeByStringContent:(NSString *)string {
    CGSize constraint = CGSizeMake(320 - (50 * 2), 20000.0f);
    
    CGRect textRect = [string boundingRectWithSize:constraint
                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]}
                                                                   context:nil];
    
    return textRect.size;
}


/* adding contraints*/

+ (void)setConstraintsToView:(UIView *)ExistingItemVIew modifyItem:(UIView *)modifyItemView scrollview:(UIScrollView*)mainView fitheight:(CGFloat)height{
    
    UIView *bottomView = modifyItemView;
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:bottomView];
    
    [mainView addConstraint:[NSLayoutConstraint constraintWithItem:bottomView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:ExistingItemVIew
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f]];
    
    // Height constraint, half of parent view height
    [bottomView addConstraint:[NSLayoutConstraint constraintWithItem:bottomView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:height]];
    
    
    [mainView addConstraint:[NSLayoutConstraint constraintWithItem:bottomView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:mainView
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f]];
    
    [mainView addConstraint:[NSLayoutConstraint constraintWithItem:bottomView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:mainView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0f
                                                          constant:0.0f]];
    
}

@end
