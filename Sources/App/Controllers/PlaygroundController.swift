import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
        pg.get("item1", use: self.renderItem1)
        pg.get("systemsettings", use: self.renderSystemSettings)
        pg.post("systemsettings", use: self.updateSetting)
        
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        req.logger.info("calling playground.index")
        let mySettingsDTO = try await getSettings(db: req.db)
        return try await req.view.render("playgroundIndex", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func renderItem1(req: Request) async throws -> View {
        req.logger.info("calling playground.item1")
        return try await req.view.render("playgroundItem1")
    }
    
    @Sendable
    func renderSystemSettings(req: Request) async throws -> View {
        req.logger.info("calling playground.systemsettings")
        let mySettingsDTO = try await getSettings(db: req.db)
        return try await req.view.render("playgroundSystemSettings", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func updateSetting(_ req: Request) async throws -> Response {
        req.logger.info("calling playground.systemsettings POST")
        req.logger.info("incomming request: \(req.body)")
        
        let body = try req.content.decode(DictDTO.self)
        guard let record = try await Setting.query(on: req.db).filter(\.$key == body.key!).first() else {
            req.logger.error("\(body.key!) has not been updated with value: \(body.value!)")
            let ret: Response = Response()
            ret.status = HTTPResponseStatus.notModified
            ret.body = Response.Body(string: "\(body.key!) has not been updated with value: \(body.value!)")
            return ret
        }
        record.value = body.value ?? ""
        _ = try await record.save(on: req.db)
        
        let ret: Response = Response()
        ret.status = HTTPResponseStatus.accepted
        ret.body = Response.Body(string: "\(body.key!) has been updated with value: \(body.value!)")
        req.logger.info("\(body.key!) has been updated with value: \(body.value!)")
        return ret
    }
   
}
