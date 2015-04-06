//
//  Event.h
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Article.h"


@interface Event : Article

@property (nonatomic, retain) NSDate * date;

@end
