//
//  HDClientViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDClientViewController.h"
#import "GCDAsyncSocket.h"
@interface HDClientViewController () <GCDAsyncSocketDelegate>
//客户端socket
@property (nonatomic) GCDAsyncSocket *clinetSocket;

@end

@implementation HDClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    self.clinetSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark - GCDAsynSocket Delegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP ： %@", host]];
    [self.clinetSocket readDataWithTimeout:-1 tag:0];
}

//收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
    [self.clinetSocket readDataWithTimeout:-1 tag:0];
}


- (IBAction)connect:(id)sender {
    //2、连接服务器
    [self.clinetSocket connectToHost:self.ipTextField.text onPort:self.portTextField.text.integerValue withTimeout:-1 error:nil];

}

- (IBAction)send:(id)sender {
    NSData *data = [self.msgTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    //withTimeout -1 :无穷大
    //tag： 消息标记
    [self.clinetSocket writeData:data withTimeout:-1 tag:0];
}

- (IBAction)receive:(id)sender {
    [self.clinetSocket readDataWithTimeout:11 tag:0];
}

- (void)showMessageWithStr:(NSString *)str{
    self.receivedMsg.text = [self.receivedMsg.text stringByAppendingFormat:@"%@\n", str];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
