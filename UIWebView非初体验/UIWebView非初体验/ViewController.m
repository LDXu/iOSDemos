//
//  ViewController.m
//  UIWebView非初体验
//
//  Created by 张威 on 15/6/16.
//  Copyright (c) 2015年 ZhangWei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property UIWebView *webView;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    // mainBundle path
    NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];
    
    // html base目录
    NSString *basePath = [NSString stringWithFormat:@"%@/html",mainBundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:basePath isDirectory:YES];
    NSLog(@"baseURL: %@", baseURL);
    
    // index.html path
    NSString *htmlPath = [NSString stringWithFormat:@"%@/index.html",basePath];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath
                                                     encoding:NSUTF8StringEncoding error:nil];
    
    // loading local content
    [self.webView loadHTMLString:htmlString baseURL:baseURL];

    [self.view addSubview:self.webView];
    self.webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // starting the load, show the activity indicator in the status bar
//    NSLog(@"webViewDidStartLoad:");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"webViewDidFinishLoad:");
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.webView loadHTMLString:errorString baseURL:nil];
}


/*
 加载网络数据是异步的还是同步的？我想是异步的吧！
 加载网络数据：
 - (void)loadRequest:(NSURLRequest *)request;
 
 加载HTML数据（手工HTML代码）：
 - (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
 加载本地数据：
 - (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
 */

@end
