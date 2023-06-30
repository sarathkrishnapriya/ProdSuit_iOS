//
//  General.swift
//  ProdSuit
//
//  Created by MacBook on 15/02/23.
//

import Foundation
import UIKit




struct OnboardModel{
 var image : String
  var title : String
   var details : String
}

let loginMpin_OtpCount =  6

 let mobileNumberMaxLength = 11
 let messageMaxLength = 300
 let mpinCount = 6
 let onBoardDetailsList : [OnboardModel] = [OnboardModel(image: "slider1", title: "ERP SOLUTIONS", details: "An ERP system, enables businesses to identify waste, eliminate inefficiencies, improve customer relations and facilitate real-time collaboration. ERP systems enable businesses to have greater insight and visibility into their supply chain operations."),OnboardModel(image: "slider2", title: "ERP SOLUTIONS FOR MANUFACTURING INDUSTRY", details: "At its core, an ERP is an application that automates business processes, and provides insights and internal controls, drawing on a central database that collects inputs from departments including accounting, manufacturing, supply chain management, sales, marketing and human resources."),OnboardModel(image: "slider3", title: "GROW YOUR BUSINESS WITH ERP SOFTWARE", details: "ERP refers to a type of software that organisations use to manage day-to-day business activities such as accounting, procurement, project management, risk management and compliance, and supply chain operations.")]


let welcome_screen_details = "Let's get started, be ready to activate your account. This application will advantage you in many ways and also makes your works done effortlessly"

let welcome_screen_title = "Welcome Back"

let welcome_screeen_btn_title_name = "GET STARTED"

let login_button_name = "CONTINUE"

let login_topview_details = "Please login to your account by entering your credentials, we will sent you an OTP to verify your mobile number"

let networkMsg = "Please check yout internet connected properly"
let networkTitle = "Network"
let generalErrorMsg = "Something went wrong. Do you want to continue"
let closeTitle = "Close"
let noDataString = "No data found."
let okTitle = "Ok"
let retryTitle = "Retry"
let cancelTitle = "Cancel"
let submitTitle = "Submite"
let searchTitle = "Search"
let loginSuccessText = "Successfully logged in"
let locationLoginMessage = "Please turn on location service for site verification request"
let otpTitle = "OTP"
let otpInvalid = "Please enter valid OTP Code"
let confirmationTitle = "Confirmation"
let setMpinMessage = "Do you want to set this number as your app M-Pin ?"
let yesTitle = "Yes"
let no_cancel_title = "No"
let logoutMessage = "Do you want to logout ?"
let quitMessage = "Do you want to quit ?"

let logoutTitle = "Log out"
let mobileNumberErrorMessage = "Please enter valid mobile number"

let changeMPINErrorMessage = "MPIN must be \(mpinCount) digits"
let mIsmatchMPINErrorMessage = "New MPIN and Confirm MPIN does not match"
let successMPINChangeMessage = "MPIN changed successfully"

let shareTextMessage = "ProdSuit Invite You\n"
let shareFocusPeopleTextMessage = "For iOS Users\n"


//LEAD GENERATION

let leadSourcePlaceholderText = "Lead Source"
let leadCustomerDetailByNameMobile = "Name"
let leadSourceSubMediaPlaceholderText = "Sub Media"

let leadDetailsDateMessage = "Select enquiry date"

