//
//  CompartirSafari.h
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareOpen : NSObject

+(ShareOpen *) getInstance;

-(void) openSafariURLFromString:(NSString *) string;
-(void) openChromeURLFromString:(NSString *) string;
-(void) openOperaMiniURLFromString:(NSString *) string;

-(void) openSearchChromeFromString:(NSString *) string;

-(void) openPhoneNumberFromString:(NSString *) string;
-(void) openMessage;

-(BOOL) existChrome;

@end
