//
//  CHPathHelper.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHPathHelper.h"

@implementation CHPathHelper
NSString *PathForFileInDocumentsDirectory(NSString *filepath) {
  return [DocumentsDirectory() stringByAppendingPathComponent:filepath];
}

NSString *DocumentsDirectory() {
  NSString *docsDir = nil;
  NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  if ([directories count] > 0) {
    docsDir = [directories objectAtIndex:0];
  }
  
  if(!docsDir) {
    [NSException raise:@"Critical Error" format:@"Can't find the documents directory!"];
  }
  
  return docsDir;
}

@end
