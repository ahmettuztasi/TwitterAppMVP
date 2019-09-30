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
+init(iXPresenter: IXPresenter)
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
-getX(List)(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?)
-changeXInfo(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?)
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

