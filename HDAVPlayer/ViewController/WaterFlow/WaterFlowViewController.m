//
//  WaterFlowViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/7/22.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "WaterFlowViewController.h"
#import "WaterFlowLayout.h"

#define WaterFlowCellIdentifier @"__WaterFlowCellIdentifier__"

@interface WaterFlowViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@end

@implementation WaterFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self prepareData];
}

- (void)prepareData {
    for (int i = 0; i < 50; i ++) {
        CGFloat height = random() % 100 + 80;
        [self.cellHeightArray addObject:[NSNumber numberWithInt:height]];
    }
    NSLog(@"%@", self.cellHeightArray);
}

- (NSMutableArray *)cellHeightArray {
    if (!_cellHeightArray) {
        _cellHeightArray = [[NSMutableArray alloc] init];
    }
    return _cellHeightArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] initWithBlock:^CGFloat(NSIndexPath *indexPath) {
            NSNumber *height = self.cellHeightArray[indexPath.row];
            return height.floatValue;
        }];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 74, Screen_width, Screen_height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:WaterFlowCellIdentifier];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterFlowCellIdentifier forIndexPath:indexPath];
    CGFloat r = random()%255;
    CGFloat g = random()%255;
    CGFloat b = random()%255;
    cell.backgroundColor = COLOR(r, g, b);
    return cell;
}

//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    return CGSizeMake(100, 100);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
