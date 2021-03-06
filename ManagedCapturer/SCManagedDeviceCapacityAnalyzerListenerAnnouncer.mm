// Generated by the announcer.rb  DO NOT EDIT!!

#import "SCManagedDeviceCapacityAnalyzerListenerAnnouncer.h"

#include <mutex>
using std::lock_guard;
using std::mutex;
#include <vector>
using std::find;
using std::make_shared;
using std::shared_ptr;
using std::vector;

@implementation SCManagedDeviceCapacityAnalyzerListenerAnnouncer {
    mutex _mutex;
    shared_ptr<vector<__weak id<SCManagedDeviceCapacityAnalyzerListener>>> _listeners;
}

- (NSString *)description
{
    auto listeners = atomic_load(&self->_listeners);
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"<SCManagedDeviceCapacityAnalyzerListenerAnnouncer %p>: [", self];
    for (int i = 0; i < listeners->size(); ++i) {
        [desc appendFormat:@"%@", (*listeners)[i]];
        if (i != listeners->size() - 1) {
            [desc appendString:@", "];
        }
    }
    [desc appendString:@"]"];
    return desc;
}

- (void)addListener:(id<SCManagedDeviceCapacityAnalyzerListener>)listener
{
    lock_guard<mutex> lock(_mutex);
    auto listeners = make_shared<vector<__weak id<SCManagedDeviceCapacityAnalyzerListener>>>();
    if (_listeners != nil) {
        // The listener we want to add already exists
        if (find(_listeners->begin(), _listeners->end(), listener) != _listeners->end()) {
            return;
        }
        for (auto &one : *_listeners) {
            if (one != nil) {
                listeners->push_back(one);
            }
        }
        listeners->push_back(listener);
        atomic_store(&self->_listeners, listeners);
    } else {
        listeners->push_back(listener);
        atomic_store(&self->_listeners, listeners);
    }
}

- (void)removeListener:(id<SCManagedDeviceCapacityAnalyzerListener>)listener
{
    lock_guard<mutex> lock(_mutex);
    if (_listeners == nil) {
        return;
    }
    // If the only item in the listener list is the one we want to remove, store it back to nil again
    if (_listeners->size() == 1 && (*_listeners)[0] == listener) {
        atomic_store(&self->_listeners, shared_ptr<vector<__weak id<SCManagedDeviceCapacityAnalyzerListener>>>());
        return;
    }
    auto listeners = make_shared<vector<__weak id<SCManagedDeviceCapacityAnalyzerListener>>>();
    for (auto &one : *_listeners) {
        if (one != nil && one != listener) {
            listeners->push_back(one);
        }
    }
    atomic_store(&self->_listeners, listeners);
}

- (void)managedDeviceCapacityAnalyzer:(SCManagedDeviceCapacityAnalyzer *)managedDeviceCapacityAnalyzer
           didChangeLowLightCondition:(BOOL)lowLightCondition
{
    auto listeners = atomic_load(&self->_listeners);
    if (listeners) {
        for (id<SCManagedDeviceCapacityAnalyzerListener> listener : *listeners) {
            if ([listener respondsToSelector:@selector(managedDeviceCapacityAnalyzer:didChangeLowLightCondition:)]) {
                [listener managedDeviceCapacityAnalyzer:managedDeviceCapacityAnalyzer
                             didChangeLowLightCondition:lowLightCondition];
            }
        }
    }
}

- (void)managedDeviceCapacityAnalyzer:(SCManagedDeviceCapacityAnalyzer *)managedDeviceCapacityAnalyzer
           didChangeAdjustingExposure:(BOOL)adjustingExposure
{
    auto listeners = atomic_load(&self->_listeners);
    if (listeners) {
        for (id<SCManagedDeviceCapacityAnalyzerListener> listener : *listeners) {
            if ([listener respondsToSelector:@selector(managedDeviceCapacityAnalyzer:didChangeAdjustingExposure:)]) {
                [listener managedDeviceCapacityAnalyzer:managedDeviceCapacityAnalyzer
                             didChangeAdjustingExposure:adjustingExposure];
            }
        }
    }
}

- (void)managedDeviceCapacityAnalyzer:(SCManagedDeviceCapacityAnalyzer *)managedDeviceCapacityAnalyzer
              didChangeAdjustingFocus:(BOOL)adjustingFocus
{
    auto listeners = atomic_load(&self->_listeners);
    if (listeners) {
        for (id<SCManagedDeviceCapacityAnalyzerListener> listener : *listeners) {
            if ([listener respondsToSelector:@selector(managedDeviceCapacityAnalyzer:didChangeAdjustingFocus:)]) {
                [listener managedDeviceCapacityAnalyzer:managedDeviceCapacityAnalyzer
                                didChangeAdjustingFocus:adjustingFocus];
            }
        }
    }
}

- (void)managedDeviceCapacityAnalyzer:(SCManagedDeviceCapacityAnalyzer *)managedDeviceCapacityAnalyzer
                  didChangeBrightness:(float)adjustingBrightness
{
    auto listeners = atomic_load(&self->_listeners);
    if (listeners) {
        for (id<SCManagedDeviceCapacityAnalyzerListener> listener : *listeners) {
            if ([listener respondsToSelector:@selector(managedDeviceCapacityAnalyzer:didChangeBrightness:)]) {
                [listener managedDeviceCapacityAnalyzer:managedDeviceCapacityAnalyzer
                                    didChangeBrightness:adjustingBrightness];
            }
        }
    }
}

- (void)managedDeviceCapacityAnalyzer:(SCManagedDeviceCapacityAnalyzer *)managedDeviceCapacityAnalyzer
           didChangeLightingCondition:(SCCapturerLightingConditionType)lightingCondition
{
    auto listeners = atomic_load(&self->_listeners);
    if (listeners) {
        for (id<SCManagedDeviceCapacityAnalyzerListener> listener : *listeners) {
            if ([listener respondsToSelector:@selector(managedDeviceCapacityAnalyzer:didChangeLightingCondition:)]) {
                [listener managedDeviceCapacityAnalyzer:managedDeviceCapacityAnalyzer
                             didChangeLightingCondition:lightingCondition];
            }
        }
    }
}

@end
