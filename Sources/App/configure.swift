import NIOSSL
import LeafErrorMiddleware
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf
//import Sessions


// configures your application
public func configure(_ app: Application) async throws {
    // serve files from /Public folder
    app.logger.info("Enable middleware:FileMiddleware")
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // setup usage of sessions
    //app.sessions.configuration.cookieName = "SGSoftware"

    // Configures cookie value creation.
    //app.sessions.configuration.cookieFactory = { sessionID in
    //    .init(string: sessionID.string, isSecure: true)
    //}


   
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

    app.logger.info("Set session usasage to .sqlite")
    app.sessions.use(.fluent)
    app.sessions.use(.fluent(.sqlite))
    app.middleware.use(app.sessions.middleware)
    

    // add session tables to database
    app.logger.info("create database table: sessions")
    app.migrations.add(SessionRecord.migration)
    
    // create database tables
    app.logger.info("create database table: todos")
    app.migrations.add(DataMigration.v1.CreateTodo())
    app.migrations.add(DataMigration.v1.SeedToDo())
    app.logger.info("create database table: settings")
    app.migrations.add(DataMigration.v1.CreateSettings())
    app.migrations.add(DataMigration.v1.SeedSettings())
    app.migrations.add(DataMigration.v1.CreateUserSettings())
    app.migrations.add(DataMigration.v1.SeedUserSettings())
    app.logger.info("create database table: CostCenter, CostCenterCompanies, CostCenterTranslation")
    app.migrations.add(DataMigration.v1.CreateCostCenters())
    app.migrations.add(DataMigration.v1.SeedCostCenters())
    
    /* auto migrate */
    app.logger.info("automigration executed")
    try await app.autoMigrate()
    
    // serve views
    app.logger.info("Enable view engine .leaf")
    app.logger.info("template dir: \(app.leaf.configuration.rootDirectory)")
    app.views.use(.leaf)
    app.leaf.tags["now"] = NowTag()

    // register routes
    app.logger.info("register routing table")
    try routes(app)
}


