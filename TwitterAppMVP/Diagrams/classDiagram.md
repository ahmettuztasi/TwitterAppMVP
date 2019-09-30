@startuml

class XModel {
-id: Int
-name: String
}

class XView {
-xPresenter:  XPresenter?
+onXResolved(modelList: [Model])
+onError(msg: Bool)
}

class XPresenter {
-iXPresenter : IXPresenter?
-xService: XService?

+onXResponse(response: Data)
+onChangeXResponse(response: Data)
+onXError(message: Bool)
+init(iXPresenter: ßIXPresenter)
}

interface IXPresenter {
+onXResolved(modelList: [Model])
+onError(msg: Bool)
}

interface IXService {
+onXResponse(response: Data)
+onChangeXResponse(response: Data)
+onXError(message: Bool)
}

class XService {
-iService: IService?
+init(iService: IService)
-connect(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?)
}

interface IService {
}

XPresenter --|> IXService

XView --|> IXPresenter

XModel --* XPresenter

XView --> XPresenter
XPresenter ..> XView

XService ..> XPresenter
XService <-- XPresenter

XPresenter --|> IService
IXService --|> IService

note "X: User, Tweet" as N1
@enduml

