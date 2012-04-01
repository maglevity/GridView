//
//  GridViewCell.m
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import "GridViewCell.h"

@implementation GridViewCell

@synthesize contentView = _contentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setContentView:(UIView *)contentView
{
    [self.contentView removeFromSuperview];
    
    if(self.contentView)
    {
        contentView.frame = self.contentView.frame;
    }
    _contentView = contentView;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.contentView];
}

@end
