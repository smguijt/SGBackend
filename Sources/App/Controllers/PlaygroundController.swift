import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
        pg.get("item1", use: self.renderItem1)
        
        pg.get("systemsettings", use: self.renderSystemSettings)
        pg.post("systemsettings", use: self.updateSystemSetting)

        pg.get("usersettings", use: self.renderUserSettings)
        pg.post("usersettings", use: self.updateUserSetting)
        
    }
    
    @Sendable
    func index(req: Request) async throws -> View {
        
        /* for debugging purpose only. Add dummy user session. Id created via seeding */
        req.session.data["sgsoftware_systemuser"] = "ea21f445-ddd4-40ed-86dd-a629f771c5f4"
        req.logger.info("SESSION: sgsoftware_systemuser set with value: \(req.session.data["sgsoftware_systemuser"] ?? "")")
        req.logger.info("calling playground.index")

        let mySettingsDTO = try await getSettings(req: req)
        return try await req.view.render("playgroundIndex", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func renderItem1(req: Request) async throws -> View {
        
        req.logger.info("calling playground.item1")
        
        let mySettingsDTO = try await getSettings(req: req)
        //mySettingsDTO.ShowUserBox = false
        
        let myItems = [ 
            ListContentDTO(id: "123456789", title: "202406", description: "Tableau Content Data Visualization Online Training", active: true, subText: "By Elnathan Lois", lastUpdated: Date()),
            ListContentDTO(id: "987654321", title: "202306", description: "Tableau Data Visualization Online Training", active: false, subText: "By Elnathan Lois", lastUpdated: Date())
        ]

        return try await req.view.render("playgroundItem1",
                                         ItemContext(title: "Playground",
                                         settings: mySettingsDTO,
                                         items: myItems))
    }
    
    @Sendable
    func renderSystemSettings(req: Request) async throws -> View {
        req.logger.info("calling playground.systemsettings")
        let mySettingsDTO = try await getSettings(req: req)
        return try await req.view.render("playgroundSystemSettings", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func updateSystemSetting(_ req: Request) async throws -> Response {
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

    @Sendable
    func renderUserSettings(req: Request) async throws -> View {

        req.logger.info("calling playground.usersettings")
        
        var userIdString = try? req.query.get(String.self, at: "userid")
        if (userIdString == nil) {
            userIdString = req.session.data["sgsoftware_systemuser"] ?? ""
            req.logger.info("session sgsoftware_systemuser found: \(userIdString ?? "")")
        }
        let userId = UUID(uuidString: userIdString ?? "") ?? UUID()

        let mySettingsDTO = try await getUserSettings(req: req, userId: userId)
        req.logger.info("userSettings retrieved: \(mySettingsDTO)")
        return try await req.view.render("playgroundUserSettings", BaseContext(title: "Playground", settings: mySettingsDTO))
    }
    
    @Sendable
    func updateUserSetting(_ req: Request) async throws -> Response {

        req.logger.info("calling playground.usersettings POST")
        req.logger.info("incomming request: \(req.body)")

        var userIdString = try? req.query.get(String.self, at: "userid")
        var userId = UUID()

        if (userIdString == nil) {
            userIdString = req.session.data["sgsoftware_systemuser"] 
            req.logger.info("session sgsoftware_systemuser found: \(userIdString ?? "no value")")
        }
        if userIdString != nil {
            userId = UUID(uuidString: userIdString ?? "") ?? UUID()
        } 
        
        let body = try req.content.decode(DictDTO.self)
        guard let record: UserSettings = try await UserSettings
            .query(on: req.db)
            .filter(\.$key == body.key!)
            .filter(\.$userId == userId)
            .first() 
        else {
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
