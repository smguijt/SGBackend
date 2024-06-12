import NIOSSL
import LeafErrorMiddleware
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) async throws {
    // serve files from /Public folder
    app.logger.info("Enable middleware:FileMiddleware")
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // serve error pages
    app.logger.info("Enable middleware:LeafErrorMiddleware")
    let mappings: [HTTPStatus: String] = [
        .notFound: "404",
        .unauthorized: "401",
        .forbidden: "403",
        .internalServerError: "serverError"
    ]
    app.middleware.use(LeafErrorMiddlewareDefaultGenerator.build(errorMappings: mappings))
    
    // serve database
    app.logger.info("Set database to sqlite .memory")
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    // create database tables
    app.logger.info("create database table: todos")
    app.migrations.add(CreateTodo())
    
    /* auto migrate */
    app.logger.info("automigration executed")
    try await app.autoMigrate()
    
    // serve views
    app.logger.info("Enable view engine .leaf")
    app.views.use(.leaf)

    // register routes
    app.logger.info("register routing table")
    try routes(app)
}
