//
//  AppDelegate.h
//  GLCollectionLayout
//
//  Created by Olive on 2016/11/1.
//  Copyright © 2016年 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

