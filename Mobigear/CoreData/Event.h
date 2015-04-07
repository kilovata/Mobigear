//
//  Event.h
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Article.h"


@interface Event : Article

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * go;

@end
