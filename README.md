# USIndeterminateProgressBarView
An iOS objective C library that replicates the pre-lollipop android intermediate progress bar.

##AppDelegate: 

```objective-c
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationInBackground" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationInForeground" object:nil];
}
```

##Usage:

```objective-c
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    USIndeterminateProgressBarView *indeterminateProgressBarView = [[USIndeterminateProgressBarView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height - 2, navigationBar.frame.size.width, 3) numberOfBars:3 marginWidth:5 timeTakenByOneBarToCoverScreen:2 barColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [navigationBar addSubview:indeterminateProgressBarView];
```
