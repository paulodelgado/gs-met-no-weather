/*
Project: GSMetNoWeather

Copyright (C) 2023 Free Software Foundation

Author: Paulo Delgado

Created: 2023-10-05 by Paulo Delgado

This application is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This application is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU General Public
License along with this library; if not, write to the Free
Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "GSMetNoWeather.h"

@implementation GSMetNoWeather

static NSString *const MET_NO_BASE_URL = @"https://api.met.no/weatherapi/";
static NSString *const COMPACT = @"compact";
static NSString *const COMPLETE = @"complete";

- (NSString *) locationForecastURL:(NSString *)requestType
                          latitude:(double) latitude
                         longitude:(double) longitude {
  return [[NSString stringWithFormat:@"%@locationforecast/2.0/%@?lat=%f&lon=%f",
         MET_NO_BASE_URL,
         requestType,
         latitude,
         longitude
  ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (void)fetchWeatherDataForLatitude:(double)latitude
                          longitude:(double)longitude
                            compact:(BOOL)compact
                  completionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {

  NSString *requestEndpoint = compact ? COMPACT : COMPLETE;
  NSString *urlString = [self locationForecastURL:requestEndpoint latitude:latitude longitude:longitude];

  NSURL *url = [NSURL URLWithString:urlString];
  NSLog(@"URL to use: %@", url);

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      completionHandler(nil, error);
      return;
    }

    NSError *jsonError;
    NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (jsonError) {
      completionHandler(nil, jsonError);
    } else {
      completionHandler(weatherData, nil);
    }
  }];

  [task resume];
}

@end
