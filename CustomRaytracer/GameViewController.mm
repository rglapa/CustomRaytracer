//
//  GameViewController.m
//  CustomRaytracer
//
//  Created by Ruben Glapa on 3/17/25.
//

#import "GameViewController.h"
#import "Renderer.h"

@implementation GameViewController
{
    MTKView *_view;

    Renderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView *)self.view;

    _view.device = MTLCreateSystemDefaultDevice();

    NSArray<id<MTLDevice>> *devices = MTLCopyAllDevices();
    
    id<MTLDevice> selectedDevice;
    
    for(id<MTLDevice> device in devices)
    {
        if (device.supportsRaytracing)
        {
            if(!selectedDevice || !device.isLowPower)
            {
                selectedDevice = device;
            }
        }
    }
    _view.device = selectedDevice;
    
    NSLog(@"Selected Device: %@", _view.device.name);
    
    // Device must support Metal and ray tracing.
    NSAssert(_view.device && _view.device.supportsRaytracing,
             @"Ray tracing isn't supported on this device.");
    
    _view.colorPixelFormat = MTLPixelFormatRGBA16Float;
    
    Scene *scene = [Scene newInstancedCornellBoxSceneWithDevice:_view.device
    useIntersectionFunctions:YES];
    
    _renderer = [[Renderer alloc] initWithDevice:_view.device scene:scene];
    
    [_renderer mtkView:_view drawableSizeWillChange:_view.bounds.size];
    
    _view.delegate = _renderer;
}

@end
