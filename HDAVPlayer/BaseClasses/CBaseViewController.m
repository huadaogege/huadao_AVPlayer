//
//  CBaseViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/4/7.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "CBaseViewController.h"

#define CBaseViewSize self.baseView.bounds.size
#define CBaseViewSizeHeight self.baseView.bounds.size.height
#define CBaseViewSizeWidth self.baseView.bounds.size.width

@interface CBaseViewController ()

@end

@implementation CBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    //判断是否有上级页面,有的话在调用
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self setupLeftBarButton];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat baseViewHeignt = 0;
    CGFloat baseViewWidth = 0;
    NSArray *subViews = self.baseView.subviews;
    //遍历视图中所有的控件，求出最大值Y和最大值X
    for (UIView *view in subViews) {
        if (CGRectGetMaxX(view.frame) > baseViewWidth) {
            baseViewWidth = CGRectGetMaxX(view.frame);
        }
        if (CGRectGetMaxY(view.frame) > baseViewHeignt) {
            baseViewHeignt = CGRectGetMaxY(view.frame);
        }
    }
    //三目运算求出最大的宽和最大的高
    CGFloat Cheight = baseViewHeignt > CBaseViewSizeHeight ? baseViewHeignt : CBaseViewSizeHeight;
    CGFloat Cwidth = baseViewWidth > CBaseViewSizeWidth ? baseViewWidth : CBaseViewSizeWidth;
    self.baseView.contentSize = CGSizeMake(Cwidth, Cheight);
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    //不允许控制器自动调整，否则视图会下移64像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat barHeight = kDevice_Is_iPhoneX ? 84 : 64;
    self.baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                   barHeight,
                                                                   Screen_width,
                                                                   Screen_height - barHeight)];
    //是否反弹
    self.baseView.bounces = NO;
    //是否显示指示器
    self.baseView.showsVerticalScrollIndicator = NO;
    self.baseView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.baseView];
    self.baseView.contentSize = CBaseViewSize;
}

- (void)setupLeftBarButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"video_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
