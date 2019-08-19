//
//  HHNavigationController.m
//  UINavigationController-Base-YES
//
//  Created by huang on 2019/8/19.
//  Copyright © 2019 huang. All rights reserved.
//

#import "HHNavigationController.h"

@interface HHNavigationController ()

@end

@implementation HHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - StatusBar
/*
 0x01
 0x02
 任选一种即可
 */

#pragma mark - StatusBar - 0x01
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}


#pragma mark - StatusBar - 0x02
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
@end
