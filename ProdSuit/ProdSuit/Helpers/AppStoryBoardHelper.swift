//
//  AppStoryBoardHelper.swift
//  ProdSuit
//
//  Created by MacBook on 14/02/23.
//

import Foundation
import UIKit

enum AppStoryBoard:String{
    
    case Main = "Main"
    case Dashboard = "Dashboard"
    case Collection = "Collection"
    
    func InstantiateVC(identifiter:String) -> UIViewController {
        return UIStoryboard.init(name: rawValue, bundle: nil).instantiateViewController(withIdentifier: identifiter)
    }
    
   
    
    
}

struct NibController {
    static let shared = NibController()
    let lmMessageVc = "LmListMessageVC"
}

struct CellIdentifier{
    static let shared = CellIdentifier()
    let notificationCell = "notificationTVC"
    let leadGenerationCell = "leadGenerationTVC"
    let leadCustomerDetailCell1 = "customerDetailsTVC1"
    let leadCustomerDetailCell2 = "customerDetailsTVC2"
    let leadCustomerDetailCell3 = "customerDetailsTVC3"
    let leadMoreCommunicationInfoCell = "moreCommunicationInfoTVC"
    let leadProjectProductDetailsCell = "projectProductDetailsTVC"
    let leadLocationDetailsCell = "locationDetailsTVC"
    let leadUploadImageViewCell = "uploadImageViewTVC"
    let leadGenConfirmCell = "leadGenConfirmTVC"
    let leadRequestCell = "leadRequestTVC"
    let leadManagementCategoryListCell = "leadManagementCategoryListTVC"
    let leadManagementInfoCell = "leadManagementInfoTVC"
    let leadManagementHistoryCell = "leadManagementHistoryTVC"
    let leadManagementDocumentUploadCell = "lMDDocumentUploadTVC"
    
    // COLLECTION
    
    let emiCategoriesListingCell = "eMICategoriesListingTVC"
    let emiDetailsCell = "eMIDetailsTVC"
    let emiPaymentMethodCell = "paymentMethodAddTVC"
    
}

struct AppIdentifier{
    
    static let shared = AppIdentifier()
    let LoginSlider_ID = "homeSliderVC"
    let Splash_ID = "splashScreenVC"
    let Login_Slider_Page_ID = "firstSliderVC"
    let Welcome_VC_ID = "welcomeVC"
    let Login_VC_ID = "loginVC"
    let Otp_VC_ID = "oTPVC"
    let SetMpin_VC_ID = "setMpinVC"
    let Mpin_VC_ID = "mpinVC"
    let Forgot_VC_ID = "forgotMpin"
    
    // DASHBOARD VC'S
    
    let Dashboard_VC_ID = "dashboardVC"
    let Reminder_VC_ID = "reminderVC"
    
    let Profile_VC_ID = "profileVC"
    let ChangeMpin_VC_ID = "changeMpinVC"
    let About_VC_ID = "aboutUsVC"
    let Contact_VC_ID = "contactUsVC"
    
    // DASHBOARD MENU VC'S
    
    let Chart_VC_ID = "chartVC"
    let Chart_POP_UP_VC_ID = "chartPOPUPVC"
    let Notification_VC_ID = "notificationVC"
    let ReadNotification_VC_ID = "notificationReadVC"
    
    // LEADS MENU VC'S
    
    let LEADS_VC_ID = "leadsVC"
    
    
    let LEAD_MANAGEMENT_VC_ID = "leadManagementVC"
    
    let LEAD_WLK_CUST_ID = "walkingCustomerVC"
    
    
    let LEAD_GENERATION_VC_ID = "leadGenerationVC"
    
    //let Reusable_Table_VC_ID = "reusableTableVC"
    
    let MAP_VC_ID = "mapviewVC"
    
    let LEAD_GEN_CONFIRM_VC_ID = "leadGenConfirmVC"
    
    let LEAD_MANAGEMENT_FILTER_ID = "leadManagementFilterVC"
    
    //let LEAD_MANAGEMENT_OVERDUE_ID = "leadManagementOverDueVC"
    
    let LEAD_MANAGEMENT_CATEGORY_LIST_ID = "lManagementCategoryListVC"
    let LEAD_MANAGEMENT_CATEGORY_LIST_FILTER_ID = "lMCategoryListFilterVC"
    let LEAD_MANAGEMENT_CATEGORY_LIST_MESSAGE_ID = "lmListMessageVC"
    let LEAD_MANAGEMENT_CATEGORY_LIST_Details_ID = "lMCategoryListDetailVC"
    
    let LEAD_MANAGEMENT_DETAILS_LOAD_ID = "lMCListLoadDetailsVC"
    
    let LEAD_MANAGEMENT_DETAIL_INFO = "lMCategoryDetailsInfoVC"
    
    let LEAD_MANAGEMENT_DETAIL_LOCATION = "lMCategoryDetailsLocationVC"
    
    let LEAD_MANAGEMENT_DETAIL_IMAGE = "lMCategoryDetailsImageVC"
    
    let LEAD_MANAGEMENT_DETAIL_DOCUMENT = "lMCategoryDetailsDocumentVC"
    
    let LMCD_FOLLOUP = "lMCDFollowUpDetailsVC"
    
    let LMCD_DOC_UPLOAD = "lMCDAttachDocVC"
    
    
    // Collection VC s
    
    let EMI_CATEGORIES = "emiCategoriesVC"
    let EMI_CATEGORIES_LISTING = "emiCategoriesListingVC"
    let EMI_COLLECTION_DETAILS = "emiCollectionDetailsVC"
    
}


struct AppVC{
    
    static let Shared = AppVC()
    
    private init(){}
    
    let Splash = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Splash_ID) as! SplashScreenVC
    
    let LoginSlider = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.LoginSlider_ID) as! HomeSliderVC
    
    let LoginSliderPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Login_Slider_Page_ID) as! FirstSliderVC
    
    let WelcomePage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Welcome_VC_ID) as! WelcomeVC
    
    let LoginPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Login_VC_ID) as! LoginVC
    
    let OtpPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Otp_VC_ID) as! OTPVC
    
    let SetMpinPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.SetMpin_VC_ID) as! SetMpinVC
    
    let MpinPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Mpin_VC_ID) as! MpinVC
    
    let ForgotMpinPage = AppStoryBoard.Main.InstantiateVC(identifiter: AppIdentifier.shared.Forgot_VC_ID) as! ForgotMpin
    
    
    
    
    
    // DASHBOARD VC'S
    
    let DashboardPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Dashboard_VC_ID) as! DashboardVC
    
    let ReminderPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Reminder_VC_ID) as! ReminderVC
    
    let ProfilePage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Profile_VC_ID) as! ProfileVC
    
    let ChangeMpinPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.ChangeMpin_VC_ID) as! ChangeMpinVC
    
    let AboutPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.About_VC_ID) as! AboutUsVC
    
    let ContactUsPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Contact_VC_ID) as!
    ContactUsVC
    
    
    // HOME MENU DASHBOARD AND NOTIFICATION SECTION
    
    let ChartPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Chart_VC_ID) as! ChartVC
    
    let ChartPopUpPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Chart_POP_UP_VC_ID) as! ChartPOPUPVC
    
    let NotificationPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.Notification_VC_ID) as! NotificationVC
    
    let ReadNotificationPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.ReadNotification_VC_ID) as! NotificationReadVC
    
    // HOME MENUE LEAD SECTION
    
    let leadsPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEADS_VC_ID) as! LeadsVC
    
    let leadGenerationPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_GENERATION_VC_ID) as! LeadGenerationVC
    
    let mapViewPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.MAP_VC_ID) as! MapviewVC
    
    let leadGenConfirmPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_GEN_CONFIRM_VC_ID) as! LeadGenConfirmVC
    
    let leadManagementPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_VC_ID) as! LeadManagementVC
    
    let walkingCustomerPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_WLK_CUST_ID) as! WalkingCustomerVC
    
    let leadManagementFilterPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_FILTER_ID) as! LeadManagementFilterVC
    
    
    //let leadManagementOveDuePage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_OVERDUE_ID) as! LeadManagementOverDueVC
    
    let leadManagementCategoryList = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_CATEGORY_LIST_ID) as! LManagementCategoryListVC
    
    let lmCategoryListFilter = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_CATEGORY_LIST_FILTER_ID) as! LMCategoryListFilterVC
    
    let lmTodoMessagePage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_CATEGORY_LIST_MESSAGE_ID) as! LmListMessageVC
    
    let lmTodoCategoryListDetailPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_CATEGORY_LIST_Details_ID) as! LMCategoryListDetailVC
    
    let lmDetailsLoadPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_DETAILS_LOAD_ID) as! LMCListLoadDetailsVC
    
    
    let lmDetailsInfoPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_DETAIL_INFO) as! LMCategoryDetailsInfoVC
    
    
    let lmDetailsLocationPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_DETAIL_LOCATION) as! LMCategoryDetailsLocationVC
    
    let lmDetailsImagePage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_DETAIL_IMAGE) as! LMCategoryDetailsImageVC
    
    let lmDetailsDocumentPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LEAD_MANAGEMENT_DETAIL_DOCUMENT) as! LMCategoryDetailsDocumentVC
    
    let lmCDFollowUpPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LMCD_FOLLOUP) as! LMCDFollowUpDetailsVC
    
    let lmCDDocUploadPage = AppStoryBoard.Dashboard.InstantiateVC(identifiter: AppIdentifier.shared.LMCD_DOC_UPLOAD) as! LMCDAttachDocVC
    
    // EMI VC'S
    
    let emiCategories = AppStoryBoard.Collection.InstantiateVC(identifiter: AppIdentifier.shared.EMI_CATEGORIES) as! EmiCategoriesVC
    
    let emiCategoriesListing = AppStoryBoard.Collection.InstantiateVC(identifiter: AppIdentifier.shared.EMI_CATEGORIES_LISTING) as! EmiCategoriesListingVC
    
    let emiCollectionDetails = AppStoryBoard.Collection.InstantiateVC(identifiter: AppIdentifier.shared.EMI_COLLECTION_DETAILS) as! EmiCollectionDetailsVC
    
    
    
    func initiateToRootViewController(){
        
        
        let story = UIStoryboard(name: AppStoryBoard.Main.rawValue, bundle:nil)
        let rootVc = story.instantiateInitialViewController()
        
        UIApplication.shared.windows.first?.rootViewController = rootVc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
