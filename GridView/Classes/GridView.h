//
//  GridView.h
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridView;
@class GridViewCell;

@protocol GridViewDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInGridView:(GridView *)gridView;
- (CGSize)sizeForItemsInGridView:(GridView *)gridView;
- (GridViewCell *)gridView:(GridView *)gridView cellForItemAtIndex:(NSInteger)index;

@end

@interface CellData : NSObject {
    
    NSInteger yPos;
    NSInteger yMax;
    NSString *title;
    CGRect fixedFrame;
}

@property (nonatomic, assign) NSInteger yPos;                    
@property (nonatomic, assign) NSInteger yMax;                    
@property (nonatomic) NSString *title;                    
@property (nonatomic, assign) CGRect fixedFrame;                    

@end


@interface GridView : UIView  <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    UIScrollView *_scrollView;
    NSInteger _numberOfColumns;
    CGFloat _columnWidth;
    NSObject<GridViewDataSource> *_dataSource;
    NSMutableArray *_columnTrackerCells;
    NSMutableArray *_itemCells;

    CGFloat _lastScale;
    UITapGestureRecognizer       *_tapGesture;
    UIPinchGestureRecognizer     *_pinchGesture;
}

@property (nonatomic, strong) NSObject<GridViewDataSource> *dataSource;                    
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemCells;

- (id)initWithFrame:(CGRect)frame numberOfColumns:(NSInteger)numberOfColumns;
- (void)handlePinch:(UITapGestureRecognizer *)recognizer;

@end
