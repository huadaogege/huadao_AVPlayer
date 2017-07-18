//
//  HDServerViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDServerViewController.h"
#import "GCDAsyncSocket.h"

@interface HDServerViewController () <GCDAsyncSocketDelegate>

//服务器socket（开放端口，监听客户端socket的链接）
@property (nonatomic) GCDAsyncSocket *serverSocket;

//保护客户端socket
@property (nonatomic) GCDAsyncSocket *clientSocket;


@end

@implementation HDServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、初始化服务器socket，在主线程力回调
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // Do any additional setup after loading the view from its nib.
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    //保存客户端的socket
    self.clientSocket = newSocket;
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器地址：%@ -端口： %d", newSocket.connectedHost, newSocket.connectedPort]];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

//收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (IBAction)listenBtn:(id)sender {
    //2、开放哪一个端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.portTextField.text.integerValue error:&error];
    if (result && error == nil) {
        //开放成功
        [self showMessageWithStr:@"开放成功"];
    }

}

- (IBAction)sendBtn:(id)sender {
    NSData *data = [self.sendMsgTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    //withTimeout -1:无穷大，一直等
    //tag:消息标记
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

- (IBAction)receivedBtn:(id)sender {
    [self.clientSocket readDataWithTimeout:11 tag:0];
}

- (void)showMessageWithStr:(NSString *)str{
    self.receivedTextView.text = [self.receivedTextView.text stringByAppendingFormat:@"%@\n",str];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
