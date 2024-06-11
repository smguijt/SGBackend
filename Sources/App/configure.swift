import NIOSSL
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) async throws {
    // serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ErrorMiddleware { req, error -> Response in
        //.init(status: .internalServerError, version: req.version, headers: .init(), body: .empty)
        .init(status: .notFound, version: req.version, headers: .init(), body: "not found")
    })
    
   
    
    
    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateTodo())

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
