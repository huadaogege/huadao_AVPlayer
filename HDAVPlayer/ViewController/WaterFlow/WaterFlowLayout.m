//
//  WaterFlowLayout.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/7/22.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "WaterFlowLayout.h"

#define colMargin 5 //边距
#define colCount 3 //列数

@interface WaterFlowLayout ()

@property (nonatomic, strong) NSMutableArray *columnHeightArray;//存放每一列总高度的数组
@property (nonatomic, assign) CGFloat columnWidth;//单元格的宽度

@end

@implementation WaterFlowLayout

- (instancetype)initWithBlock:(heightBlock)heightblock {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.heightblock = heightblock;
    }
    return self;
}

- (NSMutableArray *)columnHeightArray {
    if (!_columnHeightArray) {
        _columnHeightArray = [[NSMutableArray alloc] init];
    }
    return _columnHeightArray;
}

#pragma mark -- 重写下面的方法 --

// 完成布局的初始工作
- (void)prepareLayout {
    [super prepareLayout];
    self.columnWidth = (self.collectionView.frame.size.width - (colCount+1)*colMargin)/colCount;
    [self.columnHeightArray removeAllObjects];
    [self.columnHeightArray addObjectsFromArray:@[[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0]]];
}

// collectionView的内容尺寸
- (CGSize)collectionViewContentSize {
    //遍历数组寻找出最长的那一列, 确定collectionView的尺寸
    NSNumber *longest = self.columnHeightArray[0];
    for (int i = 0; i < self.columnHeightArray.count; i ++) {
        NSNumber *rolheignt = self.columnHeightArray[i];
        if (longest.floatValue < rolheignt.floatValue) {
            longest = rolheignt;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, longest.floatValue);
}

// 为每个item设置属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSNumber *shortHeigt = self.columnHeightArray[0];
    NSInteger shortIndex = 0;
    for (int i = 0; i < self.columnHeightArray.count; i ++) {
        NSNumber *colHeigt = self.columnHeightArray[i];
        if (colHeigt.floatValue < shortHeigt.floatValue) {
            shortHeigt = colHeigt;
            shortIndex = i;
        }
    }
    CGFloat X = (shortIndex+1)*colMargin + shortIndex*self.columnWidth;
    CGFloat Y = shortHeigt.floatValue + colMargin;
    //获取cell高度
    NSAssert(self.heightblock != nil, @"未实现计算高度的block ");
    NSUInteger randomCellHegith = self.heightblock(indexPath);
    attribute.frame = CGRectMake(X, Y, self.columnWidth, randomCellHegith);
    self.columnHeightArray[shortIndex] = [NSNumber numberWithInt:(Y+randomCellHegith)];
    return attribute;
}

//获取制定范围的所有item的属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < items; i ++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [array addObject:attribute];
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
