import Fluent
import Vapor

func routes(_ app: Application) throws  {
        
    app.get { req async throws in
        try await req.view.render("landingpage")
    }
    
        
    try app.register(collection: PlaygroundController())
    try app.register(collection: TodoController())
}
