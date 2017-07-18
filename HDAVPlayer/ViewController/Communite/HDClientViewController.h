//
//  HDClientViewController.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewController.h"

@interface HDClientViewController : HDViewController

@property (strong, nonatomic) IBOutlet UITextField *ipTextField;

@property (strong, nonatomic) IBOutlet UITextField *portTextField;

@property (strong, nonatomic) IBOutlet UITextField *msgTextField;

@property (strong, nonatomic) IBOutlet UITextView *receivedMsg;


@end
