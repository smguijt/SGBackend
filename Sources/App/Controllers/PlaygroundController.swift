import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        req.logger.info("calling playground.index")
        return try await req.view.render("playground/index")
    }
}
