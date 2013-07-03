//
//  CompartirSafari.m
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ShareOpen.h"

static ShareOpen *instance;

@implementation ShareOpen

+(ShareOpen *) getInstance {
    if (instance == nil) {
        instance = [[ShareOpen alloc] init];
    }
    return instance;
}

-(void) openSafariURLFromString:(NSString *) string {
    if (![self searchInString:string cadena:@"http://"]) {
        NSString *temp = [NSString stringWithFormat:@"http://%@", string];
        string = temp;
    }
    
    NSURL *url = [NSURL URLWithString:string];
    [[UIApplication sharedApplication] openURL:url];
}

-(BOOL) searchInString:(NSString *) origen cadena:(NSString *) cadena {
    // Ponemos en minusculas
    cadena = [cadena lowercaseString];
    // Quitamos blancos delante y detras
    cadena = [cadena stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // Quitamos las tildes
    cadena = [cadena stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale: [NSLocale currentLocale]];
    origen = [origen stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale: [NSLocale currentLocale]];
    // Realizmos la busqueda
    NSRange rangeValue = [origen rangeOfString:cadena options:NSCaseInsensitiveSearch];
    if (rangeValue.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

-(void) openChromeURLFromString:(NSString *) string {
    NSURL *inputURL = [NSURL URLWithString:string];
    NSString *scheme = inputURL.scheme;
    
    // Replace the URL Scheme with the Chrome equivalent.
    NSString *chromeScheme = nil;
    if ([scheme isEqualToString:@"http"]) {
        chromeScheme = @"googlechrome";
    } else if ([scheme isEqualToString:@"https"]) {
        chromeScheme = @"googlechromes";
    }
    
    // Proceed only if a valid Google Chrome URI Scheme is available.
    if (chromeScheme) {
        NSString *absoluteString = [inputURL absoluteString];
        NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
        NSString *urlNoScheme = [absoluteString substringFromIndex:rangeForScheme.location];
        NSString *chromeURLString =[chromeScheme stringByAppendingString:urlNoScheme];
        NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
        
        // Open the URL with Chrome.
        [[UIApplication sharedApplication] openURL:chromeURL];
    }
}

-(void) openOperaMiniURLFromString:(NSString *) string {
    [[ShareOpen getInstance] openOperaMiniURLFromString:string];
}


-(void) openSearchChromeFromString:(NSString *) string {
    NSString *searchString = string;
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *googleString = [NSString stringWithFormat:@"http://www.google.es/search?q=%@&aq=0&oq=%@&sourceid=chrome-mobile&ie=UTF-8", searchString, searchString];
    
    [self openChromeURLFromString:googleString];
}


-(void) openPhoneNumberFromString:(NSString *) string {
    NSString *phone_number = string;
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",phone_number];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

-(void) openMessage {
    NSString *stringURL = @"sms:";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

-(BOOL) existChrome {
    NSURL *simpleURL = [NSURL URLWithString:@"googlechrome:"];
    return  [[UIApplication sharedApplication] canOpenURL:simpleURL];
}


@end
