//
//  AppDelegate.m
//  MyMechanic
//
//  Created by Devin Brooks, Jake Logan, and J'Darius Bush on 10/10/12.
//  Copyright (c) 2012 Devin Brooks, Jake Logan, and J'Darius Bush. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Splash Screen
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    splashView.image = [UIImage imageNamed:@"Default.png"];
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
    
    // Initialize home screen
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:home];
    navigationController.toolbarHidden = NO;
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    sleep(3);
    
    //Remove Splash Screen
    [splashView removeFromSuperview];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    return YES;
}

@end
