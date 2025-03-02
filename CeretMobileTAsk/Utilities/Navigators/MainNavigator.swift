//
//  MainNavigator.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit
import CoreLocation


class MainNavigator:Navigator{
    var coordinator: Coordinator
    
    enum Destination {
        case splash
        case login
        case home(isAdmin:Bool)
        case myAttendance
        case main
        case attendanceDetails(attendanceInfo:AttendanceInfo)
        case meetings
        case meetingDetails(info:Meeting)
        case rescaduleMeeting(info:Meeting)
        case leads(isAdmin:Bool,statusId:Int?)
        case createLead
        case createMeeting
        case adminHome(isAdmin:Bool)
        case adminAttendance
        case profile
        case adminStaff
        case statusAgent(pageTitle:String,statusId:Int)
        case leadDetails(leadInfo:LeadInfo)
        case selectAction(delegate:SelectActionVCDelegate?)
        case agentDetails
        case agentReport(agentId:Int)
        case selectClient(delegate:SelectClientDelegate)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
        case .splash:
            return SplashVC(coordinator)
        case .main:
            return MainTabBarVC(coordinator: coordinator)
        case .login:
            let viewModel = LoginViewModel(loginUsecase: DefaultLoginUsecase(repo: DefaultAuthRepo(client: AuthClient())))
            return LoginVC(viewModel: viewModel, coordinator: coordinator)
        case .home(let isAdmin):
            let viewModel = HomeViewModel(leadsStatusUsecase: DefaultLeadsStatusUsecase(repo: DefaultHomeRepo(client: HomeClient())), getAllLeadsUseCase: DefaultGetAllLeadsUseCase(repo: DefaultLeadsRepo(client:LeadsClient())),
                getAllagetUseCase: DefaultGetAllAgentUsecase(repo: DefaultAgentRepo(client: AgentClient())), isAdmin: isAdmin)
            return HomeVC(viewModel: viewModel, coordinator: coordinator)
        case .adminHome(let isAdmin):
            let viewModel = HomeViewModel(
                leadsStatusUsecase: DefaultLeadsStatusUsecase(repo: DefaultHomeRepo(client: HomeClient())),
                getAllLeadsUseCase: DefaultGetAllLeadsUseCase(repo: DefaultLeadsRepo(client: LeadsClient())),
                getAllagetUseCase: DefaultGetAllAgentUsecase(repo: DefaultAgentRepo(client: AgentClient())), isAdmin: isAdmin
            )
            return AdminHomeVC(viewModel: viewModel, coordinator: coordinator)
        case .myAttendance:
            let viewModel = MyAttendanceViewModel(
                attendanceInfoForCurrentMonthUsecase: DefaultAttendanceInfoForCurrentMonthUsecase(repo: DefaultAttendanceRepo(client: AttendanceClient())),
                attendanceCheckinUsecase: DefaultAttendanceCheckinUsecase(repo: DefaultAttendanceRepo(client: AttendanceClient())),
                attendanceCheckoutUsecase: DefaultAttendanceCheckoutUsecase(repo: DefaultAttendanceRepo(client: AttendanceClient())),
                dateComparator: DateComparator(dateFormat: "dd EEE")
            )
            return MyAttendanceVC(viewModel: viewModel, coordinator: coordinator)
        case .attendanceDetails(let inf):
            let viewModel = MyAttendanceDetailsViewModel(
                attendsInf: inf,
                attendanceDetailsUsecase: DefaultAttendanceDetailsUsecase(repo: DefaultAttendanceRepo(client: AttendanceClient()))
            )
            return MyAttendanceDetailsVC(viewModel: viewModel, coordinator: coordinator)
        case .meetings:
            let viewModel = MeetingsViewModel(meetingsListUsecase: DefaultGetMeetingsListUsecase(repo: DefaultMeetingsRepo(client: MeetingClient())))
            
            return MeetingVC(viewModel: viewModel, coordinator: coordinator)
        case .meetingDetails(let info):
            let viewModel = MeetingDetailsViewModel(meetingInfo: info)
            return MeetingDetailsVC(viewModel: viewModel, coordinator: coordinator)
        case .rescaduleMeeting(let info):
            let viewModel = RescaduleMeetingViewModel(meetingInfo: info)
            return RescaduleMeetingVC(viewModel: viewModel, coordinator: coordinator)
        case .leads(let isAdmin,let statusId):
            let viewModel = TotalLeadsViewModel(getAllLeadsUseCase: DefaultGetAllLeadsUseCase(repo: DefaultLeadsRepo(client: LeadsClient())),isAdmin: isAdmin,statusId: statusId)
            return TotlaLeadsVC(viewModel: viewModel, coordinator: coordinator)
        case .createLead:
            let viewModel = CreateLeadViewModel(createLeadUsecase: DefaultCreateLeadUsecase(repo: DefaultLeadsRepo(client: LeadsClient())))
            return CreateLeadVC(viewModel: viewModel, coordinator: coordinator)
        case .createMeeting:
            let viewModel = CreateMeetingViewModel(createMeetingUseCase: DefaultCreateMeetingsUsecase(repo: DefaultMeetingsRepo(client: MeetingClient())))
            return CreateMeetingVC(viewModel: viewModel, coordinator: coordinator)
        case .adminAttendance:
            let viewModel = AdminAttendanceViewModel(adminAttendanceInfoUsecase: DefaultAdminAttendanceInfoUsecase(repo: DefaultAttendanceRepo(client: AttendanceClient())))
            return AdminAttendanceVC(viewModel: viewModel, coordinator: coordinator)
        case .profile :
            let viewModel = ProfileViewModel(logoutUsecase: DefaultLogoutUsecase(repo: DefaultAuthRepo(client: AuthClient())))
            return ProfileVC(viewModel: viewModel, coordinator: coordinator)
        case .adminStaff:
            let viewModel = AdminStaffViewModel(getAllStaffUsecase: DefaultGetAllAgentUsecase(repo: DefaultAgentRepo(client: AgentClient())))
            return AdminStaffVC(viewModel: viewModel, coordinator: coordinator)
        case .statusAgent(let title,let statusId):
            let viewModel = AgetForStatusViewModel(pageTitle: title, statusId: statusId, getStatusAgentList: DefaultGetAllAgentForStatus(repo: DefaultAgentRepo(client: AgentClient())))
            return AgentForStatusVC(viewModel: viewModel, coordinator: coordinator)
        case .leadDetails(let leadInfo):
            let viewModel = LeadInfoViewModel(leadInfo: leadInfo, actionUsecase: DefaultGetLeadActionUsecase(repo: DefaultLeadsRepo(client: LeadsClient())), setRemainderUsecase: DefaultSetLeadRemainderUsecase(repo: DefaultLeadsRepo(client: LeadsClient())),updateStatusActionUsecase: DefaultUpdateStatusActionUsecase(repo: DefaultLeadsRepo(client: LeadsClient())))
            return LeadInfoVC(viewModel: viewModel, coordinator: coordinator)
        case .selectAction(let delegate):
            let viewModel = SelectActionViewModel(actionUsecase: DefaultGetLeadActionUsecase(repo: DefaultLeadsRepo(client: LeadsClient())))
            return SelectActionVC(delegate: delegate,viewModel: viewModel, coordinator: coordinator)
        case .agentDetails:
            let viewModel = AgentDetailsViewModel()
            return AgentDetailsVC(viewModel: viewModel, coordinator: coordinator)
        case .agentReport(let agentID):
            let viewModel = AgentReportViewModel(adminGetAgentStatsUsecase: DefaultAdminGetAgentStatsUsecase(repo: DefaultAgentRepo(client: AgentClient())), agentID: agentID)
            return AgentReportVC()
        case .selectClient(let delegate):
            let viewModel = SelectClientViewModel(getAllLeadsUseCase: DefaultGetAllLeadsUseCase(repo: DefaultLeadsRepo(client: LeadsClient())))
            return SelectLeadClientVC(viewModel: viewModel, coordinator: coordinator,delegate: delegate)
        }
    }
}
