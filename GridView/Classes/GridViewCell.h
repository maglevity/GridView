//
//  GridViewCell.h
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewCell : UIView <UIGestureRecognizerDelegate> {
    UIView *_contentView;
    CGFloat _lastScale;
}

@property (nonatomic, strong) UIView *contentView;

@end
