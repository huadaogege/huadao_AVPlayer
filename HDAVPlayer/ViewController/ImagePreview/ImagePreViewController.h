//
//  ImagePreViewController.h
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewController.h"

@interface ImagePreViewController : HDViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *dataArray;

@end
