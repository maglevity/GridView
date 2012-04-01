//
//  ViewController.h
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"

@interface MainController : UIViewController <GridViewDataSource> {
    NSMutableArray *_imageNames;
    NSInteger numImages;
    
    GridView *gridView;
}

@property (nonatomic, retain) GridView *gridView;

@end

