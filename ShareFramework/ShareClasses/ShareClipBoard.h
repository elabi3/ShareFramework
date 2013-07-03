//
//  CompartirClipBoard.h
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareClipBoard : NSObject

+(ShareClipBoard *) getInstance;
-(void) copyStringToClipBoard:(NSString *) string;

@end
