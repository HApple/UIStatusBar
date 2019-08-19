//
//  ViewController.m
//  HHStatusBar
//
//  Created by huang on 2019/8/19.
//  Copyright © 2019 huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
}

/*
 Value  指的是 Info.plist  View controller-based status bar appearance
 VC     指的是 application.window rootViewController
 
 |-----------------------------------------------------------------------------------|
 |Target                                  Value          VC                          |
 |-----------------------------------------------------------------------------------|
 |VC-Base-NO                              NO             UIViewController            |
 |VC-Base-YES                             YES            UIViewController            |
 |UINavigationController-Base-YES         YES            HHNavigationController      |
 |UITabbarController-Base-YES             YES            UITabbarController          |
 |-----------------------------------------------------------------------------------|
 
 */



/*
 
 经过测试
 如果 Info.plist  View controller-based status bar appearance 不设置，默认为YES
 
 1. 运行 VC-Base-NO    此方法不调用
 
 2. 运行 VC-Base-YES   此方法调用生效
 
 3. 运行 UINavigationController-Base-YES
    (1)ViewController直接放在UINavigationController里 此方法不生效
    (2)具体看ViewController.m重写的方法，加上重写的方法 此方法生效
 
 4. 运行 UITabarController-Base-YES 此方法调用生效
    ViewController直接放在UITabbarController里是生效
 */

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
