import Fluent
import Vapor
import Leaf

struct PlaygroundController: RouteCollection {
    
    /* ROUTES */
    
    func boot(routes: RoutesBuilder) throws {
        let pg = routes.grouped("playground")
        
        pg.get(use: self.index)
        pg.get("item1", use: self.renderItem1)
        pg.get("item1detail",":id", use: self.renderItem1Detail)
        pg.post("item1detail",":id", use: self.processItem1Detail)
        pg.post("item1detailaction", ":id", use: self.processItem1DetailAction)
        
        pg.get("systemsettings", use: self.renderSystemSettings)
        pg.post("systemsettings", use: self.updateSystemSetting)

        pg.get("usersettings", use: self.renderUserSettings)
        pg.post("usersettings", use: self.updateUserSetting)
        
    }
    
    
    
    
    /* VIEWS */
    
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
            ListContentDTO(id: "123456789", title: "202406", description: "Tableau Content Data Visualization Online Training", link: "/playground/item1detail/123456789", active: true, subText: "By Elnathan Lois", lastUpdated: Date()),
            ListContentDTO(id: "987654321", title: "202306", description: "Tableau Data Visualization Online Training", link: "/playground/item1detail/987654321", active: false, subText: "By Elnathan Lois", lastUpdated: Date())
        ]

        return try await req.view.render("playgroundItem1",
                                         ItemContext(title: "Playground",
                                         settings: mySettingsDTO,
                                         items: myItems))
    }
    
    @Sendable
    func renderItem1Detail(req: Request) async throws -> View {
        req.logger.info("calling playground.item1Detail")
        let mySettingsDTO = try await getSettings(req: req)
        
        let myId = req.parameters.get("id") ?? ""
        req.logger.info("calling playground.item1Detail.id: \(myId)")
        
        return try await req.view.render("playgroundItem1Detail",
                                         BaseContext(title: "Playground", paramId: myId,
                                         settings: mySettingsDTO))
    }
    
    
    
    
    /* ACTIONS */
    
    @Sendable
    func processItem1Detail(_ req: Request) async throws -> Response {
        req.logger.info("calling playground.processItem1Detail POST")
        req.logger.info("incomming request: \(req.body)")
        
        let myId = req.parameters.get("id") ?? ""
        req.logger.info("calling playground.item1Detail.id POST: \(myId)")
        
        let formContent = try req.content.decode(PlaygroundDetailItemForm.self)
        req.logger.info("Decoded request: \(formContent)")
        

        var status: Bool = false
        var errorMessage: String = ""
        // for debugging validate
        if formContent.text_1?.lowercased() == "ok" {
            status = true
        } else {
            errorMessage = "Not Implemented Yet"
        }
            
            
        if status {
            req.logger.info("calling playground.item1Detail OK. Redirect POST:")
            return req.redirect(to: "/playground/item1detail/\(formContent.paramId ?? "")")
        } else {
            let mySettingsDTO = try await getSettings(req: req)
            return try await req.view
                .render("playgroundItem1Detail",
                         BaseContext(title: "Playground", paramId: formContent.paramId ?? "",
                         errorMessage: errorMessage,
                         settings: mySettingsDTO))
                .encodeResponse(status: .ok, for: req)
        }
        
        
    }
    
    @Sendable
    func processItem1DetailAction(_ req: Request) async throws -> Response {
        req.logger.info("calling playground.processItem1DetailAction POST")
        req.logger.info("incomming request: \(req.body)")
        
        let body = try req.content.decode(DictDTO.self)
        if body.key == "Cancelled" {
            req.logger.info("executing playground.processItem1DetailAction.Cancelled")
            let ret: Response = Response()
            ret.status = HTTPResponseStatus.accepted
            return ret
        } else {
            /* do nothing */
            let ret: Response = Response()
            ret.status = HTTPResponseStatus.accepted
            return ret
        }
    }
    
    @Sendable
    func addItem(_ req: Request) async throws -> Response {
        
        req.logger.info("calling playground.addItem POST")
        req.logger.info("incomming request: \(req.body)")
        
        let ret: Response = Response()
        ret.status = HTTPResponseStatus.notImplemented
        return ret
    }
    
    @Sendable
    func deleteItem(_ req: Request) async throws -> Response {
        
        req.logger.info("calling playground.deleteItem POST")
        req.logger.info("incomming request: \(req.body)")
        
        let ret: Response = Response()
        ret.status = HTTPResponseStatus.notImplemented
        return ret
    }
    
    @Sendable
    func updateItem(_ req: Request) async throws -> Response {
        
        req.logger.info("calling playground.updateItem POST")
        req.logger.info("incomming request: \(req.body)")
        
        let ret: Response = Response()
        ret.status = HTTPResponseStatus.notImplemented
        return ret
    }
    
    
    
    
    
    /* SETTINGS */
    
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
