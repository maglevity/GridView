//
//  GridView.m
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import "GridView.h"
#import "GridViewCell.h"


@implementation CellData

@synthesize yPos,
yMax,
title,
fixedFrame;

@end


@implementation GridView

@synthesize scrollView = _scrollView,
dataSource = _dataSource,
itemCells = _itemCells;

- (id)initWithFrame:(CGRect)frame numberOfColumns:(NSInteger)numberOfColumns {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _numberOfColumns = numberOfColumns;
        _columnWidth = [[UIScreen mainScreen] bounds].size.width / _numberOfColumns;
        _columnTrackerCells = [NSMutableArray arrayWithCapacity:_numberOfColumns];
        self.itemCells = [NSMutableArray array];
        for (int i = 0; i < _numberOfColumns; i++) {
            [_columnTrackerCells insertObject:[[CellData alloc] init] atIndex:i];
        }
        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

- (void)populateInitialCells {
    NSInteger _scrollViewMax = 0;
    NSInteger itemCount = [self.dataSource numberOfItemsInGridView:self];
    
    for (int itemIndex = 0; itemIndex < itemCount; itemIndex++) {
        if (itemIndex >= itemCount) {
            break;
        }
        
        GridViewCell *gridViewCell = [self.dataSource gridView:self cellForItemAtIndex:itemIndex];
        gridViewCell.tag = itemIndex;
        
        UIPinchGestureRecognizer * recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        recognizer.delegate = self;
        [gridViewCell addGestureRecognizer:recognizer];
        
        CGFloat aspectRatio = _columnWidth / gridViewCell.frame.size.width;
        NSInteger cellHeight = gridViewCell.frame.size.height * aspectRatio;
        
        // Simple logic to determine which column to put the next image in
        // by net total height
        NSInteger minColumnHeight = NSIntegerMax;
        CellData *cellData;
        int targetColumn = 0;
        for (int column = 0; column < _numberOfColumns; column++) {
            cellData = [_columnTrackerCells objectAtIndex:column];
            if (cellData.yMax + cellHeight < minColumnHeight) {
                minColumnHeight = cellData.yMax + cellHeight;
                targetColumn = column;
            }
        }
        cellData = [_columnTrackerCells objectAtIndex:targetColumn];
        cellData.yMax += cellHeight;
        CGRect gridCellFrame = CGRectMake(targetColumn * _columnWidth, cellData.yPos,
                                          _columnWidth, cellHeight);
        gridViewCell.frame = gridCellFrame;
        
        CellData *itemCell = [[CellData alloc] init];
        itemCell.fixedFrame = gridViewCell.frame;
        [self.itemCells insertObject:itemCell atIndex:itemIndex];
        
        [self.scrollView addSubview:gridViewCell];
        cellData.yPos = cellData.yMax;
        _scrollViewMax = MAX(_scrollViewMax, cellData.yMax);
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, _scrollViewMax);    
    }
}

- (BOOL)needMoreCells {
    
    BOOL _needMoreCells = FALSE;
    for (int column = 0; column < _numberOfColumns; column++) {
        CellData *cellData = [_columnTrackerCells objectAtIndex:column];
        if (cellData.yMax < self.frame.size.height) {
            _needMoreCells = TRUE;
        }
    }
    return _needMoreCells;
}

- (void)setDataSource:(NSObject<GridViewDataSource> *)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)reloadData {
    [self populateInitialCells];    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    return;
}


- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {    
    
    UIView *cellView = [recognizer view];
    [self.scrollView bringSubviewToFront:cellView];
    NSInteger itemIndex = cellView.tag;
	if([recognizer state] == UIGestureRecognizerStateEnded) {
        if ([recognizer scale] < 1.0) {
            cellView.frame = ((CellData *)[self.itemCells objectAtIndex:itemIndex]).fixedFrame;
        } 
        else {
            CGFloat aspectRatio = self.frame.size.width / cellView.frame.size.width;
            CGFloat cellHeight = cellView.frame.size.height * aspectRatio;
            CGFloat yPos = self.frame.size.height / 2 - cellHeight / 2 + self.scrollView.contentOffset.y;
            CGRect cellFrame = CGRectMake(0, yPos, self.frame.size.width, cellHeight);
            cellView.frame = cellFrame;
        }
        
		_lastScale = 1.0;
		return;
	}
    
	CGFloat scale = 1.0 - (_lastScale - [recognizer scale]);
    
	CGAffineTransform currentTransform = cellView.transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
	[cellView setTransform:newTransform];
    
	_lastScale = [recognizer scale];
}

@end
