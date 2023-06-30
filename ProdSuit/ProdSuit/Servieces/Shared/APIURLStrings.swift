//
//  APIURLStrings.swift
//  ProdSuit
//
//  Created by MacBook on 23/02/23.
//

import Foundation
import UIKit

// BASE URL
let APIBaseUrl = "https://202.164.150.65:14271/ProdsuiteAPI/"
let APIImageUrl = "https://202.164.150.65:14271/ProdsuiteAPI"

// BASE URL PART
let APIBaseUrlPart = "api/"
let PATH_OF_YOUR_CERT = "cer"
let OriginalCertName = "STATIC-VM01"

// BANK KEY
let BankKey = "-500"
let SKey = "PssErp22"
let encryptionEndValue = "=\n"

//let googleMapKey = "AIzaSyCGk5m5ERd70cCdGSC4H9se5VnVOcXGV5s" new created by me
let googleMapKey = "AIzaSyAcZEUnYdA9LiBcrOfmLSz7E8xGH_UKQGY"  // android key

let transMode = "LFLG"


// Request Mode List
struct RequestMode{
    
    static let shared = RequestMode()
    
    // LOGIN
    
    let MaintenanceMessage = "11"
    let ResellerDetails = "1"
    let UserLogin = "2"
    let Otp_Verification = "3"
    let SetMPIN = "4"
    let Mpin_Verification = "5"
    let ForgotMPIN = "57"
    
    // HOME
    
    let HomeBanner = "12"
    let HomeCompanyLogo = "72"
    let HomeNotificationList = "30"
    
    
    // SIDE MENU
    
    let ChangeMPIN = "6"
    
    // DASHBOARD
    
    let Chart = "38"
    
    // NOTIFICATION STATUS UPDATE
    
    let NotificationStatusUpdate = "55"
    
    // LEAD GENERATION
    
    let LeadDefaultValueLoading = "54"
    
    // LEAD GENERATION LEAD DETAILS
    
    let LeadSource = "8"
    let LeadSourceFrom = "9"
    let LeadSubMedia = "59"
    let LeadCollectedByUser = "10"
    
    let LeadCustomerSearchByNameOrMobile = "7"
    
    let LeadPinCodeDetails = "33"
    let LeadCountryDetails = "34"
    let LeadStatDetails = "34"
    let LeadDistrictDetails = "34"
    let LeadAreaDetails = "34"
    let LeadPostDetails = "34"
    let LeadCategory = "13"
    let LeadProduct = "14"
    let LeadPriority = "16"
    let LeadFollowUpAction = "17"
    let LeadFollowUpActionType = "18"
    let LeadEmployeeDetails = "23"
    let leadWalkCustomer = "24"
    
    // LEAD MANAGEMENT
    
    let leadManagementPendingCountDetails = "42"
    let leadManagementAllEmployee = "65"
    
    let lmCategoryList = "24"
    let lmTodoListLeadDetails = "64"
    let leadInfo = "28"
    let leadHistory = "45"
    let leadLocationAndImage = "29"
    let leadDocumentDetails = "47"
    
    // LMCD follow up
    
    let fd_Action = "17"
    let fd_ActionType = "18"
    let fd_followUpBy = "23"
    let fd_FollowUpStatus = "61"
    let fd_FollowUpCallStatus = "62"
    let fd_Department = "20"
   
   // COLLECTION
    
   
   let emiCRC = "100" // emi collection report count
   
   let emiRCI = "103" // emi report and customer information
    
   
   let emiET = "23" // employee type
   
    
   let emiFPT = "104" // emi finance plan type
    
    let walkInCustomer = "107" // walk in customer
    
    // SERVICE
    
    let paymentMethod = "92"
    
    
    
}

struct SubMode {
    static let Shared = SubMode()
    
    // CHART DASHBOARD
    let leads = "1"
    let leadsStatus = "2"
    let leadsStages = "3"
    let leadState = "2"
    let leadArea = "5"
    let leadCountry = "1"
    let leadDistrict = "3"
    let leadPost = "4"
    let leadFollowUpAction = "1"
    let leadWalkCustomer = "5"
    
    // LEAD MANAGEMENT CATGORY LIST MODE
    
    let lmTodo = "1"
    let lmOverdue = "2"
    let lmUpcoming = "3"
    let lmMyleads = "4"
    
    // COLLECTION REPORT TODO, OVER DUE, DEMAND SUBMODE
    
    let emiReportTodo = "1"
    let emiReportOverDue = "2"
    let emiReportDemand = "3"
   
    
    
   
    
    
    
}

// URL SUB API PATH
struct URLPathList{
    static let Shared = URLPathList()
    
    // login section
    let commonApp = "AppDetails/GetAppType"
    let companyCode = "AppDetails/GetCompanyCode"
    let app_MaintenanceMessage = "UserValidations/MaintenanceMessage"
    let app_Reseller = "UserValidations/ResellerDetails"
    let login = "UserValidations/UserLogin"
    let otp_Verification = "UserValidations/Verification"
    let setMpin_Verification = "UserValidations/SetMPIN"
    let verifyMpin = "UserValidations/Verification" // after login
    let forgotMpin = "UserValidations/ForgotMPIN"
    
    // home section
    let homeBanners = "UserValidations/BannerDetails"
    let homeCompanyLogoDetails = "UserValidations/CompanyLogDetails"
    let homeNotificationList = "UserValidations/NotificationDetailsList"
    let notificationStatusUpdate = "UserValidations/UpdateNotificationStatus"
    
    // side menu section
    let changeMPIN = "UserValidations/ChangeMPIN"
    
    // dashboard chart section
    let chart = "UserValidations/LeadsDashBoardDetails"
    
    // Lead genaeration
    let defaultValueLoading = "UserValidations/LeadGenerationDefaultvalueSettings"
    
    let leadSource = "UserValidations/LeadFromDetailsList"
    let leadSourceFrom = "UserValidations/LeadThroughDetails"
    let leadMediaSubmedia = "UserValidations/SubMediaTypeDetails"
    let leadCollectedByUser = "UserValidations/CollectedByUsers"
    
    let leadCustomerSearchByNameOrMobile = "UserValidations/CustomerDetails"
    
    let leadPincodeDetails = "UserValidations/PincodeDetails"
    let leadCountryDetails = "UserValidations/CountryDetails"
    let leadStatDetails = "UserValidations/StatesDetails"
    let leadDistrictDetails = "UserValidations/DistrictDetails"
    let leadAreaDetails = "UserValidations/AreaDetails"
    let leadPostDetails = "UserValidations/PostDetails"
    
    let leadCategory = "UserValidations/CategoryDetails"
    let leadProduct = "UserValidations/ProductDetails"
    let leadPriority = "UserValidations/PriorityDetails"
    let leadFollowUpAction = "UserValidations/FollowUpActionDetails"
    let leadFollowUpActionType = "UserValidations/FollowUpTypeDetails"
    let LeadEmployeeDetails = "UserValidations/EmployeeDetails"
    let leadUploadDocuments = "UserValidations/AddDocument"
    let leadGeneration = "UserValidations/UpdateLeadGeneration"
    let leadWalkingCustomer = "UserValidations/WalkingCustomerDetailsList"
    
    // LEAD MANAGEMENT APIS
    
    let leadManagementPendingCountDetails = "UserValidations/PendingCountDetails"
    let leadManagementAllEmployee = "UserValidations/EmployeeAllDetails"
    let lmCategoryList = "UserValidations/LeadManagementDetailsList"
    let lmTodoListLeadDetails = "UserValidations/ToDoListLeadDetails"
    
    let leadInfo = "UserValidations/LeadInfoDetails"
    let leadHistory = "UserValidations/ActivitiesDetails"
    let leadLocationAndImage = "UserValidations/LeadImageDetails"
    let leadDocumentDetails = "UserValidations/DocumentDetails"
    let leadManageDocumentDownLoad = "UserValidations/DocumentImageDetails"
    
    //FOLLOW UP API
    
    let fd_ActionType = "UserValidations/FollowUpTypeDetails"
        let fd_Action = "UserValidations/FollowUpActionDetails"
    let fd_FollowUpBy = "UserValidations/EmployeeDetails"
    let fd_FollowUpStatus = "UserValidations/StatusDetails"
    let fd_Priority = "UserValidations/PriorityDetails"
    let fd_Department = "UserValidations/DepartmentDetails"
    let fd_UpdateLeadManagement = "UserValidations/UpdateLeadManagement"
    let walkInCustomer = "UserValidations/WalkingCustomerAssignedTo"
    let walkInCustomerUpdation = "UserValidations/UpdateWalkingCustomer"
    
    // EMI COLLECTION
    
    let emiCRC = "EMICollection/EMICollectionReportCount"
    let  emiFinanceType = "EMICollection/FinancePlanTypeDetails"
    let emiReport = "EMICollection/EMICollectionReport"
    let emiEmployee = "UserValidations/EmployeeDetails"
    let emiAccount_customerDetails = "EMICollection/EMIAccountDetails"
    let emiUpdate = "EMICollection/UpdateEMICollection"
    
    
    // SERVICE
    let PaymentMethod = "ServiceFollowUp/FollowUpPaymentMethod"
    
    
    
    
}



// CERTIFICATE BINDING TO URLSESSION
class MySessionDelegate : NSObject,URLSessionDelegate {
     public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
         if let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0
         {
             if let certificate = SecTrustGetCertificateAtIndex(trust, 0)
             {
                 let data = SecCertificateCopyData(certificate) as Data
                 if certificates.contains(data)
                 {
                     completionHandler(.useCredential,URLCredential(trust: trust))
                     return
                 }
             }
         }
         completionHandler(.cancelAuthenticationChallenge,nil)
     }
}

// FETCH SECURITY CERTIFICATE
public var certificates: [Data] =
{
    
    let url = Bundle.main.url(forResource: OriginalCertName, withExtension: PATH_OF_YOUR_CERT)
    let data = try! Data(contentsOf: url!)
    return [data]
    
    
}()
