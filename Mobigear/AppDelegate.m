//
//  AppDelegate.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData+MagicalRecord.h>
#import "MainViewController.h"
#import "TestModel.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Mobigear.sqlite"];
    
    TestModel *testModel = [TestModel new];
    [testModel initEntities];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
