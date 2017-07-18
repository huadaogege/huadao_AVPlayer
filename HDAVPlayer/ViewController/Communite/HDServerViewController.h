//
//  HDServerViewController.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewController.h"

@interface HDServerViewController : HDViewController

@property (strong, nonatomic) IBOutlet UITextField *portTextField;

@property (strong, nonatomic) IBOutlet UIButton *listenBth;

@property (strong, nonatomic) IBOutlet UITextField *sendMsgTextField;

@property (strong, nonatomic) IBOutlet UITextView *receivedTextView;


@end
