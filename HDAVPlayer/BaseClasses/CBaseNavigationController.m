//
//  CBaseNavigationController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/4/7.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "CBaseNavigationController.h"

@interface CBaseNavigationController ()

@end

@implementation CBaseNavigationController

+ (void)initialize {
//    //设置导航栏颜色
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    [navigationBar setBarTintColor:[UIColor cyanColor]];
//    //设置标题栏颜色
//    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
//    //设置导航按钮颜色
//    [navigationBar setTintColor:[UIColor purpleColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
//重写父类方法,修改返回按钮的样式
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //1.修改返回按钮上面的文字
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:nil action:nil];
//    [super pushViewController:viewController animated:animated];
    //2.修改返回按钮的样式
    //这和判断是为了最底层的viewController不至于加上我们自定义的按钮
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1) {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
    }
    //重写了leftbaritem之后,需要添加如下方法才能重启右滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIBarButtonItem *)createBackButton {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"video_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}

- (void)popSelf {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
