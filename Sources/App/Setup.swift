//
//  Setup.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import Fluent
import FluentPostgresDriver
import Foundation
import HTMLKitVapor
import Vapor
import Logging
import NIOCore
import NIOPosix

@main
enum Setup {
    
    static func main() async throws {
        
        var environment = try Environment.detect()
        
        try LoggingSystem.bootstrap(from: &environment)
        
        let application = try await Application.make(environment)
        
        let executorTakeoverSuccess = NIOSingletons.unsafeTryInstallSingletonPosixEventLoopGroupAsConcurrencyGlobalExecutor()
        
        application.logger.debug("Running with \(executorTakeoverSuccess ? "SwiftNIO" : "standard") Swift Concurrency default executor")
        
        application.passwords.use(.bcrypt)
        application.sessions.use(.fluent(.psql))
        
        do {
            
            try await middlwares(application)
            try await routes(application)
            try await tables(application)
            try await services(application)
            
        } catch {
            
            application.logger.report(error: error)
            
            try? await application.asyncShutdown()
            
            throw error
        }
        
        try await application.execute()
        try await application.asyncShutdown()
    }
    
    static func middlwares(_ application: Application) async throws {
        
        application.middleware = .init()
        application.middleware.use(RouteLoggingMiddleware(logLevel: .info))
        application.middleware.use(ErrorMiddleware())
        application.middleware.use(FileMiddleware(publicDirectory: application.directory.publicDirectory))
        application.middleware.use(application.sessions.middleware)
    }
    
    static func routes(_ application: Application) async throws {
        
        application.routes.defaultMaxBodySize = "10mb";
        
        try application.register(collection: IndexController())
        
        
        //        try application.register(collection: HomePageController())
        //        try application.register(collection: ArticlesPageController())
        //        try application.register(collection: ProjectsPageController())
        //        try application.register(collection: FeedPageController())
        //        try application.register(collection: PrivacyPageController())
        //        try application.register(collection: LegalPageController())
        
        try application.group("protected") { routes in
            
            try application.register(collection: AuthController())
            
            try routes.group("admin") { routes in
                
                let group = routes.grouped(UserSessionAuthenticator(), UserModel.Output.redirectMiddleware(path: "/protected/auth/login"))
                try group.register(collection: DashboardController())
//                try group.register(collection: DriverAdminController())
//                try group.register(collection: TripAdminController())
//                try group.register(collection: AssistenceAdminController())
//                try group.register(collection: PassangerAdminController())
//                try group.register(collection: AssistenceAdminController())
//                try group.register(collection: UserAdminController())
            }
        }
        
        application.commands.use(ListRoutesCommand(), as: "list-routes")
        
    }
    
    static func tables(_ application: Application) async throws {
        
        var tls = TLSConfiguration.makeClientConfiguration()
        tls.certificateVerification = .none
        
        // Database
        application.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? "vapor_database",
            tls: .prefer(try .init(configuration: .clientDefault)))
        ), as: .psql)
        
        //
        //
        application.migrations.add(AssetMigration())
        application.migrations.add(UserMigration())
        application.migrations.add(SessionRecord.migration)
        application.migrations.add(CredentialMigration())
        application.migrations.add(UserAdminMigration())
        
        //        application.migrations.add(ArticleMigration())
        //        application.migrations.add(ProjectMigration())
        //        application.migrations.add(CommentMigration())
        //        application.migrations.add(ArticleAssetMigration())
        //        application.migrations.add(ProjectAssetMigration())
        //        application.migrations.add(ContactMigration())
        //        application.migrations.add(ReportMigration())
        //        application.migrations.add(FeedMigration())
        
        try await application.autoMigrate()
    }
    
    static func services(_ application: Application) async throws {
        guard let localeSourcePath = URL(string: application.directory.publicDirectory.appending("Localization")) else {
            throw Abort(.internalServerError)
        }
        
        application.htmlkit.localization.set(source: localeSourcePath)
        application.htmlkit.localization.set(locale: "english")
        //        application.htmlkit.features = [.markdown]
    }
}
