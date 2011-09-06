//
//  InteractivityViewController.m
//  MBTiles Interactivity Example
//
//  Created by Justin Miller on 8/23/11.
//  Copyright 2011 Development Seed. All rights reserved.
//

#import "InteractivityViewController.h"

#import "RMMapView.h"
#import "RMMBTilesTileSource.h"
#import "RMInteractiveSource.h"

#import <QuartzCore/QuartzCore.h>

@implementation InteractivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    RMMapView *mapView = [[[RMMapView alloc] initWithFrame:self.view.bounds] autorelease];
    
    mapView.delegate = self;
    
    [self.view addSubview:mapView];

    NSURL *tileSetURL = [[NSBundle mainBundle] URLForResource:@"geography-class" withExtension:@"mbtiles"];
    
    RMMBTilesTileSource *source = [[[RMMBTilesTileSource alloc] initWithTileSetURL:tileSetURL] autorelease];

    mapView.contents.mapCenter  = CLLocationCoordinate2DMake(40.0, 0.0);
    mapView.contents.zoom       = 2.5;
    mapView.contents.minZoom    = mapView.contents.zoom;
    mapView.contents.maxZoom    = source.maxZoom;
    mapView.contents.tileSource = source;
}

#pragma mark -

- (void)singleTapOnMap:(RMMapView *)mapView At:(CGPoint)point
{
    id source = mapView.contents.tileSource;
    
    if ([source conformsToProtocol:@protocol(RMInteractiveSource)] && [(id <RMInteractiveSource>)source supportsInteractivity])
    {
        source = (id <RMInteractiveSource>)source;
        
        NSString *formattedOutput = [source formattedOutputOfType:RMInteractiveSourceOutputTypeFull 
                                                         forPoint:point 
                                                        inMapView:mapView];
        
        if ( ! formattedOutput || ! [formattedOutput length])
            formattedOutput = [source formattedOutputOfType:RMInteractiveSourceOutputTypeTeaser 
                                                   forPoint:point 
                                                  inMapView:mapView];
        
        if (formattedOutput && [formattedOutput length])
        {
            CGRect frame = CGRectMake(mapView.frame.size.width - 200, mapView.frame.size.height - 140, 200, 140);
            
            UIWebView *webView = [[[UIWebView alloc] initWithFrame:frame] autorelease];

            [webView loadHTMLString:formattedOutput baseURL:nil];
            
            webView.layer.borderColor = [[UIColor blackColor] CGColor];
            webView.layer.borderWidth = 2.0;

            webView.userInteractionEnabled = NO;
            
            [self.view addSubview:webView];
            
            [UIView animateWithDuration:1.0
                                  delay:0.5
                                options:UIViewAnimationCurveEaseOut
                             animations:^(void)
                             {
                                 webView.alpha = 0.0;
                             }
                             completion:^(BOOL finished)
                             {
                                 [webView removeFromSuperview];
                             }];
        }
    }
}

@end