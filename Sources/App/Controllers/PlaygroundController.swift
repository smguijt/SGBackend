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
    func updateSetting(_ req: Request) throws -> HTTPStatus {
        req.logger.info("calling playground.systemsettings POST")
        
        print(req.body)
        
        return HTTPStatus.accepted
    }
   
}
