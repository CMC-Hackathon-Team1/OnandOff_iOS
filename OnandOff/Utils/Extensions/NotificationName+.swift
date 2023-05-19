//
//  NotificationName+.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import UIKit

extension Notification.Name {
    ///  표준알림창 액션감지 옵저버
    static let dismissStandardAlert = Notification.Name("dismissStandardAlert")
    
    /// 표준액션시트 액션감지 옵저버
    static let dismissStandardActionSheet = Notification.Name("dismissStandardActionSheet")
    
    /// 둘러보기 선택 카테고리 옵저버
    static let selectCategory = Notification.Name("selectCategory")

    /// 로그아웃 옵저버
    static let presentLoginVC = Notification.Name("presentLoginVC")
    
    /// 선택된 프로필 아이디가 변경 옵저버
    static let changeProfileId = Notification.Name("changeProfileId")
    
    /// 타유저피드 캘린더 헤더뷰에서 날짜 클릭 옵저버
    static let clickDay = Notification.Name("clickDay")
    
    /// 둘러보기에서 팔로우했을때 상위 뷰 업로드를 위한 옵저버
    static let clickFollow = Notification.Name("clickFollow")
    
    /// 둘러보기에서 게시글 좋아요 클릭시 상위 뷰 업로드를 위한 옵저버
    static let clickHeart = Notification.Name("clickHeart")
    
    /// 달력 '월' 변경 옵저버
    static let changeCurrentPage = Notification.Name("changeCurrentPage")
    
    /// 마이 피드 수정 /삭제 옵저버
    static let changeFeed = Notification.Name("changeFeed")
    
    /// 홈 달력 클릭시 나타나는 피드 deinit 감지 옵저버
    static let didCloseFeedWithDayVC = Notification.Name("didCloseFeedWithDayVC")
    
    /// 유저 차단 감지
    static let blockProfile = Notification.Name("blockProfile")
    
    /// 유저 차단 해제
    static let unBlockProfile = Notification.Name("unBlockProfile")
}
