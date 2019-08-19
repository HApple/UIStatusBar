# UIStatusBar
iOS 设置状态栏详解
### 状态栏隐藏



1. 通过Info.plist控制

   （1） 在 `View controller-based status bar appearance` (Info.plist) -> NO

   （2） 在 `Status bar is initially hidden` (Info.plist)  -> YES/NO.   或者 Target -> General -> Hide status bar

2. 通过代码控制

   在 `View controller-based status bar appearance` (Info.plist) 

   `YES`	->	则控制器对状态栏设置的优先级高于`application`     ->      ` UIViewController prefersStatusBarHidden`

   `NO`    ->    则-以`application`为准， 控制器设置状态栏无效 -> `[[UIApplication sharedApplication] setStatusBarHidden:YES]`

   ​    

### 状态栏设置

在 `View controller-based status bar appearance` (Info.plist)

`YES`	->	则控制器对状态栏设置的优先级高于`application`     ->      ` UIViewController preferredStatusBarStyle`

`NO`    ->    则-以`application`为准， 控制器设置状态栏无效 -> `[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]`



##### 1.通过`UIApplication`

前提 在 `View controller-based status bar appearance` (Info.plist) -> NO

iOS9之后已弃用  不推荐

```objective-c
[[UIApplication sharedApplication] setStatusBarHidden:YES];
[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];

[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];  
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

```



##### 2.通过`UIViewController`

前提 在 `View controller-based status bar appearance` (Info.plist) -> YES

iOS7之后添加的方法	推荐使用

```
- (void)setNeedsStatusBarAppearcanceUpdate;
- (UIStatusBarStyle)preferredStatusBarSytle;
- (UIViewController *)childViewControllerForStatusBarStyle;
- (BOOL)prefersStatusBarHidden;
```



###### 0x01 `setNeedsStatusBarApearanceUpdate()`

- 当我们调用 `setNeedsStatusBarApearanceUpdate()` 时，系统会调用`application.window`的`rootViewController`的`preferredStatusBarStyle`方法

- 如果在`UIViewController`已经显示，这时还要在当前页面不时的更改`statusBar`的前景色，那么，你首先需要调用 `setNeedsStatusBarApearanceUpdate()`,这个和`UIView`的`setNeedsDisplay`差不多

  

###### 0x02   `(UIStatusBarStyle)preferredStatusBarSytle` 

在你自己的 `UIViewController`	里重写此方法，返回 `UIStatusBarStyleDefault` 或者 `UIStatusBarStyleLightContent`

- 这里如果你只是简单`return`一个固定的值，那么该`UIViewController`显示的时候，程序就会马上调用该方法，来改变statusBar的外观

- 这里有个常见的问题重写`preferredStatusBarSytle` 不调用不生效，因为这个只有在`UIViewController`单独使用才会生效，但是我们大部分情况下，`ViewController`都会嵌套在`UINavigationController`中,解决办法也可以子类化UINavigationController,重写`preferredStatusBarStyle`

- ```objective-c
  //HHNavigationController.h
  #import <UIKit/UIKit.h>
  @interface HHNavigationController: UINavigationController
  @end
  
  @implementation HHNavigationController
  
  - (UIStatusBarStyle)preferredStatusBarStyle{
      return self.topViewController.preferredStatusBarStyle;
  }
  
  @end
  ```

  

###### 0x03 `(UIViewController *)childViewControllerForStatusBarStyle`

- 默认返回值为nil.

- 0x01上面说了，当我们调用 `setNeedsStatusBarApearanceUpdate()` 时，系统会调用`application.window`的`rootViewController`的`preferredStatusBarStyle`方法，如果这个`rootViewController`是`UINavigationController`,那我们自己的`UIViewController`里的`preferredStatusBarStyle`根本不会调用，这也是0x02提到的原因

- 解决0x02 `(UIStatusBarStyle)preferredStatusBarSytle` 不调用，也可以子类化UINavigationController,重写

  `childViewControllerForStatusBarStyle`

  ```objective-c
  //HHNavigationController.h
  #import <UIKit/UIKit.h>
  @interface HHNavigationController: UINavigationController
  @end
  
  @implementation HHNavigationController
  
    - (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
  }
  
  @end
  ```

  

###### 0x04  `(BOOL)prefersStatusBarHidden`

返回YES/NO来这是状态栏的隐藏/显示,用法与`preferredStatusBarSytle`一致



### 总结

经过代码实践 ，Demo在这里

经过测试 如果 Info.plist  View controller-based status bar appearance 不设置，默认为YES

加上舍弃弃用方法，我们只需要遵循

子类化一个`UINavigationController`的类，重写

```objective-c
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
```



即可达到每个页面可以控制状态栏的效果



### 参考

[iOS状态栏详解](https://www.jianshu.com/p/4196d7cf95f4)

[谈一谈iOS开发中info.plist中的View controller-based status bar appearance属性](https://www.jianshu.com/p/334e6974303a)
