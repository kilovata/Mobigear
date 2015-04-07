//
//  DataSource.h
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData+MagicalRecord.h>

@interface DataSource : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)setupFetchResultsControllerWithRequest:(NSFetchRequest*)request;

@end
