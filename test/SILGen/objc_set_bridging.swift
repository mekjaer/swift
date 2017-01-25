// RUN: rm -rf %t && mkdir -p %t
// RUN: %build-silgen-test-overlays

// RUN: %target-swift-frontend(mock-sdk: -sdk %S/Inputs -I %t) -Xllvm -new-mangling-for-tests -emit-silgen %s | %FileCheck %s

// REQUIRES: objc_interop

import Foundation
import gizmo

@objc class Foo : NSObject {
  // Bridging set parameters
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC16bridge_Set_param{{[_0-9a-zA-Z]*}}FTo : $@convention(objc_method) (NSSet, Foo) -> ()
  func bridge_Set_param(_ s: Set<Foo>) {
    // CHECK: bb0([[NSSET:%[0-9]+]] : $NSSet, [[SELF:%[0-9]+]] : $Foo):
    // CHECK:   [[NSSET_COPY:%.*]] = copy_value [[NSSET]] : $NSSet
    // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]] : $Foo
    // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s3SetV10FoundationE36_unconditionallyBridgeFromObjectiveCAByxGSo5NSSetCSgFZ
    // CHECK:   [[OPT_NSSET:%[0-9]+]] = enum $Optional<NSSet>, #Optional.some!enumelt.1, [[NSSET_COPY]] : $NSSet
    // CHECK:   [[SET_META:%[0-9]+]] = metatype $@thin Set<Foo>.Type
    // CHECK:   [[SET:%[0-9]+]] = apply [[CONVERTER]]<Foo>([[OPT_NSSET]], [[SET_META]])
    // CHECK:   [[SWIFT_FN:%[0-9]+]] = function_ref @_T017objc_set_bridging3FooC16bridge_Set_param{{[_0-9a-zA-Z]*}}F : $@convention(method) (@owned Set<Foo>, @guaranteed Foo) -> ()
    // CHECK:   [[RESULT:%[0-9]+]] = apply [[SWIFT_FN]]([[SET]], [[SELF_COPY]]) : $@convention(method) (@owned Set<Foo>, @guaranteed Foo) -> ()
    // CHECK:   destroy_value [[SELF_COPY]]
    // CHECK:   return [[RESULT]] : $()
  }
  // CHECK: // end sil function '_T017objc_set_bridging3FooC16bridge_Set_param{{[_0-9a-zA-Z]*}}FTo'

  // Bridging set results
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC17bridge_Set_result{{[_0-9a-zA-Z]*}}FTo : $@convention(objc_method) (Foo) -> @autoreleased NSSet {
  func bridge_Set_result() -> Set<Foo> { 
    // CHECK: bb0([[SELF:%[0-9]+]] : $Foo):
    // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]] : $Foo
    // CHECK:   [[SWIFT_FN:%[0-9]+]] = function_ref @_T017objc_set_bridging3FooC17bridge_Set_result{{[_0-9a-zA-Z]*}}F : $@convention(method) (@guaranteed Foo) -> @owned Set<Foo>
    // CHECK:   [[SET:%[0-9]+]] = apply [[SWIFT_FN]]([[SELF_COPY]]) : $@convention(method) (@guaranteed Foo) -> @owned Set<Foo>
    // CHECK:   destroy_value [[SELF_COPY]]
    // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s3SetV10FoundationE19_bridgeToObjectiveCSo5NSSetCyF
    // CHECK:   [[NSSET:%[0-9]+]] = apply [[CONVERTER]]<Foo>([[SET]]) : $@convention(method) <τ_0_0 where τ_0_0 : Hashable> (@guaranteed Set<τ_0_0>) -> @owned NSSet
    // CHECK:   destroy_value [[SET]]
    // CHECK:   return [[NSSET]] : $NSSet
  }
  // CHECK: } // end sil function '_T017objc_set_bridging3FooC17bridge_Set_result{{[_0-9a-zA-Z]*}}FTo'

  var property: Set<Foo> = Set()

  // Property getter
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC8property{{[_0-9a-zA-Z]*}}fgTo : $@convention(objc_method) (Foo) -> @autoreleased NSSet
  // CHECK: bb0([[SELF:%[0-9]+]] : $Foo):
  // CHECK:   [[SELF_COPY]] = copy_value [[SELF]] : $Foo
  // CHECK:   [[GETTER:%[0-9]+]] = function_ref @_T017objc_set_bridging3FooC8property{{[_0-9a-zA-Z]*}}fg : $@convention(method) (@guaranteed Foo) -> @owned Set<Foo>
  // CHECK:   [[SET:%[0-9]+]] = apply [[GETTER]]([[SELF_COPY]]) : $@convention(method) (@guaranteed Foo) -> @owned Set<Foo>
  // CHECK:   destroy_value [[SELF_COPY]]
  // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s3SetV10FoundationE19_bridgeToObjectiveCSo5NSSetCyF
  // CHECK:   [[NSSET:%[0-9]+]] = apply [[CONVERTER]]<Foo>([[SET]]) : $@convention(method) <τ_0_0 where τ_0_0 : Hashable> (@guaranteed Set<τ_0_0>) -> @owned NSSet
  // CHECK:   destroy_value [[SET]]
  // CHECK:   return [[NSSET]] : $NSSet
  // CHECK: } // end sil function '_T017objc_set_bridging3FooC8property{{[_0-9a-zA-Z]*}}fgTo'
  
  // Property setter
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC8property{{[_0-9a-zA-Z]*}}fsTo : $@convention(objc_method) (NSSet, Foo) -> () {
  // CHECK: bb0([[NSSET:%[0-9]+]] : $NSSet, [[SELF:%[0-9]+]] : $Foo):
  // CHECK:   [[NSSET_COPY:%.*]] = copy_value [[NSSET]] : $NSSet
  // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]] : $Foo
  // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s3SetV10FoundationE36_unconditionallyBridgeFromObjectiveCAByxGSo5NSSetCSgFZ
  // CHECK:   [[OPT_NSSET:%[0-9]+]] = enum $Optional<NSSet>, #Optional.some!enumelt.1, [[NSSET_COPY]] : $NSSet
  // CHECK:   [[SET_META:%[0-9]+]] = metatype $@thin Set<Foo>.Type
  // CHECK:   [[SET:%[0-9]+]] = apply [[CONVERTER]]<Foo>([[OPT_NSSET]], [[SET_META]])
  // CHECK:   [[SETTER:%[0-9]+]] = function_ref @_T017objc_set_bridging3FooC8property{{[_0-9a-zA-Z]*}}fs : $@convention(method) (@owned Set<Foo>, @guaranteed Foo) -> ()
  // CHECK:   [[RESULT:%[0-9]+]] = apply [[SETTER]]([[SET]], [[SELF_COPY]]) : $@convention(method) (@owned Set<Foo>, @guaranteed Foo) -> ()
  // CHECK:   destroy_value [[SELF_COPY]] : $Foo
  // CHECK:   return [[RESULT]] : $()
  
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC19nonVerbatimProperty{{[_0-9a-zA-Z]*}}fgTo : $@convention(objc_method) (Foo) -> @autoreleased NSSet
  // CHECK-LABEL: sil hidden [thunk] @_T017objc_set_bridging3FooC19nonVerbatimProperty{{[_0-9a-zA-Z]*}}fsTo : $@convention(objc_method) (NSSet, Foo) -> () {
  @objc var nonVerbatimProperty: Set<String> = Set()
}

func ==(x: Foo, y: Foo) -> Bool { }
