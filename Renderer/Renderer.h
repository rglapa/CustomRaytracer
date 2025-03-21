//
//  Renderer.h
//  CustomRaytracer
//
//  Created by Ruben Glapa on 3/17/25.
//

#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "Scene.h"
// Our platform independent renderer class.   Implements the MTKViewDelegate protocol which
//   allows it to accept per-frame update and drawable resize callbacks.
@interface Renderer : NSObject <MTKViewDelegate>

- (instancetype)initWithDevice:(id<MTLDevice>)device scene:(Scene *)scene;

@end

