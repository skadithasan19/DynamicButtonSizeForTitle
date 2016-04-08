//
//  Helper.h
//  DynamicButtonSizeForTitle
//
//  Created by Md Adit Hasan on 4/7/16.
//  Copyright © 2016 Adit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (CGSize)sizeByStringContent:(NSString *)string;

+ (void)setConstraintsToView:(UIView *)ExistingItemVIew modifyItem:(UIView *)modifyItemView scrollview:(UIScrollView*)mainView fitheight:(CGFloat)height;

@end
