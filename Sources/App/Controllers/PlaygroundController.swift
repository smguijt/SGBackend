import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
        pg.get("item1", use: self.renderItem1)
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        req.logger.info("calling playground.index")
        return try await req.view.render("playgroundIndex")
    }
    
    @Sendable
    func renderItem1(req: Request) async throws -> View {
        req.logger.info("calling playground.item1")
        return try await req.view.render("playgroundItem1")
    }
}
