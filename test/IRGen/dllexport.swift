// RUN: %swift -Xllvm -new-mangling-for-tests -target thumbv7--windows-itanium -emit-ir -parse-as-library -parse-stdlib -module-name dllexport %s -o - | %FileCheck %s -check-prefix CHECK -check-prefix CHECK-NO-OPT
// RUN: %swift -Xllvm -new-mangling-for-tests -target thumbv7--windows-itanium -O -emit-ir -parse-as-library -parse-stdlib -module-name dllexport %s -o - | %FileCheck %s -check-prefix CHECK -check-prefix CHECK-OPT

// REQUIRES: CODEGENERATOR=ARM

enum Never {}

@_silgen_name("_swift_fatalError")
func fatalError() -> Never

public protocol p {
  func f()
}

open class c {
  public init() { }
}

public var ci : c = c()

open class d {
  private func m() -> Never {
    fatalError()
  }
}

// CHECK-DAG: @_T09dllexport2ciAA1cCv = dllexport global %C9dllexport1c* null, align 4
// CHECK-DAG: @_T09dllexport1pMp = dllexport constant %swift.protocol
// CHECK-DAG: @_T09dllexport1cCMn = dllexport constant
// CHECK-DAG: @_T09dllexport1cCML = dllexport global %swift.type* null, align 4
// CHECK-DAG: @_T09dllexport1dCML = dllexport global %swift.type* null, align 4
// CHECK-DAG: @_T09dllexport1cCN = dllexport alias %swift.type
// CHECK-DAG: @_T09dllexport1dCN = dllexport alias %swift.type, bitcast ({{.*}})
// CHECK-DAG-OPT: @_T09dllexport1dC1m33_C57BA610BA35E21738CC992438E660E9LLyyF = dllexport alias void (), void ()* @_swift_dead_method_stub
// CHECK-DAG-OPT: @_T09dllexport1dCACycfc = dllexport alias void (), void ()* @_swift_dead_method_stub
// CHECK-DAG-OPT: @_T09dllexport1cCACycfc = dllexport alias void (), void ()* @_swift_dead_method_stub
// CHECK-DAG-OPT: @_T09dllexport1cCACycfC = dllexport alias void (), void ()* @_swift_dead_method_stub
// CHECK-DAG: define dllexport %swift.refcounted* @_T09dllexport1cCfd(%C9dllexport1c*{{.*}})
// CHECK-DAG-NO-OPT: define dllexport %C9dllexport1c* @_T09dllexport1cCACycfc(%C9dllexport1c*)
// CHECK-DAG-NO-OPT: define dllexport %C9dllexport1c* @_T09dllexport1cCACycfC(%swift.type*)
// CHECK-DAG: define dllexport i8* @_T09dllexport2ciAA1cCfau()
// CHECK-DAG-NO-OPT: define dllexport void @_T09dllexport1dC1m33_C57BA610BA35E21738CC992438E660E9LLyyF(%C9dllexport1d*)
// CHECK-DAG-NO-OPT: define dllexport void @_T09dllexport1dCfD(%C9dllexport1d*)
// CHECK-DAG: define dllexport %swift.refcounted* @_T09dllexport1dCfd(%C9dllexport1d*{{.*}})
// CHECK-DAG: define dllexport %swift.type* @_T09dllexport1cCMa()
// CHECK-DAG: define dllexport %swift.type* @_T09dllexport1dCMa()
// CHECK-DAG-NO-OPT: define dllexport %C9dllexport1d* @_T09dllexport1dCACycfc(%C9dllexport1d*)
// CHECK-DAG-OPT: define dllexport void @_T09dllexport1dCfD(%C9dllexport1d*)

