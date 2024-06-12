import NIOSSL
import LeafErrorMiddleware
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) async throws {
    // serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // serve error pages
    let mappings: [HTTPStatus: String] = [
        .notFound: "404",
        .unauthorized: "401",
        .forbidden: "403",
        .internalServerError: "serverError"
    ]
    app.middleware.use(LeafErrorMiddlewareDefaultGenerator.build(errorMappings: mappings))
    
    // serve database
    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)
    app.migrations.add(CreateTodo())
    
    // serve views
    app.views.use(.leaf)

    // register routes
    try routes(app)
}
