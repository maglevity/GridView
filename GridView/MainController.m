//
//  ViewController.m
//  GridView
//
//  Created by John Magdziarz on 3/30/12.
//  Copyright (c) 2012 LiveColony. All rights reserved.
//

#import "MainController.h"
#import "GridViewCell.h"


@implementation MainController

@synthesize gridView;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_imageNames) {
        _imageNames = [[NSMutableArray alloc] init];
        NSString * resourcePath = [[NSBundle mainBundle] resourcePath];        
        NSError * error;
        NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:&error];   
        for (NSString *filename in directoryContents) {
            [_imageNames addObject:[NSString stringWithFormat:@"%@", filename]];
        }
        numImages = [_imageNames count];
    }
    
    self.gridView = [[GridView alloc] initWithFrame:[[UIScreen mainScreen] bounds] numberOfColumns:3];
    self.gridView.dataSource = self;
    self.view = gridView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (NSInteger)numberOfItemsInGridView:(GridView *)gridView {
    return numImages;
}

- (CGSize)sizeForItemsInGridView:(GridView *)gridView {
    return CGSizeMake(0, 0);
}

- (GridViewCell *)gridView:(GridView *)gridView cellForItemAtIndex:(NSInteger)index {
    NSString *imageName = [_imageNames objectAtIndex:index];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    GridViewCell *gridViewCell = [[GridViewCell alloc] initWithFrame:imageView.frame];
    gridViewCell.contentView = imageView;
    return gridViewCell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
